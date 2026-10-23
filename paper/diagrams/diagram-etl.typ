#import "@preview/fletcher:0.5.8": diagram, node, edge

// Paleta visual institucional
#let color-title = rgb("#7030A0")
#let color-accent = rgb("#1a4d8f")
#let font-heading = ("Montserrat", "Liberation Sans")
#let font-body = ("Liberation Sans",)

#let etl-node(pos, logo: none, title: [], subtitle: none, tag: none, accent: color-title, fill: rgb("#fbfafc"), name: none) = {
  node(
    pos,
    name: name,
    fill: fill,
    stroke: 1.1pt + accent.lighten(35%),
    corner-radius: 7pt,
    inset: 6pt,
    [
      #grid(
        columns: if logo != none { (22pt, auto) } else { (auto,) },
        gutter: 7pt,
        align: horizon,
        if logo != none {
          box(
            fill: white,
            stroke: 0.6pt + rgb("#e0d8f0"),
            radius: 4pt,
            width: 22pt,
            height: 22pt,
            align(center + horizon, box(width: 16pt, height: 16pt, logo))
          )
        },
        align(left)[
          #text(size: 10.5pt, weight: "bold", fill: accent, font: font-heading, title)
          #if subtitle != none [
            \ #text(size: 7.8pt, fill: rgb("#555555"), font: font-body, subtitle)
          ]
        ]
      )
      #if tag != none [
        #v(2.5pt)
        #box(
          fill: accent.lighten(88%),
          radius: 3pt,
          inset: (x: 5pt, y: 1.5pt),
          text(size: 7pt, weight: "bold", fill: accent, font: font-heading, tag)
        )
      ]
    ]
  )
}

/// Diagrama de flujo de Transformación Vectorizada en Rust y Hash Join
#let diagram-etl(spacing: (36pt, 10pt)) = {
  diagram(
    spacing: spacing,
    etl-node(
      (0, 0),
      logo: image("../images/presentation/logos/parquet.svg"),
      title: [explotaciones.parquet],
      subtitle: [262,546 filas (productor y crédito)],
      tag: [Entrada: Ingesta (Slide 4)],
      accent: rgb("#8a4b08"),
      fill: rgb("#fffaf3"),
      name: <exp>,
    ),
    etl-node(
      (0, 1),
      logo: image("../images/presentation/logos/parquet.svg"),
      title: [parcelas.parquet],
      subtitle: [Uso y aprovechamiento de tierra],
      tag: [Entrada: Ingesta (Slide 4)],
      accent: rgb("#8a4b08"),
      fill: rgb("#fffaf3"),
      name: <parc>,
    ),
    etl-node(
      (1, 0.5),
      logo: image("../images/presentation/logos/rust.svg"),
      title: [Rust + DataFusion],
      subtitle: [Hash Join vectorizado por ID],
      tag: [Fase 2: Cruce & Downcasting Zero-GC],
      accent: color-title,
      fill: rgb("#fbfafc"),
      name: <rust>,
    ),
    etl-node(
      (2, 0.5),
      logo: image("../images/presentation/logos/parquet.svg"),
      title: [farms.parquet],
      subtitle: [Consolidado Snappy (7.3 MB)],
      tag: [Salida: Artefacto Canónico ➔ Slide 6],
      accent: rgb("#198754"),
      fill: rgb("#f0faf3"),
      name: <farms>,
    ),
    edge(<exp>, <rust>, "-|>", stroke: 1.2pt + color-title),
    edge(<parc>, <rust>, "-|>", stroke: 1.2pt + color-title),
    edge(<rust>, <farms>, "-|>", stroke: 1.2pt + rgb("#198754")),
  )
}
