#import "@preview/fletcher:0.5.8": diagram, node, edge

// Paleta visual institucional
#let color-title = rgb("#7030A0")
#let color-accent = rgb("#1a4d8f")
#let font-heading = ("Montserrat", "Liberation Sans")
#let font-body = ("Liberation Sans",)

#let ingest-node(pos, logo: none, title: [], subtitle: none, tag: none, accent: color-title, fill: rgb("#fbfafc"), name: none) = {
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

/// Diagrama de flujo de Ingesta y Desacoplamiento Censal (SPSS -> Python -> Parquet + Codebook)
#let diagram-ingest(spacing: (36pt, 10pt)) = {
  diagram(
    spacing: spacing,
    ingest-node(
      (0, 0.5),
      logo: image("../images/presentation/logos/spss.png"),
      title: [CENAGRO 2011],
      subtitle: [Microdato oficial (.sav)],
      tag: [Fase 1: Universo Censal],
      accent: rgb("#8a4b08"),
      fill: rgb("#fffaf3"),
      name: <spss>,
    ),
    ingest-node(
      (1, 0.5),
      logo: image("../images/presentation/logos/python.svg"),
      title: [Python (pyreadstat)],
      subtitle: [Script de extracción e ingesta],
      tag: [Fase 1: Motor de Ingesta],
      accent: color-title,
      fill: rgb("#fbfafc"),
      name: <py>,
    ),
    ingest-node(
      (2, 0),
      logo: image("../images/presentation/logos/parquet.svg"),
      title: [explotaciones & parcelas],
      subtitle: [Parquet crudo desacoplado],
      tag: [Salida: Parquet Crudo ➔ Slide 5],
      accent: rgb("#198754"),
      fill: rgb("#f0faf3"),
      name: <raw_pq>,
    ),
    ingest-node(
      (2, 1),
      logo: box(fill: color-accent, radius: 4pt, width: 22pt, height: 22pt, align(center + horizon, text(size: 11pt, weight: "bold", fill: white, font: font-heading)[{ }])),
      title: [metadata.json],
      subtitle: [Diccionarios estructurados],
      tag: [Semántica & Codebook],
      accent: color-accent,
      fill: rgb("#f5f8fc"),
      name: <meta>,
    ),
    edge(<spss>, <py>, "-|>", stroke: 1.2pt + color-title),
    edge(<py>, <raw_pq>, "-|>", stroke: 1.2pt + rgb("#198754")),
    edge(<py>, <meta>, "-|>", stroke: 1.2pt + color-accent),
  )
}
