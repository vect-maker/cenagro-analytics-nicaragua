#import "slides-template.typ": *
#import "charts.typ": *
#import "metadata.typ": *
#import "content/objectives.typ": *
#import "content/figures.typ": fig-caption, fig-ref

#show: cenagro-theme.with()

// ============================================================
// DIAPOSITIVA 1: PORTADA
// ============================================================
#title-slide(
  title: title,
  authors: authors,
  tutor: tutor,
)

// ============================================================
// DIAPOSITIVA 2: PROBLEMA Y CONTEXTO
// ============================================================
= Problema y contexto de la investigación

#speaker-marker("A")

#let universe-data = csv("data/census_universe.csv").slice(1).at(0)

// --- SECCIÓN SUPERIOR: UNIVERSO CENSAL Y BRECHA EMPÍRICA ---
#grid(
  columns: (382pt, 1fr),
  gutter: 14pt,
  // 1. Métricas del Universo Censal (obtenidas directamente de DuckDB vía CSV)
  grid(
    columns: (1fr, 1fr),
    gutter: 10pt,
    // Métrica 1: Universo Censal Total
    block(
      fill: rgb("#f6f3fa"),
      stroke: 1.1pt + color-title.lighten(65%),
      radius: 9pt,
      inset: (x: 12pt, y: 10pt),
      height: 106pt,
      stack(
        dir: ttb,
        spacing: 4pt,
        box(
          fill: color-title.lighten(88%),
          radius: 3pt,
          inset: (x: 5pt, y: 2pt),
          text(size: 7.8pt, weight: "bold", fill: color-title, font: font-heading)[UNIVERSO CENSAL]
        ),
        v(1pt),
        block(
          text(size: 24pt, weight: "bold", fill: color-title, font: font-heading)[262,546]
        ),
        block(
          text(size: 10.5pt, weight: "bold", fill: color-accent, font: font-body)[Fincas censadas]
        ),
        block(
          text(size: 8.8pt, fill: rgb("#556270"), font: font-body)[100% cobertura en 153 municipios]
        )
      )
    ),
    // Métrica 2: Subconjunto Financiado (Contraste empírico del estudio)
    block(
      fill: rgb("#f4f7fc"),
      stroke: 1.1pt + color-accent.lighten(65%),
      radius: 9pt,
      inset: (x: 12pt, y: 10pt),
      height: 106pt,
      stack(
        dir: ttb,
        spacing: 4pt,
        box(
          fill: color-accent.lighten(88%),
          radius: 3pt,
          inset: (x: 5pt, y: 2pt),
          text(size: 7.8pt, weight: "bold", fill: color-accent, font: font-heading)[GRUPO FINANCIADO]
        ),
        v(1pt),
        block(
          text(size: 24pt, weight: "bold", fill: color-accent, font: font-heading)[38,680]
        ),
        block(
          text(size: 10.5pt, weight: "bold", fill: color-title, font: font-body)[Fincas con crédito (14.7%)]
        ),
        block(
          text(size: 8.8pt, fill: rgb("#556270"), font: font-body)[Población de contraste del estudio]
        )
      )
    )
  ),
  // 2. Tarjeta de Vacío Empírico en la Literatura (alineada en altura exacta con las métricas)
  block(
    fill: color-card-bg,
    stroke: 1.1pt + color-card-stroke,
    radius: 9pt,
    inset: (x: 14pt, y: 10pt),
    height: 106pt,
    stack(
      dir: ttb,
      spacing: 5pt,
      grid(
        columns: (22pt, 1fr),
        gutter: 7pt,
        align: (center + horizon, left + horizon),
        box(
          fill: rgb("#c0392b"),
          radius: 5pt,
          width: 22pt,
          height: 22pt,
          align(center + horizon, box(width: 14pt, slide-icons.alert-circle))
        ),
        [
          #text(size: 13.2pt, weight: "bold", fill: color-title, font: font-heading)[Vacío Empírico en la Literatura] \
          #text(size: 8.8pt, fill: color-accent, font: font-body)[Limitaciones del análisis agrario previo en Nicaragua]
        ]
      ),
      line(length: 100%, stroke: 0.5pt + rgb("#eee8f6")),
      block[
        #set text(size: 10.2pt, fill: color-body, font: font-body)
        #set par(leading: 0.40em)
        Superación del *sesgo de agregación* de muestras reducidas y del *falso dilema de ventanilla*, demostrando que la exclusión surge por autoexclusión y riesgo patrimonial (*Sen*).
      ],
      v(3pt),
      // Pills metodológicos de rigor
      grid(
        columns: (auto, auto, auto),
        gutter: 6pt,
        box(
          fill: rgb("#f3eef8"),
          radius: 3pt,
          inset: (x: 5.5pt, y: 2.2pt),
          text(size: 8pt, weight: "bold", fill: color-title, font: font-heading)[Microdatos Censales]
        ),
        box(
          fill: rgb("#eef3f8"),
          radius: 3pt,
          inset: (x: 5.5pt, y: 2.2pt),
          text(size: 8pt, weight: "bold", fill: color-accent, font: font-heading)[Heterogeneidad Real]
        ),
        box(
          fill: rgb("#eaf5f5"),
          radius: 3pt,
          inset: (x: 5.5pt, y: 2.2pt),
          text(size: 8pt, weight: "bold", fill: rgb("#008080"), font: font-heading)[Sin Sesgo Muestral]
        )
      )
    )
  )
)

#v(14pt)

// --- SECCIÓN INFERIOR: TRES PARADOJAS CIENTÍFICAS A CONTRASTAR ---
#grid(
  columns: (22pt, 1fr),
  gutter: 7pt,
  align: (center + horizon, left + horizon),
  box(
    fill: color-accent,
    radius: 4pt,
    width: 22pt,
    height: 22pt,
    align(center + horizon, box(width: 14pt, slide-icons.help-circle))
  ),
  [
    #text(size: 14pt, weight: "bold", fill: color-title, font: font-heading)[Las Tres Paradojas Científicas a Contrastar]
  ]
)

#v(8pt)

#grid(
  columns: (1fr, 1fr, 1fr),
  gutter: 12pt,
  // Paradoja 1: Crédito
  block(
    fill: rgb("#fbfafc"),
    stroke: 1.1pt + color-title.lighten(60%),
    radius: 9pt,
    inset: (x: 13pt, y: 12pt),
    height: 152pt,
    stack(
      dir: ttb,
      spacing: 6pt,
      grid(
        columns: (auto, 1fr),
        align: (horizon + left, horizon + right),
        box(
          fill: color-title,
          radius: 3pt,
          inset: (x: 6pt, y: 2.2pt),
          text(size: 8pt, weight: "bold", fill: white, font: font-heading)[01 #sym.bar.v CRÉDITO]
        ),
        box(
          fill: color-title.lighten(90%),
          radius: 3pt,
          inset: (x: 5pt, y: 2pt),
          text(size: 7.5pt, weight: "bold", fill: color-title, font: font-heading)[Paradoja Asignación]
        )
      ),
      block(
        text(size: 15pt, weight: "bold", fill: color-title, font: font-heading)[¿Fricción o Riesgo?]
      ),
      line(length: 100%, stroke: 0.5pt + color-title.lighten(70%)),
      block[
        #set par(leading: 0.44em)
        #text(size: 11.5pt, fill: color-body, font: font-body)[
          ¿Rechazo bancario en ventanilla o autoexclusión previa por temor a la pérdida patrimonial de la tierra?
        ]
      ],
      v(2pt),
      block(
        fill: rgb("#f3eef8"),
        stroke: 0.6pt + rgb("#d8d0e8"),
        radius: 5pt,
        inset: (x: 8pt, y: 6.5pt),
        width: 100%,
        [
          #set par(leading: 0.40em)
          #text(size: 9.8pt, fill: color-title, font: font-body)[
            *Hipótesis:* La exclusión no opera en ventanilla sino en el racionamiento por riesgo colateral.
          ]
        ]
      )
    )
  ),
  // Paradoja 2: Empleo
  block(
    fill: rgb("#fbfafc"),
    stroke: 1.1pt + color-accent.lighten(60%),
    radius: 9pt,
    inset: (x: 13pt, y: 12pt),
    height: 152pt,
    stack(
      dir: ttb,
      spacing: 6pt,
      grid(
        columns: (auto, 1fr),
        align: (horizon + left, horizon + right),
        box(
          fill: color-accent,
          radius: 3pt,
          inset: (x: 6pt, y: 2.2pt),
          text(size: 8pt, weight: "bold", fill: white, font: font-heading)[02 #sym.bar.v EMPLEO]
        ),
        box(
          fill: color-accent.lighten(90%),
          radius: 3pt,
          inset: (x: 5pt, y: 2pt),
          text(size: 7.5pt, weight: "bold", fill: color-accent, font: font-heading)[Dualismo Laboral]
        )
      ),
      block(
        text(size: 15pt, weight: "bold", fill: color-accent, font: font-heading)[¿Digno o Temporal?]
      ),
      line(length: 100%, stroke: 0.5pt + color-accent.lighten(70%)),
      block[
        #set par(leading: 0.44em)
        #text(size: 11.5pt, fill: color-body, font: font-body)[
          ¿Multiplicador de empleo formal continuo o mayor dependencia de jornales temporales de zafra y cosecha?
        ]
      ],
      v(2pt),
      block(
        fill: rgb("#f0f4fa"),
        stroke: 0.6pt + rgb("#cbd9ec"),
        radius: 5pt,
        inset: (x: 8pt, y: 6.5pt),
        width: 100%,
        [
          #set par(leading: 0.40em)
          #text(size: 9.8pt, fill: color-accent, font: font-body)[
            *Hipótesis:* El crédito absorbe mano de obra estacional pero sin estabilidad contractual continua.
          ]
        ]
      )
    )
  ),
  // Paradoja 3: Suelo
  block(
    fill: rgb("#fbfafc"),
    stroke: 1.1pt + rgb("#008080").lighten(60%),
    radius: 9pt,
    inset: (x: 13pt, y: 12pt),
    height: 152pt,
    stack(
      dir: ttb,
      spacing: 6pt,
      grid(
        columns: (auto, 1fr),
        align: (horizon + left, horizon + right),
        box(
          fill: rgb("#008080"),
          radius: 3pt,
          inset: (x: 6pt, y: 2.2pt),
          text(size: 8pt, weight: "bold", fill: white, font: font-heading)[03 #sym.bar.v SUELO]
        ),
        box(
          fill: rgb("#008080").lighten(90%),
          radius: 3pt,
          inset: (x: 5pt, y: 2pt),
          text(size: 7.5pt, weight: "bold", fill: rgb("#008080"), font: font-heading)[Restricción Boserup]
        )
      ),
      block(
        text(size: 15pt, weight: "bold", fill: rgb("#008080"), font: font-heading)[¿Diversificación?]
      ),
      line(length: 100%, stroke: 0.5pt + rgb("#008080").lighten(70%)),
      block[
        #set par(leading: 0.44em)
        #text(size: 11.5pt, fill: color-body, font: font-body)[
          ¿Reconversión hacia cultivos perennes de alto valor o persistencia en pastos ganaderos extensivos?
        ]
      ],
      v(2pt),
      block(
        fill: rgb("#eff8f8"),
        stroke: 0.6pt + rgb("#c3e5e5"),
        radius: 5pt,
        inset: (x: 8pt, y: 6.5pt),
        width: 100%,
        [
          #set par(leading: 0.40em)
          #text(size: 9.8pt, fill: rgb("#008080"), font: font-body)[
            *Hipótesis:* El crédito impulsa diversificación perenne rompiendo la inercia ganadera extensiva.
          ]
        ]
      )
    )
  )
)

// ============================================================
// DIAPOSITIVA 3: OBJETIVOS
// ============================================================
= Objetivos de la investigación

#speaker-marker("A")

#v(4pt)
#block(
  fill: color-card-bg,
  stroke: 1.2pt + color-title.lighten(50%),
  radius: 9pt,
  inset: (x: 18pt, y: 13pt),
  width: 100%,
  stack(
    dir: ttb,
    spacing: 4pt,
    text(size: 16pt, weight: "bold", fill: color-title, font: font-heading)[Objetivo General],
    par(leading: 0.48em)[#text(size: 14.5pt, fill: color-body, font: font-body)[#objetivo-general]]
  )
)

#v(10pt)
#stack(
  spacing: 11pt,
  card-numbered(
    number: 1,
    title: [Eje 1: Inclusión y Fuentes de Financiamiento],
    text-content: objetivo-especifico-1,
    size: 14pt,
  ),
  card-numbered(
    number: 2,
    title: [Eje 2: Dinámica e Intensidad Laboral],
    text-content: objetivo-especifico-2,
    size: 14pt,
  ),
  card-numbered(
    number: 3,
    title: [Eje 3: Uso del Suelo y Diversificación Productiva],
    text-content: objetivo-especifico-3,
    size: 14pt,
  ),
)

// ============================================================
// METODOLOGÍA 1: ENFOQUE, POBLACIÓN E INGESTA CENSAL
// ============================================================
= Enfoque de investigación, población e ingesta censal

#speaker-marker("B")

#grid(
  columns: (1fr, 24pt, 1.15fr, 24pt, 1fr),
  align: horizon,
  pipeline-node(
    logo: image("images/presentation/logos/spss.png"),
    title: [CENAGRO 2011],
    subtitle: [Microdato oficial (.sav)],
    tag: [Universo Censal],
    accent: rgb("#8a4b08"),
    fill: rgb("#fffaf3"),
  ),
  flow-arrow,
  pipeline-node(
    logo: image("images/presentation/logos/python.svg"),
    title: [Python (pyreadstat)],
    subtitle: [Script de extracción e ingesta],
    tag: [Motor de Ingesta],
    accent: color-title,
    fill: color-card-bg,
  ),
  flow-arrow,
  stack(
    spacing: 6pt,
    pipeline-node(
      logo: image("images/presentation/logos/parquet.svg"),
      title: [raw_farms.parquet],
      subtitle: [Datos columnares crudos],
      tag: [Almacén Columnar],
      accent: rgb("#198754"),
      fill: rgb("#f0faf3"),
    ),
    pipeline-node(
      logo: box(fill: color-accent, radius: 4pt, width: 22pt, height: 22pt, align(center + horizon, box(width: 14pt, height: 14pt, slide-icons.file-text))),
      title: [metadata.json],
      subtitle: [Diccionario censal estructurado],
      tag: [Semántica & Codebook],
      accent: color-accent,
      fill: rgb("#f5f8fc"),
    )
  )
)

#v(14pt)

#grid(
  columns: (1fr, 1fr, 1fr),
  gutter: 14pt,
  feature-card(
    icon: slide-icons.target,
    title: [Enfoque y Tipo],
    subtitle: [Enfoque mixto y corte transversal],
    height: auto,
    inset: (x: 14pt, y: 13pt),
    body-size: 11.5pt,
    spacing: 0.82em,
    leading: 0.50em,
    body: [
      #list(
        [*Enfoque mixto:* Articulación de microdatos cuantitativos censales con análisis e interpretación cualitativa socioeconómica.],
        [*Tipo de investigación:* No experimental, transversal de alcance descriptivo, analítico y correlacional.],
        [*Método comparativo:* Contraste observacional de brechas estructurales entre fincas con y sin financiamiento.],
      )
    ]
  ),
  feature-card(
    icon: image("images/presentation/logos/spss.png"),
    badge-fill: white,
    title: [Población Censal],
    subtitle: [227,541 fincas (universo exhaustivo)],
    height: auto,
    inset: (x: 14pt, y: 13pt),
    body-size: 11.8pt,
    spacing: 0.85em,
    leading: 0.52em,
    body: [
      #list(
        [*Población objetivo:* Totalidad de las explotaciones agropecuarias del IV CENAGRO 2011 (INIDE / MAGFOR).],
        [*262,546 registros:* Microdatos consolidados por parcelas, tenencia y aprovechamiento de tierra.],
        [*Sin sesgo muestral:* Cobertura censal exhaustiva que supera las distorsiones de muestras acotadas.],
      )
    ]
  ),
  feature-card(
    icon: image("images/presentation/logos/parquet.svg"),
    badge-fill: white,
    title: [Unidad de Análisis],
    subtitle: [Explotación Agropecuaria (EA)],
    height: auto,
    inset: (x: 14pt, y: 13pt),
    body-size: 11.8pt,
    spacing: 0.85em,
    leading: 0.52em,
    body: [
      #list(
        [*Definición censal:* Extensión de tierra para actividades agropecuarias bajo una administración única.],
        [*Desacoplamiento:* Extracción con Python (`pyreadstat`) a Parquet crudo y diccionario a JSON estructurado.],
        [*Integridad semántica:* Preservación de 100% de categorías, encodings y etiquetas sin alteración.],
      )
    ]
  )
)

// ============================================================
// METODOLOGÍA 2: PIPELINE ETL EN RUST
// ============================================================
= Pipeline de transformación vectorizada en Rust

#speaker-marker("B")

#grid(
  columns: (1fr, 24pt, 1.25fr, 24pt, 1fr),
  align: horizon,
  pipeline-node(
    logo: image("images/presentation/logos/parquet.svg"),
    title: [Parquet Crudo],
    subtitle: [Input desacoplado],
    tag: [Microdato Base],
    accent: rgb("#8a4b08"),
    fill: rgb("#fffaf3"),
  ),
  flow-arrow,
  pipeline-node(
    logo: image("images/presentation/logos/rust.svg"),
    title: [Rust + DataFusion],
    subtitle: [Motor vectorizado Apache Arrow],
    tag: [Transformación Zero-GC],
    accent: color-title,
    fill: color-card-bg,
  ),
  flow-arrow,
  pipeline-node(
    logo: image("images/presentation/logos/parquet.svg"),
    title: [farms.parquet],
    subtitle: [Compresión Snappy],
    tag: [-90% Espacio en Disco],
    accent: rgb("#198754"),
    fill: rgb("#f0faf3"),
  )
)

#v(14pt)

#grid(
  columns: (1fr, 1fr, 1fr),
  gutter: 14pt,
  feature-card(
    icon: image("images/presentation/logos/rust.svg"),
    badge-fill: white,
    title: [Seguridad en Rust],
    subtitle: [Zero-GC & Type-Safe],
    height: auto,
    inset: (x: 14pt, y: 13pt),
    body-size: 11.8pt,
    spacing: 0.85em,
    leading: 0.52em,
    body: [
      #list(
        [*Gestión determinista:* Cero pausas de *Garbage Collector* y cero fugas de memoria.],
        [*Tipado en compilación:* Verificación estricta de esquemas antes de ejecución.],
        [*Vectores Apache Arrow:* Procesamiento columnar contiguo en registros de CPU.],
      )
    ]
  ),
  feature-card(
    icon: image("images/presentation/logos/datafusion.svg"),
    badge-fill: white,
    title: [Downcasting y Caché],
    subtitle: [Alineación con CPU L1/L2],
    height: auto,
    inset: (x: 14pt, y: 13pt),
    body-size: 11.8pt,
    spacing: 0.85em,
    leading: 0.52em,
    body: [
      #list(
        [*Tipos mínimos viables:* Downcasting a enteros `i8`/`i16` y banderas booleanas.],
        [*Hash Join masivo:* Cruce vectorizado de fincas y parcelas con alta tasa de caché.],
        [*Eficiencia energética:* Ejecución en hardware estándar sin clusters distribuidos.],
      )
    ]
  ),
  feature-card(
    icon: image("images/presentation/logos/parquet.svg"),
    badge-fill: white,
    title: [Compresión y Métricas],
    subtitle: [Artefacto farms.parquet],
    height: auto,
    inset: (x: 14pt, y: 13pt),
    body-size: 11.8pt,
    spacing: 0.85em,
    leading: 0.52em,
    body: [
      #list(
        [*Dictionary Encoding:* Cadenas categóricas comprimidas a diccionarios de enteros.],
        [*-90% en disco:* De 100 MB crudos a 10 MB Parquet con compresión Snappy.],
        [*Métricas derivadas:* Estratos censales (`farm_size_class`) e intensidades listos.],
      )
    ]
  )
)

// ============================================================
// METODOLOGÍA 3: HUB ANALÍTICO OLAP Y ENTREGA MULTI-TARGET
// ============================================================
= Hub analítico OLAP y reproducibilidad multi-target

#speaker-marker("B")

#grid(
  columns: (1fr, 22pt, 1.15fr, 22pt, 1.25fr),
  align: horizon,
  pipeline-node(
    logo: image("images/presentation/logos/parquet.svg"),
    title: [farms.parquet],
    subtitle: [Artefacto canónico],
    tag: [Almacén Inmutable],
    accent: rgb("#198754"),
    fill: rgb("#f0faf3"),
  ),
  flow-arrow,
  pipeline-node(
    logo: image("images/presentation/logos/duckdb-icon.svg"),
    title: [DuckDB OLAP],
    subtitle: [Motor analítico embebido],
    tag: [Cálculo en Memoria],
    accent: color-title,
    fill: color-card-bg,
  ),
  flow-arrow,
  stack(
    spacing: 3pt,
    pipeline-node(
      logo: box(fill: rgb("#1F4E79"), radius: 3pt, width: 20pt, height: 20pt, align(center + horizon, box(width: 13pt, height: 13pt, slide-icons.terminal))),
      title: [DuckDB CLI],
      subtitle: [Exploración ad-hoc],
      tag: [EDA Ágil],
      accent: rgb("#1F4E79"),
      fill: rgb("#f5f8fc"),
      badge-size: 20pt,
      title-size: 11pt,
      subtitle-size: 8.5pt,
      tag-size: 7.5pt,
      inset: (x: 8pt, y: 4pt),
    ),
    pipeline-node(
      logo: image("images/presentation/logos/evidence.svg"),
      title: [Evidence.dev],
      subtitle: [Portal BI interactivo],
      tag: [Markdown + SQL],
      accent: rgb("#7030A0"),
      fill: rgb("#fbfafc"),
      badge-size: 20pt,
      title-size: 11pt,
      subtitle-size: 8.5pt,
      tag-size: 7.5pt,
      inset: (x: 8pt, y: 4pt),
    ),
    pipeline-node(
      logo: image("images/presentation/logos/typst.svg"),
      title: [Typst + CeTZ],
      subtitle: [Paper y diapositivas],
      tag: [Paper-as-Code],
      accent: rgb("#008080"),
      fill: rgb("#f0faf8"),
      badge-size: 20pt,
      title-size: 11pt,
      subtitle-size: 8.5pt,
      tag-size: 7.5pt,
      inset: (x: 8pt, y: 4pt),
    ),
  )
)

#v(10pt)

#grid(
  columns: (1fr, 1fr, 1fr),
  gutter: 12pt,
  feature-card(
    icon: image("images/presentation/logos/duckdb-icon.svg"),
    badge-fill: white,
    title: [Motor OLAP Embebido],
    subtitle: [Rigor estadístico sin sesgos],
    height: auto,
    inset: (x: 13pt, y: 10pt),
    body-size: 11pt,
    spacing: 0.6em,
    leading: 0.46em,
    body: [
      #list(
        [*Lecturas Zero-Copy:* Consultas analíticas en memoria directo sobre Parquet.],
        [*UNPIVOT matricial:* Pivotado dinámico de fuentes y rubros sin duplicar datos.],
        [*Estadística robusta:* Medianas e IQR inmunes a distorsiones por fincas gigantes.],
      )
    ]
  ),
  feature-card(
    icon: image("images/presentation/logos/evidence.svg"),
    badge-fill: white,
    title: [Trifecta de Consumo],
    subtitle: [CLI, Portal BI y Publicación],
    height: auto,
    inset: (x: 13pt, y: 10pt),
    body-size: 11pt,
    spacing: 0.6em,
    leading: 0.46em,
    body: [
      #list(
        [*DuckDB CLI:* Exploración ágil, validación de hipótesis y auditoría de microdatos.],
        [*Portal Evidence:* Tablero web interactivo reactivo con consultas SQL directas.],
        [*Publicación Typst:* Generación canónica de datos (`export-paper-data.sql`).],
      )
    ]
  ),
  feature-card(
    icon: image("images/presentation/logos/typst.svg"),
    badge-fill: white,
    title: [Paper-as-Code],
    subtitle: [Reproducibilidad absoluta],
    height: auto,
    inset: (x: 13pt, y: 10pt),
    body-size: 11pt,
    spacing: 0.6em,
    leading: 0.46em,
    body: [
      #list(
        [*Fuente única de verdad:* Cero discrepancias entre paper, diapositivas y portal.],
        [*Cero copy-paste:* Gráficos CeTZ generados automáticamente desde CSVs de DuckDB.],
        [*Entorno inmutable:* Pipeline reproducible en hardware común (`just compile-paper`).],
      )
    ]
  )
)

// ============================================================
// RESULTADOS 1: CRÉDITO (EMBUDO + FUENTES)
// ============================================================
= Ecosistema crediticio: acceso y fuentes de financiamiento

#slide-dual-chart(
  speaker: "C",
  icon-1: slide-icons.credit-card,
  chart-fn-1: chart-embudo(),
  caption-1: fig-caption("embudo"),
  stat-1: [15.9% solicitó crédito],
  body-1: [De 262,546 explotaciones censadas, solo 41,756 solicitaron crédito. Sin embargo, la tasa de aprobación bancaria alcanzó un elevado 92.6%.],
  icon-2: slide-icons.dollar-sign,
  stat-2: [52.6% banca privada],
  body-2: [La banca comercial concentró la mayoría de créditos (18,255), seguida por cooperativas (28.2%) y ONGs (7.7%). Canales estatales e informales fueron minoritarios.],
  chart-fn-2: chart-fuentes(),
  caption-2: fig-caption("fuentes"),
)

// ============================================================
// RESULTADOS 2: EMPLEO (INTENSIDAD + ESTABILIDAD)
// ============================================================
= Dinámica laboral: intensidad y estabilidad del empleo

#slide-dual-chart(
  speaker: "C",
  icon-1: slide-icons.trending-up,
  chart-fn-1: chart-intensidad(),
  caption-1: fig-caption("intensidad"),
  stat-1: [+171.6% en medianas y grandes],
  body-1: [En fincas medianas y grandes con crédito, la intensidad mediana subió a 0.326 trab/Mz frente a 0.120 sin crédito (+33.3% en pequeñas), confirmando absorción laboral.],
  icon-2: slide-icons.clock,
  stat-2: [68.6% empleo estacional],
  body-2: [El 68.6% de las fincas con crédito operó exclusivamente con mano de obra temporal. El crédito dinamizó picos de siembra y cosecha sin formalización contractual.],
  chart-fn-2: chart-estabilidad(),
  caption-2: fig-caption("estabilidad"),
)

// ============================================================
// RESULTADOS 3: PRODUCCIÓN (COMPLEJIDAD + USO DE SUELO)
// ============================================================
= Reconfiguración productiva: diversificación y uso del suelo

#slide-dual-chart(
  speaker: "D",
  icon-1: slide-icons.layers,
  chart-fn-1: chart-complejidad(),
  caption-1: fig-caption("complejidad"),
  stat-1: [Pico modal en 3 rubros],
  body-1: [El pico más frecuente pasó de 2 rubros sin crédito (25.1%) a 3 rubros con crédito (23.7%), elevando el promedio de 3.36 a 3.65 rubros por finca.],
  icon-2: slide-icons.pie-chart,
  stat-2: [22.9% en cultivos permanentes],
  body-2: [Fincas con crédito destinaron 22.9% de su área a cultivos permanentes (vs. 13.6% sin crédito), reduciendo el ratio pasto-cultivo de 4.18 a 2.71 hacia la intensificación.],
  chart-fn-2: chart-vocacion(),
  caption-2: fig-caption("vocacion"),
)

// ============================================================
// DIAPOSITIVA: CONCLUSIONES
// ============================================================
= Conclusiones

#speaker-marker("D")

#grid(
  columns: (1fr, 1fr, 1fr),
  gutter: 13pt,
  conclusion-card(
    number: "01",
    tag: [ACCESO AL CRÉDITO],
    title: [Inclusión y Riesgo],
    icon: slide-icons.credit-card,
    stat-main: [92.6%],
    stat-label: [Aprobación bancaria],
    stat-sub: [84.1%],
    stat-sub-label: [Sin postular (exclusión)],
    verdict-headline: [Falla de entrada, no de ventanilla],
    verdict-body: [La banca comercial aprueba masivamente las solicitudes recibidas. La barrera crítica es la autoexclusión previa por aversión al riesgo y temor a la pérdida patrimonial.],
    accent: color-title,
  ),
  conclusion-card(
    number: "02",
    tag: [DINÁMICA LABORAL],
    title: [Demanda y Empleo],
    icon: slide-icons.trending-up,
    stat-main: [+171.6%],
    stat-label: [Intensidad jornalera],
    stat-sub: [68.6%],
    stat-sub-label: [Fincas solo temporal],
    verdict-headline: [Multiplicador estacional, no empleo fijo],
    verdict-body: [El crédito dinamiza con fuerza la absorción de mano de obra en picos de siembra y zafra, pero no genera relaciones contractuales permanentes ni estabilidad laboral.],
    accent: color-accent,
  ),
  conclusion-card(
    number: "03",
    tag: [USO DEL SUELO],
    title: [Transición Productiva],
    icon: slide-icons.layers,
    stat-main: [22.9%],
    stat-label: [Cultivos permanentes],
    stat-sub: [2.71],
    stat-sub-label: [Ratio pasto/cultivo (vs 4.18)],
    verdict-headline: [Ruptura de la trampa extensiva],
    verdict-body: [El capital impulsa la reconversión productiva hacia rubros perennes de mayor valor agregado y diversifica la canasta modal de la explotación hacia 3 rubros.],
    accent: rgb("#008080"),
  ),
)

// ============================================================
// DIAPOSITIVA: RECOMENDACIONES
// ============================================================
= Recomendaciones

#speaker-marker("D")

#stack(
  dir: ttb,
  spacing: 9pt,
  policy-row(
    number: "01",
    pillar-tag: [CRÉDITO INCLUSIVO],
    target-agency: [PRODUZCAMOS / COOPERATIVAS],
    icon: slide-icons.shield,
    title: [Garantías y Seguros],
    action-1-title: [Fondos de Aval Solidario],
    action-1-body: [Sustituir hipotecas de fincas por garantías mancomunadas para derribar la barrera de postulación.],
    action-2-title: [Microseguros Climáticos],
    action-2-body: [Pólizas indexadas ante sequías que neutralicen el temor a la pérdida patrimonial.],
    impact-label: [POBLACIÓN OBJETIVO],
    impact-stat: [84.1%],
    impact-target: [Productores autoexcluidos por riesgo de pérdida patrimonial.],
    accent: color-title,
  ),
  policy-row(
    number: "02",
    pillar-tag: [EMPLEO DIGNO],
    target-agency: [MAG • MITRAB • INSS],
    icon: slide-icons.users,
    title: [Formalización Laboral],
    action-1-title: [Tasas Bonificadas],
    action-1-body: [Crédito preferencial a fincas que conviertan jornales temporales en contratos continuos.],
    action-2-title: [Seguridad Social Adaptada],
    action-2-body: [Régimen contributivo flexible adaptado a ciclos estacionales de cosecha y siembra.],
    impact-label: [LÍNEA BASE LABORAL],
    impact-stat: [68.6%],
    impact-target: [Fincas dependientes de empleo exclusivamente temporal.],
    accent: color-accent,
  ),
  policy-row(
    number: "03",
    pillar-tag: [DATOS & TRANSICIÓN],
    target-agency: [INIDE • MAG • BANCO CENTRAL],
    icon: slide-icons.database,
    title: [Crédito Verde y Analítica],
    action-1-title: [Financiamiento Silvopastoril],
    action-1-body: [Líneas verdes atadas a planes de reconversión de pastizales degradados a silvopastoreo.],
    action-2-title: [Modern Data Stack Estatal],
    action-2-body: [Adopción de Parquet y DuckDB para auditoría pública y analítica censal en segundos.],
    impact-label: [ACCESO CIUDADANO],
    impact-stat: [100%],
    impact-target: [Soberanía de microdatos censales abiertos y auditables.],
    accent: rgb("#008080"),
  ),
)

// ============================================================
// DIAPOSITIVA: CIERRE
// ============================================================
#ending-slide(message: [Muchas gracias por su atención])
