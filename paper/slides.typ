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
// RESULTADOS 1: CRÉDITO (EMBUDO + FUENTES)
// ============================================================
= Ecosistema crediticio: acceso y fuentes de financiamiento

#slide-dual-chart(
  icon-1: slide-icons.credit-card,
  chart-fn-1: chart-embudo(),
  caption-1: fig-caption("embudo"),
  stat-1: [15.9% solicitó crédito],
  body-1: [De 262,546 explotaciones censadas, solo 41,756 solicitaron crédito. Sin embargo, la tasa de aprobación bancaria alcanzó un elevado 92.6%.],
  icon-2: slide-icons.dollar-sign,
  stat-2: [52.6% banca privada],
  body-2: [La banca comercial concentró la mayoría de créditos (18,255), seguida por cooperativas (28.2%) y ONGs (7.7%). Canales estatales e informales fueron minoritarios.],
  chart-fn-2: chart-fuentes(),
  caption-2: fig-caption("fuentes"),
)

// ============================================================
// RESULTADOS 2: EMPLEO (INTENSIDAD + ESTABILIDAD)
// ============================================================
= Dinámica laboral: intensidad y estabilidad del empleo

#slide-dual-chart(
  icon-1: slide-icons.trending-up,
  chart-fn-1: chart-intensidad(),
  caption-1: fig-caption("intensidad"),
  stat-1: [+171.6% en medianas y grandes],
  body-1: [En fincas medianas y grandes con crédito, la intensidad mediana subió a 0.326 trab/Mz frente a 0.120 sin crédito (+33.3% en pequeñas), confirmando absorción laboral.],
  icon-2: slide-icons.clock,
  stat-2: [68.6% empleo estacional],
  body-2: [El 68.6% de las fincas con crédito operó exclusivamente con mano de obra temporal. El crédito dinamizó picos de siembra y cosecha sin formalización contractual.],
  chart-fn-2: chart-estabilidad(),
  caption-2: fig-caption("estabilidad"),
)

// ============================================================
// RESULTADOS 3: PRODUCCIÓN (COMPLEJIDAD + USO DE SUELO)
// ============================================================
= Reconfiguración productiva: diversificación y uso del suelo

#slide-dual-chart(
  icon-1: slide-icons.layers,
  chart-fn-1: chart-complejidad(),
  caption-1: fig-caption("complejidad"),
  stat-1: [Pico modal en 3 rubros],
  body-1: [El pico más frecuente pasó de 2 rubros sin crédito (25.1%) a 3 rubros con crédito (23.7%), elevando el promedio de 3.36 a 3.65 rubros por finca.],
  icon-2: slide-icons.pie-chart,
  stat-2: [22.9% en cultivos permanentes],
  body-2: [Fincas con crédito destinaron 22.9% de su área a cultivos permanentes (vs. 13.6% sin crédito), reduciendo el ratio pasto-cultivo de 4.18 a 2.71 hacia la intensificación.],
  chart-fn-2: chart-vocacion(),
  caption-2: fig-caption("vocacion"),
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
