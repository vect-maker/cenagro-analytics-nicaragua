#import "metadata.typ": *
#import "content/abstract.typ": (
  resumen-es,
  palabras-clave-es,
  abstract-en,
  keywords-en,
)

#set document(
  title: [Resumen JUDC: #title],
  author: authors.map(a => a.formal-name),
  date: date,
)

#set page(
  paper: "us-letter",
  margin: (top: 2.54cm, bottom: 2.54cm, left: 2.54cm, right: 2.54cm),
  footer: context {
    let i = counter(page).get().first()
    align(center, text(size: 10pt, fill: luma(80))[#i])
  }
)

#set text(
  font: "Liberation Serif",
  size: 12pt,
  lang: "es",
)

#set par(
  justify: true,
  leading: 0.7em,
  spacing: 0.85em,
)

#show link: it => text(fill: rgb("#1a4d8f"), underline(it))

// ==========================================
// DATOS DE LA INVESTIGACIÓN Y FORMULARIO
// ==========================================

#block(spacing: 0.45em)[
  *Categoría de Participación:* #judc-category \
  *Forma de Presentación:* #judc-modality \
  *Departamento:* #department \
  *Carrera de:* #career (#degree-level) \
]

#v(0.15em)
*Título:* \
#title

#v(0.3em)
*Autores:*
#block(inset: (left: 0.5cm))[
  #grid(
    columns: (auto, 1fr),
    row-gutter: 0.35em,
    column-gutter: 0.4em,
    ..authors.enumerate().map(((i, a)) => (
      [#(i + 1).],
      [*#a.formal-name*; #link("mailto:" + a.email)[#a.email]; #link("https://orcid.org/" + a.orcid)]
    )).flatten()
  )
]

#v(0.15em)
*Tutor:* #tutor.name; #link("mailto:" + tutor.email)[#tutor.email]; #link("https://orcid.org/" + tutor.orcid)

#v(0.4em)
#align(center)[
  #text(weight: "bold", size: 12.5pt)[Resumen]
]

#resumen-es

#v(0.4em)
*Palabras clave:* #palabras-clave-es.join(", ").

#v(0.8em)
#align(center)[
  #text(weight: "bold", size: 12.5pt)[Abstract]
]

#abstract-en

#v(0.4em)
*Keywords:* #keywords-en.join(", ").


