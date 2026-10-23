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
  columns: (1fr, 1fr, 1fr),
  gutter: 14pt,
  feature-card(
    icon: slide-icons.database,
    title: [Contexto y Datos],
    subtitle: [Pilar agrario y universo censal],
    body: [
      #list(
        [*Pilar socioeconómico:* Base del empleo rural, divisas y seguridad alimentaria en Nicaragua.],
        [*CENAGRO 2011:* 227,541 fincas consolidadas en *262,546 registros analíticos* (INIDE / MAGFOR).],
        [*Coyuntura de fomento:* Transición post-crisis 2008-2009 e impulso de banca de desarrollo (*Banco Produzcamos*).],
        [*Relevancia:* Pobreza multidimensional (*Sen*) y Plan Nacional de Lucha contra la Pobreza.],
      )
    ]
  ),
  feature-card(
    icon: slide-icons.alert-circle,
    title: [La Brecha Empírica],
    subtitle: [Limitaciones del análisis previo],
    body: [
      #list(
        [*Sesgo de agregación:* Literatura previa basada en encuestas muestrales acotadas que omitían la heterogeneidad de fincas.],
        [*Supuesto de ventanilla:* Se atribuía la exclusión a denegación bancaria sin verificar la tasa real de postulación.],
        [*Ingeniería de datos:* Necesidad de un *Modern Data Stack* (Rust + DuckDB) para procesar el microdato censal exhaustivo.],
        [*Aporte analítico:* Comparación controlada con/sin crédito estratificada por escala de finca (`farm_size_class`).],
      )
    ]
  ),
  feature-card(
    icon: slide-icons.help-circle,
    title: [Preguntas Clave],
    subtitle: [Paradojas a contrastar],
    body: [
      #list(
        [*Acceso:* ¿Fricción en ventanilla bancaria o autoexclusión previa por riesgo y colateral? (*Boucher et al.*).],
        [*Empleo:* ¿Multiplicador de empleo formal o financiamiento de picos temporales precarios?],
        [*Producción:* ¿Rompe la trampa del pastoreo extensivo hacia cultivos perennes diversificados?],
        [*Impacto:* Evidencia cuantitativa microeconómica para informar políticas de crédito rural focalizado.],
      )
    ]
  )
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
// DIAPOSITIVA: CONCLUSIONES
// ============================================================
= Conclusiones científicas y respuestas al problema

#grid(
  columns: (1fr, 1fr, 1fr),
  gutter: 14pt,
  feature-card(
    icon: slide-icons.credit-card,
    title: [1. Acceso al Crédito],
    subtitle: [Exclusión de entrada vs ventanilla],
    height: 275pt,
    body: [
      #list(
        [*Falla de entrada, no de ventanilla:* Tasa de aprobación bancaria de *92.6%* frente a *84.1%* que ni siquiera postula.],
        [*Mecanismos de fricción:* Autoexclusión por aversión al riesgo de pérdida patrimonial y falta de garantías (*Boucher et al.*).],
        [*Concentración institucional:* Dominio de la banca privada (*52.6%*), con banca estatal marginal (*1.7%*).],
      )
    ]
  ),
  feature-card(
    icon: slide-icons.trending-up,
    title: [2. Dinámica Laboral],
    subtitle: [Expansión y estacionalidad],
    height: 275pt,
    body: [
      #list(
        [*Multiplicador de jornales:* Fuerte alza de intensidad laboral (*+171.6%* medianas/grandes, *+33.3%* pequeñas); refuta mecanización excluyente.],
        [*Paradoja de precariedad:* El *68.6%* de las fincas con crédito opera exclusivamente con mano de obra temporal.],
        [*Destino del crédito:* Absorbe picos de zafra y siembra sin traducirse en formalización contractual fija.],
      )
    ]
  ),
  feature-card(
    icon: slide-icons.layers,
    title: [3. Uso del Suelo],
    subtitle: [Intensificación y diversificación],
    height: 275pt,
    body: [
      #list(
        [*Ruptura de la trampa extensiva:* Aumento de cultivos permanentes al *22.9%* (vs 13.6%) y caída del ratio pasto/cultivo a *2.71* (vs 4.18).],
        [*Diversificación modal:* Desplazamiento del pico modal de 2 a *3 rubros*, mejorando la resiliencia productiva.],
        [*Intensificación:* Validación empírica de Boserup: el capital viabiliza reconversión hacia rubros perennes.],
      )
    ]
  )
)

#v(8pt)
#caution-box[
  #text(weight: "bold")[Aporte metodológico y de Ciencia de Datos:] Análisis censal exhaustivo (262,546 microdatos) mediante arquitectura reproducible en Rust y DuckDB. Hallazgos descriptivos de corte transversal que no asumen causalidad contrafactual estricta.
]

// ============================================================
// DIAPOSITIVA: RECOMENDACIONES Y PROYECCIONES
// ============================================================
= Recomendaciones de política pública y proyecciones

#grid(
  columns: (1fr, 1fr, 1fr),
  gutter: 14pt,
  feature-card(
    icon: slide-icons.shield,
    title: [1. Crédito Inclusivo],
    subtitle: [Garantías y mitigación de riesgo],
    height: 330pt,
    body: [
      #list(
        [*Garantías recíprocas:* Fondos de aval solidario mediante Banco Produzcamos y cooperativas para mitigar la exigencia de hipotecas.],
        [*Microseguros agrícolas:* Instrumentos de cobertura ante choques climáticos para atenuar la autoexclusión por riesgo patrimonial.],
        [*Cobertura territorial:* Expandir ventanillas financieras en municipios de menor penetración bancaria.],
      )
    ]
  ),
  feature-card(
    icon: slide-icons.users,
    title: [2. Empleo Digno],
    subtitle: [Incentivos a la formalización],
    height: 330pt,
    body: [
      #list(
        [*Líneas preferenciales:* Bonificar tasas de interés para fincas que contraten mano de obra continua y estable.],
        [*Seguridad social rural:* Vincular financiamiento productivo a esquemas simplificados de formalización laboral.],
        [*Asistencia técnica:* Programas de capacitación especializada para el manejo de cultivos permanentes.],
      )
    ]
  ),
  feature-card(
    icon: slide-icons.database,
    title: [3. Datos & Transición],
    subtitle: [Gestión pública y crédito verde],
    height: 330pt,
    body: [
      #list(
        [*Crédito verde:* Financiamiento condicionado a reconversión de pastos degradados a sistemas agroforestales.],
        [*Modern Data Stack en el Estado:* Adoptar formatos abiertos (Parquet) y DuckDB en INIDE/MAG para auditar microdatos censales.],
        [*Proyección analítica:* Modelado predictivo de riesgo crediticio con Machine Learning y seguimiento por paneles sintéticos.],
      )
    ]
  )
)

// ============================================================
// DIAPOSITIVA: CIERRE
// ============================================================
#ending-slide(message: [Muchas gracias por su atención])
