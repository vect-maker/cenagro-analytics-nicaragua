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
  inset: (x: 14pt, y: 12pt),
  badge-fill: auto,
  badge-stroke: auto,
  badge-size: 28pt,
  title-size: 15pt,
  subtitle-size: 10pt,
  body-size: 11.2pt,
  leading: 0.48em,
  spacing: 0.65em,
) = {
  let b-fill = if badge-fill != auto { badge-fill } else { color-badge-bg }
  let b-stroke = if badge-stroke != auto { badge-stroke } else { color-badge-stroke }
  block(
    fill: color-card-bg,
    stroke: 1pt + color-card-stroke,
    radius: 10pt,
    inset: inset,
    width: 100%,
    height: height,
    stack(
      dir: ttb,
      spacing: 5pt,
      grid(
        columns: if icon != none { (badge-size, 1fr) } else { (1fr,) },
        gutter: 8pt,
        align: (horizon + center, horizon + left),
        if icon != none {
          box(
            fill: b-fill,
            stroke: 0.8pt + b-stroke,
            radius: 6pt,
            width: badge-size,
            height: badge-size,
            align(center + horizon, box(width: badge-size * 0.78, align(center + horizon, icon)))
          )
        },
        [
          #text(size: title-size, weight: "bold", fill: color-title, font: font-heading, title)
          #if subtitle != none [
            #v(0.12em)
            #text(size: subtitle-size, fill: color-accent, font: font-body, subtitle)
          ]
        ]
      ),
      line(length: 100%, stroke: 0.6pt + rgb("#eee8f6")),
      [
        #set text(size: body-size, fill: color-body, font: font-body)
        #set par(leading: leading)
        #set list(spacing: spacing)
        #body
      ]
    )
  )
}

/// Node box for methodology visual pipelines
#let pipeline-node(
  logo: none,
  title: [],
  subtitle: none,
  tag: none,
  details: (),
  width: 100%,
  accent: color-title,
  fill: color-card-bg,
  title-size: 12.5pt,
  subtitle-size: 9.8pt,
  tag-size: 8.5pt,
  badge-size: 26pt,
  inset: (x: 11pt, y: 8pt),
) = {
  block(
    fill: fill,
    stroke: 1.1pt + color-card-stroke,
    radius: 8pt,
    inset: inset,
    width: width,
    stack(
      dir: ttb,
      spacing: 4pt,
      grid(
        columns: if logo != none { (badge-size, 1fr) } else { (1fr,) },
        gutter: 7pt,
        align: (horizon + center, horizon + left),
        if logo != none {
          box(
            fill: white,
            stroke: 0.8pt + color-card-stroke,
            radius: 5pt,
            width: badge-size,
            height: badge-size,
            align(center + horizon, box(width: badge-size * 0.78, align(center + horizon, logo)))
          )
        },
        [
          #text(size: title-size, weight: "bold", fill: accent, font: font-heading, title)
          #if subtitle != none [
            #v(0.08em)
            #text(size: subtitle-size, fill: color-accent, font: font-body, subtitle)
          ]
        ]
      ),
      if tag != none [
        #box(
          fill: accent.lighten(88%),
          radius: 3pt,
          inset: (x: 5pt, y: 2pt),
          text(size: tag-size, weight: "bold", fill: accent, font: font-heading, tag)
        )
      ],
      if details.len() > 0 [
        #line(length: 100%, stroke: 0.4pt + rgb("#eee8f6"))
        #set text(size: 8.8pt, fill: color-body, font: font-body)
        #set par(leading: 0.3em)
        #for d in details [
          #text(fill: accent, [•]) #d \
        ]
      ]
    )
  )
}

/// Pipeline flow arrow indicator
#let flow-arrow = align(center + horizon, box(
  fill: rgb("#f3eef8"),
  stroke: 0.8pt + rgb("#d8d0e8"),
  radius: 12pt,
  width: 24pt,
  height: 24pt,
  align(center + horizon, text(size: 14pt, fill: color-title, weight: "bold")[#sym.arrow.r])
))

/// High-impact analytical conclusion card for Slide 10
#let conclusion-card(
  number: "01",
  tag: [],
  title: [],
  icon: none,
  stat-main: [],
  stat-label: [],
  stat-sub: none,
  stat-sub-label: none,
  verdict-headline: [],
  verdict-body: [],
  accent: color-title,
  height: 340pt,
) = {
  block(
    fill: color-card-bg,
    stroke: 1.1pt + color-card-stroke,
    radius: 10pt,
    inset: (x: 15pt, y: 16pt),
    width: 100%,
    height: height,
    breakable: false,
    stack(
      dir: ttb,
      spacing: 0pt,
      // 1. Tag & Number Header
      grid(
        columns: (auto, 1fr),
        gutter: 6pt,
        align: (horizon + left, horizon + right),
        box(
          fill: accent,
          radius: 3.5pt,
          inset: (x: 7.5pt, y: 3.5pt),
          text(size: 9pt, weight: "bold", fill: white, font: font-heading)[#number #sym.bar.v #tag]
        ),
        if icon != none [
          #box(
            fill: accent,
            radius: 4pt,
            width: 24pt,
            height: 24pt,
            align(center + horizon, box(width: 15pt, icon))
          )
        ] else [ ]
      ),
      v(11pt),
      // 2. Title
      text(size: 17pt, weight: "bold", fill: accent, font: font-heading, title),
      v(11pt),
      // 3. Hero Metric Container
      block(
        fill: accent.lighten(93%),
        stroke: 0.8pt + accent.lighten(65%),
        radius: 8pt,
        inset: (x: 10pt, y: 12pt),
        width: 100%,
        [
          #if stat-sub != none [
            #grid(
              columns: (1fr, 1fr),
              gutter: 6pt,
              align: (center, center),
              [
                #text(size: 29pt, weight: "bold", fill: accent, font: font-heading, stat-main) \
                #v(3pt)
                #text(size: 9.6pt, weight: "bold", fill: color-body, font: font-body, stat-label)
              ],
              [
                #text(size: 29pt, weight: "bold", fill: color-accent, font: font-heading, stat-sub) \
                #v(3pt)
                #text(size: 9.6pt, weight: "bold", fill: color-body, font: font-body, stat-sub-label)
              ]
            )
          ] else [
            #align(center, [
              #text(size: 32pt, weight: "bold", fill: accent, font: font-heading, stat-main) \
              #v(3pt)
              #text(size: 10.2pt, weight: "bold", fill: color-body, font: font-body, stat-label)
            ])
          ]
        ]
      ),
      v(15pt),
      // 4. Punchy Verdict
      text(size: 14pt, weight: "bold", fill: color-body, font: font-heading, verdict-headline),
      v(8pt),
      par(leading: 0.52em)[#text(size: 12.2pt, fill: color-body.lighten(6%), font: font-body, verdict-body)],
    )
  )
}

/// Horizontal policy recommendation pathway row for Slide 11
#let policy-row(
  number: "01",
  pillar-tag: [],
  target-agency: [],
  icon: none,
  title: [],
  action-1-title: [],
  action-1-body: [],
  action-2-title: [],
  action-2-body: [],
  impact-label: none,
  impact-target: [],
  impact-stat: none,
  accent: color-title,
) = {
  block(
    fill: color-card-bg,
    stroke: 1.1pt + color-card-stroke,
    radius: 9pt,
    inset: (x: 15pt, y: 10pt),
    width: 100%,
    breakable: false,
    grid(
      columns: (215pt, 1fr, 185pt),
      gutter: 14pt,
      align: (horizon + left, horizon + left, horizon + center),
      // Columna 1: Pilar, Título y Entidad Ejecutora
      stack(
        dir: ttb,
        spacing: 0pt,
        grid(
          columns: (auto, 1fr),
          gutter: 6pt,
          align: (horizon + left, horizon + left),
          box(
            fill: accent,
            radius: 3pt,
            inset: (x: 6pt, y: 2.5pt),
            text(size: 8pt, weight: "bold", fill: white, font: font-heading)[#number #sym.bar.v #pillar-tag]
          ),
          if icon != none [
            #box(
              fill: accent,
              radius: 4pt,
              width: 20pt,
              height: 20pt,
              align(center + horizon, box(width: 13pt, icon))
            )
          ] else [ ]
        ),
        v(4.5pt),
        text(size: 14pt, weight: "bold", fill: accent, font: font-heading, title),
        v(3pt),
        text(size: 8.2pt, weight: "bold", fill: color-accent, font: font-body, target-agency),
      ),
      // Columna 2: Acciones Estratégicas (Inmediata y Estructural) en dos columnas internas
      grid(
        columns: (1fr, 1fr),
        gutter: 13pt,
        // Acción Inmediata
        stack(
          dir: ttb,
          spacing: 2.5pt,
          box(
            fill: accent.lighten(92%),
            radius: 2.5pt,
            inset: (x: 4.5pt, y: 2pt),
            text(size: 7.2pt, weight: "bold", fill: accent, font: font-heading)[ACCIÓN INMEDIATA]
          ),
          text(size: 10.4pt, weight: "bold", fill: color-title, font: font-heading, action-1-title),
          par(leading: 0.40em)[#text(size: 9.2pt, fill: color-body, font: font-body, action-1-body)],
        ),
        // Reforma Estructural
        stack(
          dir: ttb,
          spacing: 2.5pt,
          box(
            fill: accent.lighten(92%),
            radius: 2.5pt,
            inset: (x: 4.5pt, y: 2pt),
            text(size: 7.2pt, weight: "bold", fill: accent, font: font-heading)[REFORMA ESTRUCTURAL]
          ),
          text(size: 10.4pt, weight: "bold", fill: color-title, font: font-heading, action-2-title),
          par(leading: 0.40em)[#text(size: 9.2pt, fill: color-body, font: font-body, action-2-body)],
        ),
      ),
      // Columna 3: Indicador de Impacto / Contexto Cuantitativo
      block(
        fill: accent.lighten(94%),
        stroke: 0.8pt + accent.lighten(65%),
        radius: 8pt,
        inset: (x: 9pt, y: 8pt),
        width: 100%,
        stack(
          dir: ttb,
          spacing: 0pt,
          align(center, [
            #if impact-label != none and impact-label != [] [
              #box(
                fill: accent.lighten(88%),
                radius: 2.5pt,
                inset: (x: 5.5pt, y: 1.8pt),
                text(size: 7pt, weight: "bold", fill: accent, font: font-heading, impact-label)
              )
              #v(2.5pt)
            ]
            #if impact-stat != none [
              #text(size: 20pt, weight: "bold", fill: accent, font: font-heading, impact-stat) \
              #v(2pt)
            ]
            #par(leading: 0.38em)[#text(size: 8.2pt, fill: color-body, font: font-body, impact-target)]
          ])
        )
      )
    )
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
// SPEAKER MARKER TEMPLATE
// ==========================================

/// Institutional speaker color palette presets
#let speaker-colors = (
  "A": rgb("#7030A0"), // Púrpura institucional UNAN
  "B": rgb("#008080"), // Verde azulado / Teal
  "C": rgb("#C05621"), // Ocre cálido / Ámbar
  "D": rgb("#1F4E79"), // Azul marino profundo
)

/// Speaker marker box placed in a designated slide corner
#let speaker-marker(
  letter,
  color: auto,
  position: top + right,
  dx: auto,
  dy: auto,
  size: 30pt,
  radius: 6pt,
) = {
  let fill-color = if color == auto {
    speaker-colors.at(str(letter), default: color-title)
  } else {
    color
  }

  let (offset-x, offset-y) = if dx != auto and dy != auto {
    (dx, dy)
  } else if position == top + right {
    (if dx != auto { dx } else { 36pt }, if dy != auto { dy } else { -68pt })
  } else if position == bottom + right {
    (if dx != auto { dx } else { 36pt }, if dy != auto { dy } else { 10pt })
  } else if position == top + left {
    (if dx != auto { dx } else { -36pt }, if dy != auto { dy } else { -68pt })
  } else {
    (0pt, 0pt)
  }

  place(
    position,
    dx: offset-x,
    dy: offset-y,
    box(
      fill: fill-color,
      width: size,
      height: size,
      radius: radius,
      align(center + horizon, text(
        fill: white,
        size: size * 0.52,
        weight: "bold",
        font: font-heading,
        letter,
      ))
    )
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
  speaker: none,
) = {
  slide[
    #if speaker != none {
      speaker-marker(speaker)
    }
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
