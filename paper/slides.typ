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

#speaker-marker("A")

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

#speaker-marker("A")

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
// METODOLOGÍA 1: ENFOQUE, POBLACIÓN E INGESTA CENSAL
// ============================================================
= Enfoque de investigación, población e ingesta censal

#speaker-marker("B")

#grid(
  columns: (1fr, 24pt, 1.15fr, 24pt, 1fr),
  align: horizon,
  pipeline-node(
    logo: image("images/presentation/logos/spss.png"),
    title: [CENAGRO 2011],
    subtitle: [Microdato oficial (.sav)],
    tag: [Universo Censal],
    accent: rgb("#8a4b08"),
    fill: rgb("#fffaf3"),
  ),
  flow-arrow,
  pipeline-node(
    logo: image("images/presentation/logos/python.svg"),
    title: [Python (pyreadstat)],
    subtitle: [Script de extracción e ingesta],
    tag: [Motor de Ingesta],
    accent: color-title,
    fill: color-card-bg,
  ),
  flow-arrow,
  stack(
    spacing: 6pt,
    pipeline-node(
      logo: image("images/presentation/logos/parquet.svg"),
      title: [raw_farms.parquet],
      subtitle: [Datos columnares crudos],
      tag: [Almacén Columnar],
      accent: rgb("#198754"),
      fill: rgb("#f0faf3"),
    ),
    pipeline-node(
      logo: box(fill: color-accent, radius: 4pt, width: 22pt, height: 22pt, align(center + horizon, box(width: 14pt, height: 14pt, slide-icons.file-text))),
      title: [metadata.json],
      subtitle: [Diccionario censal estructurado],
      tag: [Semántica & Codebook],
      accent: color-accent,
      fill: rgb("#f5f8fc"),
    )
  )
)

#v(8pt)

#grid(
  columns: (1fr, 1fr, 1fr),
  gutter: 12pt,
  feature-card(
    icon: slide-icons.target,
    title: [Enfoque y Tipo],
    subtitle: [Cuantitativo y transversal],
    height: auto,
    body: [
      #list(
        [*Enfoque cuantitativo:* Diseño no experimental y de corte transversal con alcance descriptivo-correlacional.],
        [*Método comparativo:* Evaluación empírica de brechas entre fincas con y sin financiamiento crediticio.],
        [*Sin intervención:* Análisis observacional riguroso sobre el ciclo censal oficial de Nicaragua.],
      )
    ]
  ),
  feature-card(
    icon: image("images/presentation/logos/spss.png"),
    badge-fill: white,
    title: [Población Censal],
    subtitle: [227,541 fincas (universo exhaustivo)],
    height: auto,
    body: [
      #list(
        [*Población objetivo:* Totalidad de las explotaciones agropecuarias del IV CENAGRO 2011 (INIDE / MAGFOR).],
        [*262,546 registros:* Microdatos consolidados por parcelas, tenencia y aprovechamiento de tierra.],
        [*Sin sesgo muestral:* Cobertura censal exhaustiva que supera las distorsiones de muestras acotadas.],
      )
    ]
  ),
  feature-card(
    icon: image("images/presentation/logos/parquet.svg"),
    badge-fill: white,
    title: [Unidad de Análisis],
    subtitle: [Explotación Agropecuaria (EA)],
    height: auto,
    body: [
      #list(
        [*Definición censal:* Extensión de tierra para actividades agropecuarias bajo una administración única.],
        [*Desacoplamiento:* Extracción con Python (`pyreadstat`) a Parquet crudo y diccionario a JSON estructurado.],
        [*Integridad semántica:* Preservación de 100% de categorías, encodings y etiquetas sin alteración.],
      )
    ]
  )
)

// ============================================================
// METODOLOGÍA 2: PIPELINE ETL EN RUST
// ============================================================
= Pipeline de transformación vectorizada en Rust

#speaker-marker("B")

#grid(
  columns: (1fr, 24pt, 1.25fr, 24pt, 1fr),
  align: horizon,
  pipeline-node(
    logo: image("images/presentation/logos/parquet.svg"),
    title: [Parquet Crudo],
    subtitle: [Input desacoplado],
    tag: [Microdato Base],
    accent: rgb("#8a4b08"),
    fill: rgb("#fffaf3"),
  ),
  flow-arrow,
  pipeline-node(
    logo: image("images/presentation/logos/rust.svg"),
    title: [Rust + DataFusion],
    subtitle: [Motor vectorizado Apache Arrow],
    tag: [Transformación Zero-GC],
    accent: color-title,
    fill: color-card-bg,
  ),
  flow-arrow,
  pipeline-node(
    logo: image("images/presentation/logos/parquet.svg"),
    title: [farms.parquet],
    subtitle: [Compresión Snappy],
    tag: [-90% Espacio en Disco],
    accent: rgb("#198754"),
    fill: rgb("#f0faf3"),
  )
)

#v(8pt)

#grid(
  columns: (1fr, 1fr, 1fr),
  gutter: 12pt,
  feature-card(
    icon: image("images/presentation/logos/rust.svg"),
    badge-fill: white,
    title: [Seguridad en Rust],
    subtitle: [Zero-GC & Type-Safe],
    height: auto,
    body: [
      #list(
        [*Gestión determinista:* Cero pausas de *Garbage Collector* y cero fugas de memoria.],
        [*Tipado en compilación:* Verificación estricta de esquemas antes de ejecución.],
        [*Vectores Apache Arrow:* Procesamiento columnar contiguo en registros de CPU.],
      )
    ]
  ),
  feature-card(
    icon: image("images/presentation/logos/datafusion.svg"),
    badge-fill: white,
    title: [Downcasting y Caché],
    subtitle: [Alineación con CPU L1/L2],
    height: auto,
    body: [
      #list(
        [*Tipos mínimos viables:* Downcasting a enteros `i8`/`i16` y banderas booleanas.],
        [*Hash Join masivo:* Cruce vectorizado de fincas y parcelas con alta tasa de caché.],
        [*Eficiencia energética:* Ejecución en hardware estándar sin clusters distribuidos.],
      )
    ]
  ),
  feature-card(
    icon: image("images/presentation/logos/parquet.svg"),
    badge-fill: white,
    title: [Compresión y Métricas],
    subtitle: [Artefacto farms.parquet],
    height: auto,
    body: [
      #list(
        [*Dictionary Encoding:* Cadenas categóricas comprimidas a diccionarios de enteros.],
        [*-90% en disco:* De 100 MB crudos a 10 MB Parquet con compresión Snappy.],
        [*Métricas derivadas:* Estratos censales (`farm_size_class`) e intensidades listos.],
      )
    ]
  )
)

// ============================================================
// METODOLOGÍA 3: HUB ANALÍTICO OLAP Y ENTREGA MULTI-TARGET
// ============================================================
= Hub analítico OLAP y reproducibilidad multi-target

#speaker-marker("B")

#grid(
  columns: (1fr, 22pt, 1.15fr, 22pt, 1.25fr),
  align: horizon,
  pipeline-node(
    logo: image("images/presentation/logos/parquet.svg"),
    title: [farms.parquet],
    subtitle: [Artefacto canónico],
    tag: [Almacén Inmutable],
    accent: rgb("#198754"),
    fill: rgb("#f0faf3"),
  ),
  flow-arrow,
  pipeline-node(
    logo: image("images/presentation/logos/duckdb-icon.svg"),
    title: [DuckDB OLAP],
    subtitle: [Motor analítico embebido],
    tag: [Cálculo en Memoria],
    accent: color-title,
    fill: color-card-bg,
  ),
  flow-arrow,
  stack(
    spacing: 5pt,
    pipeline-node(
      logo: box(fill: rgb("#1F4E79"), radius: 4pt, width: 22pt, height: 22pt, align(center + horizon, box(width: 14pt, height: 14pt, slide-icons.terminal))),
      title: [DuckDB CLI],
      subtitle: [Exploración interactiva y ad-hoc],
      tag: [EDA Ágil],
      accent: rgb("#1F4E79"),
      fill: rgb("#f5f8fc"),
    ),
    pipeline-node(
      logo: image("images/presentation/logos/evidence.svg"),
      title: [Evidence.dev],
      subtitle: [Portal BI web interactivo],
      tag: [Markdown + SQL],
      accent: rgb("#7030A0"),
      fill: rgb("#fbfafc"),
    ),
    pipeline-node(
      logo: image("images/presentation/logos/typst.svg"),
      title: [Typst + CeTZ],
      subtitle: [Paper y diapositivas (via CSVs)],
      tag: [Paper-as-Code],
      accent: rgb("#008080"),
      fill: rgb("#f0faf8"),
    ),
  )
)

#v(6pt)

#grid(
  columns: (1fr, 1fr, 1fr),
  gutter: 12pt,
  feature-card(
    icon: image("images/presentation/logos/duckdb-icon.svg"),
    badge-fill: white,
    title: [Motor OLAP Embebido],
    subtitle: [Rigor estadístico sin sesgos],
    height: auto,
    body: [
      #list(
        [*Lecturas Zero-Copy:* Consultas analíticas en memoria directo sobre Parquet.],
        [*UNPIVOT matricial:* Pivotado dinámico de fuentes y rubros sin duplicar datos.],
        [*Estadística robusta:* Medianas e IQR inmunes a distorsiones por fincas gigantes.],
      )
    ]
  ),
  feature-card(
    icon: image("images/presentation/logos/evidence.svg"),
    badge-fill: white,
    title: [Trifecta de Consumo],
    subtitle: [CLI, Portal BI y Publicación],
    height: auto,
    body: [
      #list(
        [*DuckDB CLI:* Exploración ágil, validación de hipótesis y auditoría de microdatos.],
        [*Portal Evidence:* Tablero web interactivo reactivo con consultas SQL directas.],
        [*Publicación Typst:* Generación canónica de datos (`export-paper-data.sql`).],
      )
    ]
  ),
  feature-card(
    icon: image("images/presentation/logos/typst.svg"),
    badge-fill: white,
    title: [Paper-as-Code],
    subtitle: [Reproducibilidad absoluta],
    height: auto,
    body: [
      #list(
        [*Fuente única de verdad:* Cero discrepancias entre paper, diapositivas y portal.],
        [*Cero copy-paste:* Gráficos CeTZ generados automáticamente desde CSVs de DuckDB.],
        [*Entorno inmutable:* Pipeline reproducible en hardware común (`just compile-paper`).],
      )
    ]
  )
)

// ============================================================
// RESULTADOS 1: CRÉDITO (EMBUDO + FUENTES)
// ============================================================
= Ecosistema crediticio: acceso y fuentes de financiamiento

#slide-dual-chart(
  speaker: "C",
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
  speaker: "C",
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
  speaker: "D",
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

#speaker-marker("D")

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

#speaker-marker("D")

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
