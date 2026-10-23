#import "@preview/fletcher:0.5.8": diagram, node, edge

// Paleta visual institucional
#let color-title = rgb("#7030A0")
#let color-accent = rgb("#1a4d8f")
#let font-heading = ("Montserrat", "Liberation Sans")
#let font-body = ("Liberation Sans",)

#let etl-node(pos, logo: none, title: [], subtitle: none, accent: color-title, fill: rgb("#fbfafc"), name: none) = {
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

/// Diagrama de flujo de Transformación Vectorizada en Rust y Hash Join
#let diagram-etl(spacing: (40pt, 14pt)) = {
  diagram(
    spacing: spacing,
    etl-node(
      (0, 0),
      logo: image("../images/presentation/logos/parquet.svg"),
      title: [explotaciones.parquet],
      subtitle: [262,546 filas (productor y crédito)],
      accent: rgb("#8a4b08"),
      fill: rgb("#fffaf3"),
      name: <exp>,
    ),
    etl-node(
      (0, 1),
      logo: image("../images/presentation/logos/parquet.svg"),
      title: [parcelas.parquet],
      subtitle: [Uso y aprovechamiento de tierra],
      accent: rgb("#8a4b08"),
      fill: rgb("#fffaf3"),
      name: <parc>,
    ),
    etl-node(
      (1, 0.5),
      logo: image("../images/presentation/logos/rust.svg"),
      title: [Rust + DataFusion],
      subtitle: [Hash Join vectorizado por ID],
      accent: color-title,
      fill: rgb("#fbfafc"),
      name: <rust>,
    ),
    etl-node(
      (2, 0.5),
      logo: image("../images/presentation/logos/parquet.svg"),
      title: [farms.parquet],
      subtitle: [Consolidado Snappy (7.3 MB)],
      accent: rgb("#198754"),
      fill: rgb("#f0faf3"),
      name: <farms>,
    ),
    edge(<exp>, <rust>, "-|>", stroke: 1.2pt + color-title),
    edge(<parc>, <rust>, "-|>", stroke: 1.2pt + color-title),
    edge(<rust>, <farms>, "-|>", stroke: 1.2pt + rgb("#198754")),
  )
}
