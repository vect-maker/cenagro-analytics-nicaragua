default:
  @just --list

enter:
  zellij --layout .ide/dev.kdl

build-python-container:
  podman build -f infra/python.Containerfile -t python-runtime:dev .

run-python *args="":
  podman run -it --rm \
    --userns=keep-id \
    --security-opt label=disable \
    -v $(pwd):/app:Z \
    -w /app \
    python-runtime:dev python3 {{args}}

python-shell:
  podman run -it --rm \
    --userns=keep-id \
    --security-opt label=disable \
    -v $(pwd):/app:Z \
    -w /app \
    python-runtime:dev /bin/bash

download-data *args="":
  podman run -it --rm \
    --userns=keep-id \
    --security-opt label=disable \
    -v $(pwd):/app:Z \
    -w /app \
    python-runtime:dev python3 pipes/download.py {{args}}

ingest-data:
  podman run -it --rm \
    --userns=keep-id \
    --security-opt label=disable \
    -v $(pwd):/app:Z \
    -w /app \
    python-runtime:dev python3 pipes/ingest.py

setup-bi:
  podman run -it --rm \
    --userns=keep-id \
    -p 3000:3000 \
    -v ./analytics:/app:Z \
    -w /app \
    evidence-dev-image npm ci

build-bi-container:
  podman build -f infra/evidence.Containerfile -t evidence-dev-image .

add-meta-bi:
  [ -d analytics/node_modules ] || just setup-bi
  podman run -it --rm \
    --userns=keep-id \
    -v ./analytics:/app:Z \
    -w /app \
    evidence-dev-image npm run sources -- --changed

build-werehouse:
  duckdb analytics/sources/warehouse/warehouse.duckdb -init sql/build-warehouse.sql -c ".exit"

refresh-data:
  just build-werehouse
  just add-meta-bi

run-bi:
  [ -d analytics/node_modules ] || just setup-bi
  -podman rm -f evidence-dev
  podman run -it --rm \
    --userns=keep-id \
    --name evidence-dev \
    -p 3000:3000 \
    -v ./analytics:/app:Z \
    -w /app \
    evidence-dev-image /bin/sh -c "npm run sources -- --watch & npm run dev -- --host 0.0.0.0"

build-bi:
  [ -d analytics/node_modules ] || just setup-bi
  podman run -it --rm \
    --userns=keep-id \
    -v ./analytics:/app:Z \
    -w /app \
    evidence-dev-image npm run build

build-compiler:
  podman build -f infra/compiler.Containerfile -t compiler-integrador-3:dev ./etl

build-pipeline:
  podman build -f infra/transformer.Containerfile -t localhost/transformer-integrador-3:dev ./etl

run-pipeline:
  podman run -it --rm \
    --userns=keep-id \
    --security-opt label=disable \
    -v $(pwd)/data:/app/data:Z \
    -e FARMS_PATH=data/cenagro-2011-explotaciones-agropecuarias.parquet \
    -e PARCELS_PATH=data/cenagro-2011-parcelas-aprovechamiento-tierra.parquet \
    -e OUT_DIR=data \
    localhost/transformer-integrador-3:dev

compile-paper: export-paper-data compile-monograph compile-abstract compile-slides

compile-monograph:
  mkdir -p docs
  typst compile paper/main.typ docs/main.pdf

compile-abstract:
  mkdir -p docs
  typst compile paper/abstract.typ docs/abstract.pdf

compile-resumen: compile-abstract

render-diagrams:
  mkdir -p paper/images/presentation
  podman run --rm -u 0:0 -v $(pwd)/paper:/data:Z ghcr.io/mermaid-js/mermaid-cli/mermaid-cli -i /data/diagrams/diagram-architecture.mmd -o /data/images/presentation/diagram-architecture.png -b transparent -s 2.5
  podman run --rm -u 0:0 -v $(pwd)/paper:/data:Z ghcr.io/mermaid-js/mermaid-cli/mermaid-cli -i /data/diagrams/diagram-etl.mmd -o /data/images/presentation/diagram-etl.png -b transparent -s 2.5
  podman run --rm -u 0:0 -v $(pwd)/paper:/data:Z ghcr.io/mermaid-js/mermaid-cli/mermaid-cli -i /data/diagrams/diagram-warehouse.mmd -o /data/images/presentation/diagram-warehouse.png -b transparent -s 2.5

compile-slides:
  mkdir -p docs
  typst compile --font-path paper/fonts paper/slides.typ docs/slides.pdf


preview-paper:
  mkdir -p paper/preview
  typst compile --format png --ppi 150 paper/main.typ paper/preview/main-{n}.png

preview-abstract:
  mkdir -p paper/preview
  typst compile --format png --ppi 150 paper/abstract.typ paper/preview/abstract-{n}.png

preview-resumen: preview-abstract

preview-slides:
  mkdir -p paper/preview/slides
  rm -f paper/preview/slides/*.png
  typst compile --font-path paper/fonts --format png --ppi 150 paper/slides.typ paper/preview/slides/slide-{n}.png

export-paper-data:
  mkdir -p paper/data
  duckdb -dark-mode analytics/sources/warehouse/warehouse.duckdb -init sql/export-paper-data.sql -c ".exit"


watch-paper:
  mkdir -p docs
  typst watch paper/main.typ docs/main.pdf

watch-slides:
  mkdir -p docs
  typst watch --font-path paper/fonts paper/slides.typ docs/slides.pdf

compare-paper:
  mkdir -p paper/comparison/original paper/comparison/typst docs
  [ -f documento.pdf ] && pdftoppm -png -r 150 documento.pdf paper/comparison/original/page || true
  pdftoppm -png -r 150 docs/main.pdf paper/comparison/typst/page

compare-slides:
  mkdir -p paper/comparison/slides/original paper/comparison/slides/typst
  rm -f paper/comparison/slides/original/*.png paper/comparison/slides/typst/*.png
  pdftoppm -png -r 150 "diapositivaJUDC.pdf" paper/comparison/slides/original/slide
  typst compile --font-path paper/fonts --format png --ppi 150 paper/slides.typ paper/comparison/slides/typst/slide-{n}.png

