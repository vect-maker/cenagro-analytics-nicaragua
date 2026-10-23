#import "@preview/touying:0.8.0": *

// ==========================================
// INSTITUTIONAL PALETTE & CONSTANTS
// ==========================================
#let color-title = rgb("#7030A0")
#let color-body = rgb("#133454")
#let color-accent = rgb("#1a4d8f")

#let font-heading = ("Montserrat", "Liberation Sans")
#let font-body = ("Liberation Sans",)

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
      margin: (left: 66pt, right: 66pt, top: 143.8pt, bottom: 40pt),
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

/// Title slide matching Plantilla PPT layout
#let title-slide(
  title: [Escriba su texto],
  subtitle: [Escriba el texto],
  extra: none,
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

  touying-slide(
    self: self,
    config: config,
    {
      place(
        top + left,
        dx: 520.6pt,
        dy: 197.8pt,
        block(
          width: 412.8pt,
          text(
            fill: color-title,
            size: 44pt,
            weight: "semibold",
            font: font-heading,
            title,
          )
        )
      )

      place(
        top + left,
        dx: 520.6pt,
        dy: 286.2pt,
        block(
          width: 412.8pt,
          {
            text(
              fill: color-body,
              size: 28pt,
              font: font-body,
              subtitle,
            )
            if extra != none {
              v(0.8em)
              text(
                fill: color-body.lighten(20%),
                size: 16pt,
                font: font-body,
                extra,
              )
            }
          }
        )
      )
    }
  )
})

/// Ending / conclusion slide
#let ending-slide(
  config: (:),
  body: none,
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
    if body != none {
      align(center + horizon, text(fill: white, size: 32pt, font: font-heading, body))
    } else {
      none
    }
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
    size: 24pt,
    lang: "es",
  )

  set list(
    marker: ([•], [–], [·]),
    spacing: 1.2em,
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
