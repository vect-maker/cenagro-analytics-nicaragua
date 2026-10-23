#import "@preview/fletcher:0.5.8": diagram, node, edge

// Paleta visual institucional
#let color-title = rgb("#7030A0")
#let color-accent = rgb("#1a4d8f")
#let font-heading = ("Montserrat", "Liberation Sans")
#let font-body = ("Liberation Sans",)

#let warehouse-node(pos, logo: none, title: [], subtitle: none, accent: color-title, fill: rgb("#fbfafc"), name: none) = {
  node(
    pos,
    name: name,
    fill: fill,
    stroke: 1.1pt + accent.lighten(35%),
    corner-radius: 7pt,
    inset: 7pt,
    [
      #grid(
        columns: if logo != none { (24pt, auto) } else { (auto,) },
        gutter: 8pt,
        align: horizon,
        if logo != none {
          box(
            fill: white,
            stroke: 0.6pt + rgb("#e0d8f0"),
            radius: 5pt,
            width: 24pt,
            height: 24pt,
            align(center + horizon, box(width: 17pt, height: 17pt, logo))
          )
        },
        align(left + horizon)[
          #text(size: 11pt, weight: "bold", fill: accent, font: font-heading, title)
          #if subtitle != none [
            #v(1.5pt)
            #text(size: 8.2pt, fill: rgb("#555555"), font: font-body, subtitle)
          ]
        ]
      )
    ]
  )
}

/// Diagrama de flujo de Hub OLAP DuckDB y Salidas Multi-Target
#let diagram-warehouse(spacing: (40pt, 8pt)) = {
  diagram(
    spacing: spacing,
    warehouse-node(
      (0, 1),
      logo: image("../images/presentation/logos/parquet.svg"),
      title: [farms.parquet],
      subtitle: [Consolidado inmutable (7.3 MB)],
      accent: rgb("#198754"),
      fill: rgb("#f0faf3"),
      name: <farms>,
    ),
    warehouse-node(
      (1, 1),
      logo: image("../images/presentation/logos/duckdb-icon.svg"),
      title: [DuckDB OLAP],
      subtitle: [Motor analítico embebido],
      accent: color-title,
      fill: rgb("#fbfafc"),
      name: <duck>,
    ),
    warehouse-node(
      (2, 0),
      logo: box(fill: rgb("#1F4E79"), radius: 4pt, width: 24pt, height: 24pt, align(center + horizon, text(size: 10pt, fill: white, font: font-heading)[`>_`])),
      title: [DuckDB CLI],
      subtitle: [Exploración ad-hoc],
      accent: rgb("#1F4E79"),
      fill: rgb("#f5f8fc"),
      name: <cli>,
    ),
    warehouse-node(
      (2, 1),
      logo: image("../images/presentation/logos/evidence.svg"),
      title: [Evidence.dev],
      subtitle: [Portal BI interactivo con SQL],
      accent: rgb("#7030A0"),
      fill: rgb("#fbfafc"),
      name: <bi>,
    ),
    warehouse-node(
      (2, 2),
      logo: image("../images/presentation/logos/typst.svg"),
      title: [Typst + CeTZ],
      subtitle: [Paper y diapositivas],
      accent: rgb("#008080"),
      fill: rgb("#f0faf8"),
      name: <typ>,
    ),
    edge(<farms>, <duck>, "-|>", stroke: 1.2pt + color-title),
    edge(<duck>, <cli>, "-|>", stroke: 1.2pt + rgb("#1F4E79")),
    edge(<duck>, <bi>, "-|>", stroke: 1.2pt + rgb("#7030A0")),
    edge(<duck>, <typ>, "-|>", stroke: 1.2pt + rgb("#008080")),
  )
}
