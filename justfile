default:
  @just --list

enter:
  zellij --layout .ide/dev.kdl

build-bi-container:
  podman --remote build -f infra/evidence.Containerfile -t evidence-dev-image .

add-meta-bi:
  podman --remote run -it --rm \
    -v ./analytics:/app:Z \
    -w /app \
    evidence-dev-image npm run sources -- --changed

run-bi:
  -podman --remote rm -f evidence-dev
  podman --remote run -it --rm \
    --name evidence-dev \
    -p 3000:3000 \
    -v ./analytics:/app:Z \
    evidence-dev-image /bin/sh -c "npm run sources -- --watch & npm run dev -- --host 0.0.0.0"

build-bi:
  podman --remote run -it --rm \
    -v ./analytics:/app:Z \
    -w /app \
    evidence-dev-image npm run build

build-compiler:
  podman --remote build -f infra/compiler.Containerfile -t compiler-integrador-3:dev ./etl

build-pipeline:
  podman --remote build -f infra/transformer.Containerfile -t localhost/transformer-integrador-3:dev ./etl

run-pipeline: 
  podman --remote run -it --rm \
    --userns=keep-id \
    --security-opt label=disable \
    -v $(pwd)/data:/app/data:Z \
    -e FARMS_PATH=data/cenagro-2011-explotaciones-agropecuarias.parquet \
    -e PARCELS_PATH=data/cenagro-2011-parcelas-aprovechamiento-tierra.parquet \
    -e OUT_DIR=data \
    localhost/transformer-integrador-3:dev

build-werehouse:
  duckdb analytics/sources/warehouse/warehouse.duckdb -init sql/build-warehouse.sql -c ".exit"
