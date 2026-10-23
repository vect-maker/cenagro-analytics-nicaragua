#import "@preview/fletcher:0.5.8": diagram, node, edge

// Paleta visual institucional
#let color-title = rgb("#7030A0")
#let color-accent = rgb("#1a4d8f")
#let font-heading = ("Montserrat", "Liberation Sans")
#let font-body = ("Liberation Sans",)

#let ingest-node(pos, logo: none, title: [], subtitle: none, accent: color-title, fill: rgb("#fbfafc"), name: none) = {
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

/// Diagrama de flujo de Ingesta y Desacoplamiento Censal (SPSS -> Python -> Parquet + Codebook)
#let diagram-ingest(spacing: (40pt, 14pt)) = {
  diagram(
    spacing: spacing,
    ingest-node(
      (0, 0.5),
      logo: image("../images/presentation/logos/spss.png"),
      title: [CENAGRO 2011],
      subtitle: [Microdato oficial (.sav)],
      accent: rgb("#8a4b08"),
      fill: rgb("#fffaf3"),
      name: <spss>,
    ),
    ingest-node(
      (1, 0.5),
      logo: image("../images/presentation/logos/python.svg"),
      title: [Python (pyreadstat)],
      subtitle: [Script de extracción e ingesta],
      accent: color-title,
      fill: rgb("#fbfafc"),
      name: <py>,
    ),
    ingest-node(
      (2, 0),
      logo: image("../images/presentation/logos/parquet.svg"),
      title: [explotaciones & parcelas],
      subtitle: [Parquet crudo desacoplado],
      accent: rgb("#198754"),
      fill: rgb("#f0faf3"),
      name: <raw_pq>,
    ),
    ingest-node(
      (2, 1),
      logo: box(fill: color-accent, radius: 4pt, width: 22pt, height: 22pt, align(center + horizon, text(size: 11pt, weight: "bold", fill: white, font: font-heading)[{ }])),
      title: [metadata.json],
      subtitle: [Diccionarios estructurados],
      accent: color-accent,
      fill: rgb("#f5f8fc"),
      name: <meta>,
    ),
    edge(<spss>, <py>, "-|>", stroke: 1.2pt + color-title),
    edge(<py>, <raw_pq>, "-|>", stroke: 1.2pt + rgb("#198754")),
    edge(<py>, <meta>, "-|>", stroke: 1.2pt + color-accent),
  )
}
