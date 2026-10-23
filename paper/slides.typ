#import "slides-template.typ": *
#import "charts.typ": *
#import "metadata.typ": *
#import "content/objectives.typ": *
#import "content/figures.typ": fig-caption, fig-ref

#show: cenagro-theme.with()

// ============================================================
// DIAPOSITIVA 1: PORTADA
// ============================================================
#title-slide(
  title: title,
  authors: authors,
  tutor: tutor,
)

// ============================================================
// DIAPOSITIVA 2: PROBLEMA Y CONTEXTO
// ============================================================
= Problema y contexto de la investigación

#grid(
  columns: (1fr, 220pt),
  gutter: 24pt,
  align: (top + left, center + horizon),
  [
    #v(0.2em)
    #text(size: 21pt, weight: "bold", fill: color-title)[¿Qué cambia en las fincas cuando acceden a financiamiento?]
    #v(0.6em)
    #text(size: 17pt, fill: color-body)[
      Se comparan unidades financiadas y no financiadas en tres dimensiones:
    ]
    #v(0.8em)
    #list(
      [*Acceso y fuentes de crédito*],
      [*Intensidad y estabilidad del empleo*],
      [*Diversificación de rubros y uso del suelo*],
    )
  ],
  [
    #block(
      fill: color-badge-bg,
      stroke: 1.5pt + color-card-stroke,
      radius: 12pt,
      inset: (x: 24pt, y: 28pt),
      align(center, [
        #text(size: 24pt, weight: "bold", fill: color-title, font: font-heading)[CENAGRO]
        #v(0.4em)
        #text(size: 32pt, weight: "bold", fill: color-accent, font: font-heading)[2011]
      ])
    )
  ]
)

// ============================================================
// DIAPOSITIVA 3: OBJETIVOS
// ============================================================
= Objetivos de la investigación

#v(0.1em)
#block(
  fill: color-card-bg,
  stroke: 1.2pt + color-title.lighten(50%),
  radius: 8pt,
  inset: (x: 16pt, y: 10pt),
  width: 100%,
  [
    #text(size: 15.5pt, weight: "bold", fill: color-title, font: font-heading)[Objetivo General: ]
    #text(size: 14.5pt, fill: color-body, font: font-body)[#objetivo-general]
  ]
)

#v(0.4em)
#stack(
  spacing: 8pt,
  card-numbered(number: 1, text-content: objetivo-especifico-1, size: 14pt),
  card-numbered(number: 2, text-content: objetivo-especifico-2, size: 14pt),
  card-numbered(number: 3, text-content: objetivo-especifico-3, size: 14pt),
)

// ============================================================
// DIAPOSITIVA 4: METODOLOGÍA
// ============================================================
= Metodología y procesamiento de datos

#grid(
  columns: (1fr, 250pt),
  gutter: 24pt,
  align: (top + left, top + center),
  [
    #v(0.4em)
    #list(
      [Enfoque cuantitativo, no experimental, transversal.],
      [*227,541* explotaciones oficiales; *262,546* registros analíticos.],
      [Comparación con/sin financiamiento y por tamaño de finca.],
      [Medianas, porcentajes e índices de uso de suelo.],
    )
  ],
  [
    #stack(
      spacing: 12pt,
      pipeline-badge(title: [SPSS → Parquet]),
      pipeline-badge(title: [Rust / DataFusion]),
      pipeline-badge(title: [DuckDB → Gráficos]),
    )
  ]
)

// ============================================================
// DIAPOSITIVA 5: OBJETIVO 3 - ACCESO
// ============================================================
= Objetivo 3 | Acceso al financiamiento

#slide-chart(
  chart-fn: chart-embudo(),
  caption: fig-caption("embudo"),
  stat: [15.9% solicitó crédito],
  body: [De 262,546 registros, 41,756 solicitudes. Entre ellas, la aprobación alcanzó el 92.6%.],
)

// ============================================================
// DIAPOSITIVA 6: OBJETIVO 3 - FUENTES
// ============================================================
= Objetivo 3 | Fuentes de financiamiento

#slide-chart(
  chart-fn: chart-fuentes(),
  caption: fig-caption("fuentes"),
  stat: [52.6% banca privada],
  body: [La banca privada concentró la mayor proporción de créditos; las cooperativas ocuparon el segundo lugar (28.2%).],
)

// ============================================================
// DIAPOSITIVA 7: OBJETIVO 1 - INTENSIDAD LABORAL
// ============================================================
= Objetivo 1 | Intensidad laboral

#slide-chart(
  chart-fn: chart-intensidad(),
  caption: fig-caption("intensidad"),
  stat: [+171.6%],
  body: [En fincas medianas y grandes con crédito: 0.326 #box[trabajadores/Mz] frente a 0.120 sin crédito.],
)

// ============================================================
// DIAPOSITIVA 8: OBJETIVO 1 - ESTABILIDAD LABORAL
// ============================================================
= Objetivo 1 | Estabilidad laboral

#slide-chart(
  chart-fn: chart-estabilidad(),
  caption: fig-caption("estabilidad"),
  stat: [68.6% solo temporal],
  body: [Entre las fincas financiadas prevaleció el empleo estacional; más contratación no implicó mayor estabilidad.],
)

// ============================================================
// DIAPOSITIVA 9: OBJETIVO 2 - DIVERSIFICACIÓN
// ============================================================
= Objetivo 2 | Diversificación productiva

#slide-chart(
  chart-fn: chart-complejidad(),
  caption: fig-caption("complejidad"),
  stat: [De 2 a 3 rubros],
  body: [La categoría más frecuente pasó de 2 rubros sin crédito a 3 con crédito. Promedios: 3.36 y 3.65.],
)

// ============================================================
// DIAPOSITIVA 10: OBJETIVO 2 - USO DEL SUELO
// ============================================================
= Objetivo 2 | Uso del suelo

#slide-chart(
  chart-fn: chart-vocacion(),
  caption: fig-caption("vocacion"),
  stat: [22.9% en permanentes],
  body: [Frente al 13.6% sin crédito. El ratio pasto-cultivo bajó de 4.18 a 2.71.],
)

// ============================================================
// DIAPOSITIVA 11: CONCLUSIONES
// ============================================================
= Conclusiones vinculadas a los objetivos

#v(0.1em)
#stack(
  spacing: 10pt,
  card-numbered(
    number: 1,
    text-content: [El crédito se relaciona con mayor intensidad de empleo, pero predomina la temporalidad.]
  ),
  card-numbered(
    number: 2,
    text-content: [Las explotaciones financiadas muestran más cultivos permanentes y mayor diversificación.]
  ),
  card-numbered(
    number: 3,
    text-content: [La principal barrera aparece antes de solicitar: *84.1%* no llegó a tramitar crédito.]
  ),
)

#v(14pt)
#caution-box[
  #text(weight: "bold")[Nota metodológica:] Hallazgos descriptivos del CENAGRO 2011; no establecen causalidad por sí solos.
]

// ============================================================
// DIAPOSITIVA 12: CIERRE
// ============================================================
#ending-slide(message: [Muchas gracias])
