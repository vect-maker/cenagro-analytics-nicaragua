#import "@preview/touying:0.8.0": *
#import "@preview/ficons:0.1.0": make-icons

// ==========================================
// INSTITUTIONAL PALETTE & CONSTANTS
// ==========================================
#let color-title = rgb("#7030A0")
#let color-body = rgb("#133454")
#let color-accent = rgb("#1a4d8f")
#let color-card-bg = rgb("#fbfafc")
#let color-card-stroke = rgb("#d8d0e8")
#let color-badge-bg = color-title
#let color-badge-stroke = color-title

#let font-heading = ("Montserrat", "Liberation Sans")
#let font-body = ("Liberation Sans",)

/// Feather icons configured with white stroke for badge containers
#let slide-icons = make-icons(stroke: white, stroke-width: 2.3)

// ==========================================
// REUSABLE COMPONENTS
// ==========================================

/// Metric highlight card for analytical chart slides
#let metric-card(stat: [], body: []) = {
  block(
    fill: color-card-bg,
    stroke: 1.2pt + color-card-stroke,
    radius: 10pt,
    inset: (x: 18pt, y: 18pt),
    width: 100%,
    [
      #text(size: 22pt, weight: "bold", fill: color-title, font: font-heading, stat)
      #v(0.6em)
      #text(size: 15pt, fill: color-body, font: font-body, body)
    ]
  )
}

/// Styled numbered card for objectives and conclusions
#let card-numbered(number: 1, text-content: [], size: 15pt) = {
  block(
    fill: color-card-bg,
    stroke: 1pt + color-card-stroke,
    radius: 8pt,
    inset: (x: 16pt, y: 10pt),
    width: 100%,
    grid(
      columns: (28pt, 1fr),
      gutter: 12pt,
      align: (center + horizon, left + horizon),
      circle(
        radius: 12pt,
        fill: color-title,
        text(fill: white, size: 13pt, weight: "bold", font: font-heading)[#number]
      ),
      text(fill: color-body, size: size, font: font-body, text-content)
    )
  )
}

/// Pipeline badge box for methodology slide
#let pipeline-badge(title: [], tool: []) = {
  block(
    fill: color-badge-bg,
    stroke: 1pt + color-card-stroke,
    radius: 8pt,
    inset: (x: 14pt, y: 10pt),
    width: 100%,
    align(center, [
      #text(fill: color-title, size: 15pt, weight: "bold", font: font-heading, title)
      #if tool != [] [
        \ #text(fill: color-body, size: 12pt, font: font-body, tool)
      ]
    ])
  )
}

/// Modern feature / contextual card with icon badge
#let feature-card(
  icon: none,
  title: [],
  subtitle: none,
  body: [],
  height: 330pt,
) = {
  block(
    fill: color-card-bg,
    stroke: 1pt + color-card-stroke,
    radius: 10pt,
    inset: (x: 13pt, y: 11pt),
    width: 100%,
    height: height,
    [
      #grid(
        columns: if icon != none { (26pt, 1fr) } else { (1fr,) },
        gutter: 8pt,
        align: (horizon + center, horizon + left),
        if icon != none {
          box(
            fill: color-badge-bg,
            stroke: 0.8pt + color-badge-stroke,
            radius: 6pt,
            width: 26pt,
            height: 26pt,
            align(center + horizon, box(width: 15pt, height: 15pt, icon))
          )
        },
        [
          #text(size: 14.5pt, weight: "bold", fill: color-title, font: font-heading, title)
          #if subtitle != none [
            #v(0.12em)
            #text(size: 9.5pt, fill: color-accent, font: font-body, subtitle)
          ]
        ]
      )
      #v(5pt)
      #line(length: 100%, stroke: 0.6pt + rgb("#eee8f6"))
      #v(3pt)
      #set text(size: 10.3pt, fill: color-body, font: font-body)
      #set par(leading: 0.46em)
      #body
    ]
  )
}

/// Caution / disclaimer container
#let caution-box(body) = {
  block(
    fill: rgb("#fffaf3"),
    stroke: 1pt + rgb("#f5d5b5"),
    radius: 7pt,
    inset: (x: 12pt, y: 7pt),
    width: 100%,
    text(fill: rgb("#8a4b08"), size: 10.5pt, font: font-body, body)
  )
}

// ==========================================
// SLIDE FUNCTIONS (TOUYING 0.8.0)
// ==========================================

/// Content slide function with master header and institutional background
#let slide(
  config: (:),
  repeat: auto,
  setting: body => body,
  composer: auto,
  ..bodies,
) = touying-slide-wrapper(self => {
  let header(self) = {
    place(
      top + left,
      dx: 66pt,
      dy: 20pt,
      block(
        width: 828pt,
        height: 72pt,
        align(top + left, text(
          fill: color-title,
          size: 27pt,
          weight: "semibold",
          font: font-heading,
          utils.display-current-heading(level: 1)
        ))
      )
    )
  }

  let self = utils.merge-dicts(
    self,
    config-page(
      background: place(top + left, image("images/presentation/background-content.png", width: 960pt, height: 540pt)),
      header: header,
      margin: (left: 66pt, right: 66pt, top: 98pt, bottom: 20pt),
    ),
  )

  touying-slide(
    self: self,
    config: config,
    repeat: repeat,
    setting: setting,
    composer: composer,
    ..bodies,
  )
})

/// Analytical card with icon badge for dual-chart slides
#let analytical-card(
  icon: none,
  stat: [],
  body: [],
) = {
  block(
    fill: color-card-bg,
    stroke: 1pt + color-card-stroke,
    radius: 9pt,
    inset: (x: 13pt, y: 10pt),
    width: 100%,
    [
      #grid(
        columns: if icon != none { (26pt, 1fr) } else { (1fr,) },
        gutter: 9pt,
        align: (horizon + center, horizon + left),
        if icon != none {
          box(
            fill: color-badge-bg,
            stroke: 0.8pt + color-badge-stroke,
            radius: 6pt,
            width: 26pt,
            height: 26pt,
            align(center + horizon, box(width: 15pt, height: 15pt, icon))
          )
        },
        [
          #text(size: 15pt, weight: "bold", fill: color-title, font: font-heading, stat)
        ]
      )
      #v(5pt)
      #line(length: 100%, stroke: 0.6pt + rgb("#eee8f6"))
      #v(5pt)
      #par(leading: 0.52em)[#text(size: 11.2pt, fill: color-body, font: font-body, body)]
    ]
  )
}

/// High-level slide generator for 2 alternating charts per slide (zig-zag layout)
#let slide-dual-chart(
  // Chunk 1 (top): Graph Left, Info Right
  chart-fn-1: none,
  caption-1: [],
  stat-1: [],
  body-1: [],
  icon-1: none,
  // Chunk 2 (bottom): Info Left, Graph Right
  chart-fn-2: none,
  caption-2: [],
  stat-2: [],
  body-2: [],
  icon-2: none,
) = {
  slide[
    #set text(size: 10.5pt, font: font-body)
    #grid(
      rows: (1fr, 1fr),
      row-gutter: 6pt,
      // Fila 1: Gráfico a la izquierda, información a la derecha
      grid(
        columns: (490pt, 1fr),
        gutter: 18pt,
        align: (center + horizon, horizon + left),
        [
          #block(width: 100%, align(center)[
            #set text(size: 10.5pt, font: font-body)
            #chart-fn-1
            #if caption-1 != [] [
              #v(0.2em)
              #text(size: 9.5pt, font: font-body, caption-1)
            ]
          ])
        ],
        [
          #analytical-card(icon: icon-1, stat: stat-1, body: body-1)
        ]
      ),
      // Fila 2: Información a la izquierda, gráfico a la derecha
      grid(
        columns: (1fr, 490pt),
        gutter: 18pt,
        align: (horizon + left, center + horizon),
        [
          #analytical-card(icon: icon-2, stat: stat-2, body: body-2)
        ],
        [
          #block(width: 100%, align(center)[
            #set text(size: 10.5pt, font: font-body)
            #chart-fn-2
            #if caption-2 != [] [
              #v(0.2em)
              #text(size: 9.5pt, font: font-body, caption-2)
            ]
          ])
        ]
      )
    )
  ]
}

/// Title slide matching Plantilla PPT layout
#let title-slide(
  title: [Escriba su texto],
  subtitle: none,
  authors: (),
  tutor: none,
  config: (:),
) = touying-slide-wrapper(self => {
  let self = utils.merge-dicts(
    self,
    config-common(freeze-slide-counter: true),
    config-page(
      background: place(top + left, image("images/presentation/background-title.png", width: 960pt, height: 540pt)),
      margin: 0pt,
      header: none,
      footer: none,
    ),
  )

  let author-items = if type(authors) == array {
    authors.map(a => {
      if type(a) == dictionary {
        if "formal-name" in a {
          if "name" in a and a.name.starts-with("Br. ") and not a.formal-name.starts-with("Br. ") {
            "Br. " + a.formal-name
          } else {
            a.formal-name
          }
        } else if "name" in a {
          a.name
        } else {
          ""
        }
      } else {
        a
      }
    })
  } else if authors != none and authors != [] and authors != () {
    (authors,)
  } else {
    ()
  }

  let tutor-name = if type(tutor) == dictionary {
    if "name" in tutor {
      tutor.name
    } else {
      none
    }
  } else {
    tutor
  }

  touying-slide(
    self: self,
    config: config,
    {
      place(
        top + left,
        dx: 520pt,
        dy: 135pt,
        block(
          width: 412.8pt,
          [
            #set par(leading: 0.42em, spacing: 0.55em)
            #text(
              fill: color-title,
              size: 23pt,
              weight: "bold",
              font: font-heading,
              title,
            )
            #if subtitle != none and subtitle != [] [
              #v(0.6em)
              #text(
                fill: color-body,
                size: 13.5pt,
                font: font-body,
                subtitle,
              )
            ]
            #if author-items.len() > 0 [
              #v(1.1em)
              #text(
                fill: color-title,
                size: 12pt,
                weight: "bold",
                font: font-heading,
                [Autores:]
              )
              #v(0.25em)
              #grid(
                columns: 1,
                row-gutter: 0.35em,
                ..author-items.map(it => text(
                  fill: color-body,
                  size: 11.5pt,
                  font: font-body,
                  it
                ))
              )
            ]
            #if tutor-name != none and tutor-name != [] [
              #v(0.7em)
              #text(
                fill: color-title,
                size: 12pt,
                weight: "bold",
                font: font-heading,
                [Tutor: ]
              )
              #text(
                fill: color-body,
                size: 11.5pt,
                font: font-body,
                tutor-name
              )
            ]
          ]
        )
      )
    }
  )
})

/// Ending / conclusion slide
#let ending-slide(
  message: [Muchas gracias],
  config: (:),
) = touying-slide-wrapper(self => {
  let self = utils.merge-dicts(
    self,
    config-common(freeze-slide-counter: true),
    config-page(
      background: place(top + left, image("images/presentation/background-ending.png", width: 960pt, height: 540pt)),
      margin: 0pt,
      header: none,
      footer: none,
    ),
  )

  touying-slide(
    self: self,
    config: config,
    place(
      top + left,
      dx: 0pt,
      dy: 385pt,
      block(
        width: 960pt,
        align(center, text(fill: white, size: 36pt, weight: "bold", font: font-heading, message))
      )
    )
  )
})

/// Main theme initializer for UNAN-Managua / JUDC slides
#let cenagro-theme(
  aspect-ratio: "16-9",
  ..args,
  body,
) = {
  set text(
    font: font-body,
    fill: color-body,
    size: 20pt,
    lang: "es",
  )

  set list(
    marker: ([•], [–], [·]),
    spacing: 1.1em,
  )

  show: touying-slides.with(
    config-page(
      width: 960pt,
      height: 540pt,
      margin: 0pt,
    ),
    config-common(slide-fn: slide),
    config-colors(
      primary: color-title,
      secondary: color-body,
    ),
    ..args,
  )

  body
}
