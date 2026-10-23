#import "@preview/touying:0.8.0": *

// ==========================================
// INSTITUTIONAL PALETTE & CONSTANTS
// ==========================================
#let color-title = rgb("#7030A0")
#let color-body = rgb("#133454")
#let color-accent = rgb("#1a4d8f")
#let color-card-bg = rgb("#f8f7fc")
#let color-card-stroke = rgb("#e0d7f0")
#let color-badge-bg = rgb("#ede8f7")

#let font-heading = ("Montserrat", "Liberation Sans")
#let font-body = ("Liberation Sans",)

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

/// Caution / disclaimer container
#let caution-box(body) = {
  block(
    fill: rgb("#fff9f0"),
    stroke: 1pt + rgb("#f5d0a9"),
    radius: 8pt,
    inset: (x: 14pt, y: 10pt),
    width: 100%,
    text(fill: rgb("#8a4b08"), size: 13pt, font: font-body, body)
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
      dy: 28.8pt,
      block(
        width: 828pt,
        height: 104.4pt,
        align(top + left, text(
          fill: color-title,
          size: 40pt,
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
      margin: (left: 66pt, right: 66pt, top: 130pt, bottom: 35pt),
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

/// High-level slide generator for the 6 chart slides
#let slide-chart(
  chart-fn: none,
  caption: [],
  stat: [],
  body: [],
  footnote: [],
) = {
  slide[
    #grid(
      columns: (520pt, 1fr),
      gutter: 24pt,
      align: (center + horizon, horizon + left),
      [
        #block(width: 100%, align(center)[
          #set text(size: 10pt, font: "Liberation Serif")
          #chart-fn
          #if caption != [] [
            #v(0.5em)
            #text(size: 10pt, font: "Liberation Serif", caption)
          ]
        ])
      ],
      [
        #v(-10pt)
        #text(size: 24pt, weight: "bold", fill: color-title, font: font-heading, stat)
        #v(0.8em)
        #text(size: 16pt, fill: color-body, font: font-body, body)
      ]
    )
    #if footnote != [] [
      #place(
        top + left,
        dx: 11.8pt,
        dy: 320pt,
        text(size: 10.5pt, fill: luma(100), font: font-body, footnote)
      )
    ]
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
