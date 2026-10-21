#import "charts.typ": (
  chart-embudo,
  chart-fuentes,
  chart-intensidad,
  chart-estabilidad,
  chart-complejidad,
  chart-vocacion,
)

#set document(
  title: "Impacto del Financiamiento en la Generación de Empleo y Diversificación Productiva de las Explotaciones Agropecuarias de Nicaragua (CENAGRO 2011)",
  author: (
    "José Daniel Miranda Pérez",
    "Kendall Ezequiel Aguilar Rodríguez",
    "Ricardo Alberto Oyarzo Morales",
    "Luis David Medrano Dávila"
  ),
  date: datetime(year: 2026, month: 10, day: 21)
)

#set page(
  paper: "us-letter",
  margin: (top: 2.54cm, bottom: 2.54cm, left: 2.54cm, right: 2.54cm),
  footer: context {
    let i = counter(page).get().first()
    if i > 1 {
      align(right, text(size: 11pt)[#(i - 1)])
    }
  }
)

#set text(
  font: "Liberation Serif",
  size: 12pt,
  lang: "es"
)

#show link: it => text(fill: rgb("1b58a6"), underline(it))

#set par(
  justify: true,
  leading: 0.65em,
  spacing: 1.05em
)

#set figure(gap: 0.8em)
#set figure.caption(separator: [. ])

#set list(spacing: 0.75em)
#set enum(spacing: 0.75em)

#show heading.where(level: 1): it => block(
  width: 100%,
  above: 1.5em,
  below: 0.9em,
  align(center, text(weight: "bold", size: 16pt)[#it.body])
)

#show heading.where(level: 2): it => block(
  above: 1.2em,
  below: 0.6em,
  text(weight: "bold", size: 13pt)[#it.body]
)

#show heading.where(level: 3): it => block(
  above: 1.0em,
  below: 0.4em,
  text(weight: "bold", size: 12pt)[#it.body]
)

// ==========================================
// PORTADA / COVER PAGE
// ==========================================
#align(center)[
  #text(size: 11pt, style: "italic")[
    «2026: Por una Educación al Servicio del Pueblo, ¡Viva Sandino!»
  ]

  #v(0.3cm)
  #image("images/image.jpg", width: 5.2cm)

  #v(0.3cm)
  #text(weight: "bold", size: 12pt)[
    Universidad Nacional Autónoma de Nicaragua, Managua \
    Recinto Universitario «Rubén Darío» \
    Área de Conocimiento de Ciencias Básicas y Tecnología \
    Departamento de Matemáticas \
    Carrera de Ingeniería en Ciencias de Datos \
  ]

  #v(0.2cm)
  #text(size: 11pt, weight: "medium")[
    Trabajo de investigación derivado de producto integrador de componentes curriculares
  ]

  #v(0.5cm)
  #text(weight: "bold", size: 11pt)[Título:] \
  #v(0.15cm)
  #text(weight: "bold", size: 13pt)[
    Impacto del Financiamiento en la Generación de Empleo y Diversificación Productiva de las Explotaciones Agropecuarias de Nicaragua (CENAGRO 2011)
  ]

  #v(0.5cm)
  #text(weight: "bold", size: 11pt)[Autor(es):] \
  #v(0.2cm)
  #block(width: 85%, align(left)[
    #grid(
      columns: (1fr),
      row-gutter: 0.5em,
      [Br. Miranda Pérez, José Daniel -- (ORCID: #link("https://orcid.org/0009-0006-5609-4765")[0009-0006-5609-4765])],
      [Br. Aguilar Rodríguez, Kendall Ezequiel -- (ORCID: #link("https://orcid.org/0009-0006-5763-1956")[0009-0006-5763-1956])],
      [Br. Oyarzo Morales, Ricardo Alberto -- (ORCID: #link("https://orcid.org/0009-0006-6388-0270")[0009-0006-6388-0270])],
      [Br. Medrano Dávila, Luis David -- (ORCID: #link("https://orcid.org/0009-0005-8777-7457")[0009-0005-8777-7457])],
    )
  ])

  #v(0.5cm)
  #text(weight: "bold", size: 11pt)[Tutor:] \
  #v(0.15cm)
  #text(size: 12pt)[MSc. Deyvi Antonio López Rojas]

  #v(0.6cm)
  #text(size: 11pt)[
    Managua, octubre de 2026
  ]
]

#pagebreak()

// ==========================================
// ÍNDICE GENERAL
// ==========================================
#{
  show outline.entry: it => {
    set text(size: 9.5pt)
    it
  }
  set par(leading: 0.45em)
  outline(
    title: [Índice],
    depth: 2,
    indent: 1.2em,
  )
}

#pagebreak()

// ==========================================
// RESUMEN
// ==========================================
= Resumen

El acceso equitativo a servicios financieros en el sector agropecuario de Nicaragua constituye un determinante crítico para el desarrollo socioeconómico; sin embargo, persiste una limitada evaluación empírica sobre su impacto estructural en el campo. La presente investigación analiza el efecto del financiamiento en la generación de empleo y la diversificación productiva a partir de los microdatos del IV Censo Nacional Agropecuario (CENAGRO 2011). Como producto integrador, el proyecto articula competencias del plan de estudios de Ingeniería en Ciencias de Datos: Integrador III (gestión y metodología de investigación), Base de Datos Relacionales (diseño del almacén dimensional OLAP), Programación I (pipeline ETL vectorizado de alto rendimiento en Rust con Apache DataFusion), Estadística I (análisis transversal descriptivo y control de sesgos por escala censal), Matemática III (optimización de transformaciones multidimensionales) e Inglés Técnico (revisión de literatura especializada y documentación de tecnologías analíticas abiertas). Metodológicamente, se implementó un diseño no experimental transversal, analizando más de 262,000 explotaciones mediante una arquitectura moderna de datos (DuckDB y Evidence.dev). Los resultados revelan una severa exclusión de entrada donde solo el 15.9% de los productores logró solicitar crédito, pese a una aprobación bancaria del 92.6%. En las fincas capitalizadas, la intensidad laboral mediana aumentó un 171.6% en unidades medianas y grandes, aunque concentrada en mano de obra estacional (72.5% de unidades operan con ratio permanente 0.0). Asimismo, el crédito redujo el ratio pasto-cultivo de 4.18 a 2.71, elevando la asignación de cultivos permanentes del 13.6% al 22.9% y desplazando la complejidad productiva modal hacia 3 rubros. Se concluye que el financiamiento dinamiza la absorción operativa y fomenta la intensificación tecnológica, pero perpetúa la precariedad contractual transitoria.

*Palabras clave:* Financiamiento rural, Intensidad laboral, Diversificación productiva, Ingeniería de datos, Producto integrador.

#pagebreak()

// ==========================================
// CAPÍTULO I: INTRODUCCIÓN
// ==========================================
= Introducción

== Contextualización del Tema

El sector agropecuario nicaragüense constituye el pilar histórico de la seguridad alimentaria, el empleo rural y las exportaciones del país. Sin embargo, su desempeño productivo y su capacidad de acumulación de capital han estado condicionados por fallas estructurales en el acceso a servicios financieros y marcadas asimetrías institucionales. Para comprender la estructura agraria contemporánea, resulta imperativo analizar el ciclo agrícola 2010-2011 capturado por el IV Censo Nacional Agropecuario (CENAGRO 2011), ejecutado por el Instituto Nacional de Información de Desarrollo (INIDE) y el Ministerio Agropecuario y Forestal (MAGFOR). Dicho levantamiento censal registró 227,541 explotaciones agropecuarias (consolidadas en 262,546 registros productivos en la base desnormalizada) en un momento histórico caracterizado por la recuperación macroeconómica posterior a la crisis financiera global de 2008-2009.

Durante este ciclo agrícola, el país experimentó una reconfiguración sustancial de sus políticas públicas de fomento a la producción rural. Se inició una transición desde modelos de mercado desregulados hacia esquemas con mayor intervención, fomento crediticio solidario y presencia de la banca estatal de desarrollo, cuyo hito institucional fue la puesta en marcha del Banco de Fomento a la Producción (Banco Produzcamos). Por tanto, la información provista por los productores en la boleta censal refleja directamente su grado de inserción, adaptación o exclusión frente al ecosistema financiero disponible durante dicho periodo @cenagro2013[pp. 1-3].

== Planteamiento del Problema

A pesar del consenso teórico sobre la importancia del crédito para dinamizar la producción agrícola, en Nicaragua ha persistido una limitada disponibilidad de evidencia cuantitativa exhaustiva que examine, a nivel de microdatos censales completos, el impacto real del financiamiento sobre la economía de las fincas. La mayoría de los análisis agrarios tradicionales se han sustentado en encuestas muestrales acotadas o estimaciones agregadas, las cuales omiten la heterogeneidad de las explotaciones y suelen atribuir las brechas de financiamiento a una supuesta denegación generalizada de solicitudes por parte de las entidades bancarias.

Esta carencia de análisis empírico microeconómico plantea interrogantes estructurales de alta relevancia:
+ ¿Reside la principal fricción del ecosistema financiero en una alta tasa de rechazo de solicitudes en ventanilla, o en una barrera de exclusión previa que impide a la mayoría de los productores postularse al crédito formal?
+ ¿Actúa el financiamiento como un multiplicador genuino de la densidad laboral y la estabilidad contractual, o se limita a costear picos de trabajo temporal sin alterar la precariedad del empleo agrario?
+ ¿Permite la inyección de liquidez romper la «trampa de la extensificación» ganadera, promoviendo la transición hacia cultivos perennes de alto rendimiento y una mayor complejidad productiva?

Resolver estas preguntas requiere procesar el universo censal sin sesgos de agregación, aislando empíricamente las diferencias entre unidades financiadas y no financiadas mientras se controla estadísticamente el tamaño de la explotación.

== Justificación

La justificación de esta investigación abarca dimensiones teóricas, metodológicas y de impacto social:

En el plano socioeconómico, la privación de servicios financieros en el campo no representa únicamente una restricción contable, sino una manifestación crítica de la *pobreza multidimensional*. Desde el enfoque de capacidades y libertades de Amartya Sen y el Programa de las Naciones Unidas para el Desarrollo (PNUD), el crédito opera como un habilitador de activos productivos que permite a los hogares rurales mitigar choques externos, adquirir insumos tecnológicos y estabilizar los ingresos de la mano de obra. 

Asimismo, la investigación se fundamenta en las prioridades estratégicas del Estado de Nicaragua, articulándose con el *Plan Nacional de Lucha contra la Pobreza para el Desarrollo Humano 2022-2026*, específicamente bajo su *Principio 4: Soberanía y Seguridad Alimentaria y Nutricional* y el *Eje 8: Producción en el Campo, Crédito y Diversificación* @grun2021[pp. 21, 98-103]. Proveer evidencia cuantitativa rigurosa a partir del CENAGRO permite informar la formulación de políticas públicas orientadas a democratizar los instrumentos de crédito rural y optimizar la asignación del gasto público.

Desde el punto de vista tecnológico y metodológico, este estudio supera las limitaciones computacionales clásicas del análisis censal. Mediante la adopción de un *Modern Data Stack* basado en software libre de alto rendimiento, se demuestra que la ingeniería de datos permite transformar millones de registros crudos en almacenes analíticos reproducibles, sentando un precedente técnico para la investigación científica aplicada en la universidad.

== Vinculación Curricular

El presente trabajo surge como resultado directo de la integración de competencias desarrolladas a lo largo del plan de estudios de la carrera de *Ingeniería en Ciencias de Datos* de la UNAN-Managua, articulando los aprendizajes de seis componentes curriculares:

- *CITG013 - Integrador III*: Eje articulador del proyecto, aportando las bases metodológicas de la investigación científica, la definición del problema, la formulación de objetivos, la gestión colaborativa del ciclo de vida del software y la redacción del informe técnico.
- *CPRG011 - Programación I*: Desarrollo de algoritmos de procesamiento de datos y construcción del pipeline ETL mediante tecnologías modernas de alto rendimiento en Rust (Apache DataFusion), aplicando principios de tipado estricto, gestión segura de memoria y ejecución vectorizada inmutable.
- *CEST011 - Estadística I*: Diseño de la metodología cuantitativa transversal, formulación de contrastes de cohortes, cálculo de estadísticos no paramétricos robustos (medianas y rangos intercuartílicos), construcción de distribuciones de frecuencia y control de sesgos por escala censal (`farm_size_class`).
- *CBDN020 - Base de Datos Relacionales*: Modelado dimensional de la bodega de datos analítica (_warehouse_) bajo esquema en estrella/copo de nieve, normalización de tablas de dimensiones y hechos (`farm_labor`, `farm_credit_access`, `farm_land_use`), aseguramiento de la integridad referencial y ejecución de consultas SQL analíticas avanzadas (CTEs, agregaciones por ventana y funciones `UNPIVOT`).
- *CMAT183 - Matemática III*: Fundamentación de operaciones matriciales y algebraicas subyacentes en el procesamiento columnar de vectores de datos en memoria, así como optimización de funciones matemáticas para el cálculo de distancias e índices de diversificación productiva.
- *CING020 - Inglés Técnico*: Consulta, comprensión y asimilación de documentación técnica especializada en idioma inglés para herramientas computacionales de frontera (Apache DataFusion, DuckDB, Evidence.dev, Typst), así como la redacción del ensayo técnico complementario de la investigación.

#pagebreak()

// ==========================================
// CAPÍTULO II: ANTECEDENTES Y FUNDAMENTACIÓN
// ==========================================
= Antecedentes y Fundamentación Teórica o Conceptual

== Estado del Arte y Estudios Previos sobre el Crédito Agropecuario

En América Latina y el Caribe, el crédito agropecuario ha sido objeto de exhaustivo debate empírico. Históricamente, las investigaciones agrarias han documentado que la baja penetración de los servicios bancarios en el campo obedece a costos de transacción prohibitivos, dispersión geográfica y carencia de títulos de propiedad formalizados que sirvan como colateral hipotecario. En el caso de Nicaragua, los estudios poscensales y diagnósticos institucionales han señalado que la estructura financiera rural se fragmenta entre una banca comercial altamente concentrada en exportadores tradicionales, un sector cooperativo de alcance territorial medio y una vasta red de prestamistas informales y acopiadores que imponen condiciones desfavorables a los pequeños productores @cenagro2013[pp. 1-4].

Sin embargo, los antecedentes empíricos han adolecido de limitaciones metodológicas: la mayoría de los análisis se han basado en agregados departamentales o encuestas de hogares rurales con muestras reducidas, lo cual impide modelar con precisión los mecanismos de exclusión y contrastar de forma controlada el desempeño de las fincas capitalizadas frente a las desprovistas de crédito.

== Fallas de Mercado Financiero y Racionamiento de Crédito

La comprensión teórica del crédito rural se fundamenta en el modelo seminal de racionamiento de crédito con información asimétrica desarrollado por @stiglitz1981. En los mercados financieros tradicionales, el mecanismo de ajuste de precios (la tasa de interés) falla en vaciar el mercado debido a la presencia de selección adversa (los prestatarios más riesgosos están dispuestos a aceptar tasas más altas) y riesgo moral (tasas elevadas incentivan proyectos agrícolas de mayor volatilidad). En consecuencia, los intermediarios financieros optan por fijar tasas de interés y racionar la oferta mediante exigencias estrictas de colateral o denegación directa.

En el contexto agrario de países en desarrollo, esta dinámica fue ampliada teórica y empíricamente por @boucher2008, quienes identifican que las barreras de acceso al crédito no se limitan al racionamiento formal por precio o colateral en ventanilla bancaria, sino que incluyen el _racionamiento por riesgo y la autoexclusión_. Los productores de subsistencia y pequeña escala, aun siendo potencialmente productivos y solventes, evitan solicitar préstamos formales por temor a perder sus tierras o medios de vida ante una pérdida de cosecha por choque climático o caída de precios de mercado. Esta distinción es fundamental para interpretar los datos censales: la baja tasa de postulación (exclusión de entrada) puede ser síntoma de asimetrías de información y aversión al colateral, y no necesariamente de denegación bancaria en ventanilla.

== Dinámica de la Fuerza Laboral: Absorción e Intensidad del Empleo

En la economía agraria, la demanda de mano de obra está intrínsecamente ligada a la estacionalidad biológica de los cultivos y a la disponibilidad de liquidez para financiar los ciclos de siembra, fertilización y cosecha. La teoría clásica del desarrollo rural postula que el acceso a financiamiento permite a las unidades productivas expandir su escala operativa, absorbiendo una mayor densidad de trabajadores por manzana de tierra cultivada.

No obstante, existe una distinción crucial entre dos hipótesis sobre el uso del capital en el campo:
+ *Hipótesis de sustitución tecnológica:* El crédito se destina prioritariamente a la adquisición de maquinaria y agroquímicos intensivos, lo que desplaza la mano de obra humana y reduce la intensidad laboral por unidad de superficie.
+ *Hipótesis de multiplicación y expansión operativa:* El capital financia capital de trabajo circulante (pago de jornales, mantenimiento e insumos), catalizando un aumento en la contratación total de trabajadores.

Asimismo, resulta crítico analizar la calidad contractual de dicho empleo. La literatura especializada distingue entre el empleo permanente (asociado a la estabilidad socioeconómica del hogar rural) y el empleo temporal o estacional, el cual suele perpetuar esquemas de vulnerabilidad e ingresos volátiles si la liquidez solo se inyecta para atender picos de zafra sin generar relaciones laborales estables.

== Intensificación Tecnológica vs. Extensificación Ganadera

La asignación de la tierra entre ganadería extensiva y cultivos agrícolas constituye una decisión clave para la productividad rural. De acuerdo con la teoría de la intensificación agrícola de @boserup1965, los productores transitan desde modelos extensivos de bajo rendimiento hacia sistemas intensivos de alta densidad de capital y trabajo a medida que enfrentan restricciones de recursos o acceden a tecnologías e incentivos de mercado.

En Nicaragua y Centroamérica, la ganadería bovina tradicional ha operado históricamente bajo la «trampa de la extensificación»: el mantenimiento de extensas áreas de pasto natural con muy baja carga animal por manzana, un modelo de mínima inversión de capital pero de baja productividad y alto costo ecológico. La inyección de crédito rural formal funciona teóricamente como el mecanismo habilitador que permite a los productores escapar de dicha trampa, costeando las elevadas inversiones iniciales y los prolongados tiempos de maduración biológica requeridos para la siembra de cultivos permanentes (café, cacao, frutales), logrando así una mayor rentabilidad por unidad de superficie.

== Resiliencia y Diversificación Productiva como Mitigación de Riesgo

La teoría de portafolio aplicada al agro establece que la diversificación horizontal (el policultivo y la coexistencia de rubros agrícolas y pecuarios) reduce la varianza de los ingresos de la unidad productiva ante la volatilidad climática y de precios. Los productores rurales que dependen de un monocultivo enfrentan un riesgo catastrófico en caso de sequía o desplome de precios internacionales. La disponibilidad de liquidez permite financiar la siembra concurrente de rubros de consumo básico (granos de ciclo corto) junto a cultivos comerciales y actividades pecuarias, mejorando la resiliencia económica global de la explotación.

== Marco Conceptual y Definición Operativa de Variables (CENAGRO 2011)

Para garantizar la rigurosidad y comparabilidad de los datos, las variables operativas procesadas en esta investigación se fundamentan estrictamente en el marco semántico oficial del IV Censo Nacional Agropecuario @cenagro2013:

- *Explotación Agropecuaria (EA):* Unidad de análisis fundamental, definida como toda extensión de tierra aprovechada total o parcialmente para la producción agrícola, pecuaria o forestal, bajo una gerencia o administración única, independientemente de su régimen de tenencia o tamaño @cenagro2013[p. 4].
- *Acceso a Financiamiento:* Estado de interacción de la EA con el ecosistema financiero, clasificando a las unidades en financiadas (recibieron crédito en el ciclo agrícola) y no financiadas, y categorizando la fuente en banca privada, banca estatal de fomento (Banco Produzcamos), cooperativas, ONGs, acopiadores y prestamistas informales @cenagro2013[p. 10].
- *Intensidad Laboral:* Absorción de trabajadores totales (permanentes y temporales) normalizada por manzana de superficie explotada (trabajadores/Mz), permitiendo contrastar fincas de diversas escalas en igualdad de condiciones.
- *Ratio de Trabajo Permanente:* Proporción de trabajadores permanentes respecto a la fuerza laboral total de la finca, donde un valor de 0.0 indica mano de obra 100% estacional y un valor de 1.0 refleja estabilidad contractual plena @cenagro2013[p. 9].
- *Índice de Diversificación:* Métrica de conteo de la variedad de rubros productivos activos simultáneamente en la explotación (cultivos anuales, cultivos permanentes, pastos cultivados, pastos naturales y áreas forestales).
- *Ratio Pasto-Cultivo:* Cociente entre la superficie de pasto (natural y cultivado) y el área destinada a cultivos (anuales y permanentes), donde valores inferiores a 1.0 indican intensificación agrícola y valores superiores reflejan orientación pecuaria.
- *Eficiencia de Aprobación de Crédito:* Tasa empírica calculada como el cociente entre el número de créditos recibidos y el total de solicitudes formalizadas.

#pagebreak()

// ==========================================
// CAPÍTULO III: OBJETIVOS
// ==========================================
= Objetivos

== Objetivo General

Evaluar el impacto del financiamiento en la generación de empleo y la diversificación productiva de las explotaciones agropecuarias de Nicaragua a partir de los datos del CENAGRO 2011.

== Objetivos Específicos

+ Comparar la intensidad y estabilidad de la fuerza laboral entre explotaciones financiadas y no financiadas según su estrato de tamaño.
+ Determinar la variación en la asignación del suelo hacia cultivos permanentes y en el índice de diversificación productiva según el acceso a crédito.
+ Analizar la tasa de aprobación y la distribución de las fuentes de financiamiento en las solicitudes de crédito del sector agropecuario.

#pagebreak()

// ==========================================
// CAPÍTULO IV: INTEGRACIÓN CURRICULAR
// ==========================================
= Integración de los Componentes Curriculares

La ejecución de este proyecto de investigación se fundamenta en la articulación interdisciplinaria de seis componentes curriculares correspondientes al plan de estudios de la carrera de Ingeniería en Ciencias de Datos de la UNAN-Managua. La convergencia sinérgica de estas disciplinas permitió transformar un desafío complejo de microdatos censales masivos y heterogéneos en una solución analítica rigurosa, reproducible y de alto rendimiento computacional.

A continuación, se detalla la contribución específica de cada componente curricular, los aprendizajes aplicados y su interacción concreta en el desarrollo del estudio:

== CITG013 - Integrador III

Actuó como el componente metodológico y articulador transversal de la investigación. Aportó los principios para la formulación del problema científico, la delimitación de objetivos, el diseño del marco conceptual y la gestión del ciclo de vida del proyecto. Mediante este componente se coordinaron las etapas de investigación, asegurando la coherencia entre las preguntas teóricas sobre el impacto del crédito y los artefactos computacionales desarrollados. Asimismo, guio la aplicación de estándares éticos y de reproducibilidad científica en la publicación de datos abiertos bajo licencias Creative Commons.

== CPRG011 - Programación I

Proveyó las bases computacionales para el desarrollo de software estructurado y de alto rendimiento. Las competencias de lógica algorítmica, estructuras de control, modularización y tipado estricto se aplicaron directamente en la construcción del pipeline de ingestión y transformación de datos en lenguaje Rust (utilizando el motor Apache DataFusion). La aplicación de estos conceptos garantizó la seguridad en el manejo de memoria (_memory safety_), la inmutabilidad de los flujos de transformación y el procesamiento vectorizado en paralelo de más de 260,000 registros censales, superando las limitaciones de latencia y consumo de memoria RAM de los entornos tradicionales de análisis.

== CEST011 - Estadística I

Constituyó la base analítica para el tratamiento cuantitativo de los datos censales. Se aplicaron técnicas de estadística descriptiva e inferencial no paramétrica para caracterizar variables asimétricas y con distribuciones de ley de potencia (como el tamaño de la tierra y la fuerza laboral). El dominio de medidas de tendencia central robustas (medianas y rangos intercuartílicos), tablas de frecuencias cruzadas, distribuciones relativas normalizadas y técnicas de segmentación demográfica permitió controlar el sesgo de economías de escala (`farm_size_class`), asegurando que las comparaciones de absorción laboral y diversificación entre cohortes financiadas y no financiadas fueran estadísticamente válidas y confiables.

== CBDN020 - Base de Datos Relacionales

Aportó los fundamentos teóricos y prácticos para el modelado, almacenamiento y consulta analítica de datos a gran escala. A partir de los microdatos crudos del censo, se diseñó una arquitectura de bodega de datos (_warehouse_) en DuckDB estructurada bajo principios de modelado dimensional (esquema en estrella). Se aplicaron técnicas de normalización para asegurar la integridad referencial de dimensiones y tablas de hechos (`farm_labor`, `farm_credit_access`, `farm_land_use`), así como consultas SQL analíticas de alta complejidad, incluyendo expresiones de tabla comunes (CTEs), funciones de agregación por ventana y operaciones de desunión matricial (`UNPIVOT`) para la generación de reportes y figuras.

== CMAT183 - Matemática III

Proporcionó el soporte formal para las operaciones algebraicas y matriciales inherentes a la manipulación de vectores multidimensionales en memoria (formato Apache Arrow). Las competencias en álgebra lineal y cálculo multidimensional se aplicaron en la optimización de las funciones matemáticas empleadas para el cálculo de distancias, ratios continuos (Ratio de Trabajo Permanente, Ratio Pasto-Cultivo) y la normalización del Índice de Diversificación Productiva, asegurando que las transformaciones espaciales y de área mantuvieran precisión numérica sin pérdida por redondeo.

== CING020 - Inglés Técnico

Permitió el acceso, asimilación y aplicación autónoma de documentación técnica avanzada y literatura científica internacional disponible exclusivamente en idioma inglés. Esto incluyó la especificación de estándares modernos de datos (Apache Arrow, Apache Parquet), manuales de herramientas de software de vanguardia (DataFusion, DuckDB, Evidence.dev, Typst) y guías de desarrollo de librerías en Rust. Asimismo, facilitó la redacción del ensayo técnico en inglés (_Technical Essay_) integrado en la plataforma analítica, fortaleciendo la divulgación internacional del producto de investigación.

== Matriz de Articulación y Sinergia Interdisciplinaria

La articulación entre los seis componentes no operó como una suma aislada de materias, sino como un engranaje continuo: los requerimientos metodológicos definidos en *Integrador III* demandaron un modelo relacional robusto en *Base de Datos*, cuya volumetría requirió la optimización algorítmica y vectorial de *Programación I* y *Matemática III*, sustentada en documentación especializada en *Inglés Técnico*, para finalmente ser analizada e interpretada cuantitativamente mediante las herramientas de *Estadística I*. Esta sinergia interdisciplinaria constituye la esencia del perfil profesional de la Ingeniería en Ciencias de Datos y valida la pertinencia del producto integrador desarrollado.

#pagebreak()

// ==========================================
// CAPÍTULO V: DISEÑO METODOLÓGICO
// ==========================================
= Diseño Metodológico o Procedimiento de Desarrollo

== Enfoque y Tipo de Investigación

La investigación se desarrolló bajo un enfoque cuantitativo, de diseño no experimental y de corte transversal. El alcance es de carácter descriptivo-analítico y correlacional, orientado a contrastar y evaluar empíricamente las brechas socioeconómicas generadas por el financiamiento en las unidades agrarias durante el ciclo censal. El estudio trata el corpus censal como un artefacto de datos inmutable y cerrado, sobre el cual se ejecutan particiones por cohortes (_A/B testing observacional_) para aislar estadísticamente el impacto del crédito sin manipular el entorno productivo real @cenagro2013[p. 12].

== Población y Unidades de Análisis

La población objetivo y universo de estudio está constituida por la totalidad de las explotaciones agropecuarias de Nicaragua empadronadas durante el IV Censo Nacional Agropecuario (CENAGRO 2011). Dicho universo asciende a 227,541 explotaciones agropecuarias oficiales, las cuales, al desnormalizar las múltiples parcelas, rubros de aprovechamiento y módulos productivos, totalizan 262,546 unidades de registro analítico en el almacén de datos consolidado. La unidad de análisis corresponde a la Explotación Agropecuaria (EA), definida como toda extensión de tierra aprovechada para actividades agrícolas, pecuarias o forestales bajo una administración única @cenagro2013[p. 4].

== Técnicas e Instrumentos de Recolección de Datos

La recolección de los datos de base fue ejecutada por el Instituto Nacional de Información de Desarrollo (INIDE) y el Ministerio Agropecuario y Forestal (MAGFOR) mediante entrevista directa al productor o administrador de la explotación, utilizando la boleta censal oficial estandarizada @cenagro2013. Para la presente investigación, la técnica de levantamiento consistió en la extracción y procesamiento directo de los microdatos crudos provistos institucionalmente en archivos relacionales de formato SPSS (`.sav`), garantizando fidelidad e integridad censal al 100% sin recurrir a muestras ni proyecciones agregadas.

== Procedimientos y Fases de la Investigación

El desarrollo de la investigación y del producto integrador se estructuró en cinco fases metodológicas secuenciales:

+ *Fase 1: Ingesta y conversión estructural:* Lectura automatizada de los microdatos binarios de origen y conversión al estándar columnar abierto Apache Parquet, reduciendo el volumen de almacenamiento de 100 MB a 10 MB y habilitando lecturas rápidas sin sobrecarga de entrada/salida.
+ *Fase 2: Limpieza, tipificación y perfilado:* Depuración de anomalías, imputación determinista de tipos de datos de precisión mínima viable mediante _downcasting_ y codificación de diccionarios (_dictionary encoding_) para variables categóricas, eliminando valores inválidos o registros huérfanos.
+ *Fase 3: Modelado dimensional:* Diseño de un esquema analítico en estrella en DuckDB, vinculando tablas de dimensiones geográficas y estructurales con tablas de hechos operativas (`farm_labor`, `farm_credit_access`, `farm_land_use`).
+ *Fase 4: Agregación analítica y partición por cohortes:* Formulación de consultas SQL analíticas para segmentar el universo censal en cohortes (financiadas vs. no financiadas), controlando por estratos de escala y derivando las métricas de empleo, suelo y diversificación.
+ *Fase 5: Síntesis gráfica y comunicación científica:* Implementación de visualizaciones vectoriales nativas en CeTZ y redacción del informe técnico integrado en Typst.

== Materiales, Recursos y Herramientas Computacionales

El flujo de trabajo analítico se desplegó sobre una estación de trabajo con procesador Intel Core i7-1165G7 y 16 GB de RAM, utilizando el sistema operativo inmutable Fedora Silverblue (Aurora OS). Se utilizó una arquitectura de _Modern Data Stack_ orientada a la eficiencia y seguridad mediante contenedores raíz-cero (_rootless_) en Podman:
- *Lenguaje Rust y Apache DataFusion:* Motor de ejecución vectorizada para las transformaciones analíticas en memoria.
- *DuckDB:* Sistema de gestión de bases de datos analítico OLAP embebido en memoria.
- *Typst y CeTZ:* Entorno moderno de maquetación tipográfica científica y motor de renderizado vectorial de gráficos.
- *Evidence.dev:* Framework de inteligencia de negocios como código para generación de sitios estáticos orientados a datos.
- *Just:* Ejecutor de tareas deterministas para la orquestación reproducible de todas las etapas del pipeline.

== Control de Sesgos, Validación y Reproducibilidad

Debido a que las distribuciones agrarias presentan una extrema asimetría positiva con colas pesadas (distribuciones de ley de potencia), se aplicaron técnicas estadísticas rigurosas para mitigar el sesgo:
- *Control del sesgo de economías de escala:* La muestra fue segmentada en clases de tamaño de explotación (`farm_size_class`), aislando las fincas medianas y grandes (_Medium/Large_) y pequeñas (_Small_) de los minifundios (menores a 1 manzana), comparando exclusivamente medianas entre cohortes dentro del mismo estrato.
- *Uso de estadística no paramétrica:* Se privilegió el uso de medianas y rangos intercuartílicos sobre la media aritmética, evitando distorsiones por valores atípicos extremos.
- *Garantía de reproducibilidad científica:* Todo el código fuente de extracción, transformación y agregación se encuentra versionado y depositado en acceso abierto en GitHub (#link("https://github.com/vect-maker/cenagro-analytics-nicaragua")[https://github.com/vect-maker/cenagro-analytics-nicaragua]), mientras que el dataset procesado y normalizado cuenta con identificador de objeto digital permanente (DOI: `10.5281/zenodo.20652059`) en Zenodo @miranda2026dataset.

#pagebreak()

// ==========================================
// CAPÍTULO VI: DESARROLLO DEL PRODUCTO INTEGRADOR
// ==========================================
= Desarrollo del Producto Integrador

== Arquitectura Tecnológica del Modern Data Stack

El producto integrador desarrollado consiste en una infraestructura analítica desacoplada y reproducible que procesa, modela y divulga los microdatos del CENAGRO 2011. La arquitectura se diseñó bajo el paradigma de _Modern Data Stack_ (MDS), separando estrictamente la capa de almacenamiento columnar inmutable, el motor de transformación vectorizado en memoria y la capa de presentación semántica. Esta separación permitió procesar más de 260,000 registros censales complejos en hardware estándar de consumo, manteniendo tiempos de respuesta inferiores a un segundo sin depender de clústeres distribuidos costosos.

== Pipeline ETL y Procesamiento Vectorizado en Rust

El núcleo de transformación de datos se implementó en el lenguaje de programación de sistemas Rust, utilizando el motor de consulta vectorizado Apache DataFusion y el estándar de memoria Apache Arrow. El pipeline opera en tres fases:
+ *Ingesta columnar estricta:* Conversión directa de los ficheros de microdatos a tablas Parquet, garantizando compresión eficiente por bloques de columnas.
+ *Tipificación segura y optimización de memoria:* Aplicación de _downcasting_ a tipos de datos enteros mínimos viables (e.g., enteros de 8 y 16 bits para códigos de rubros y banderas lógicas) y codificación de diccionarios (_Dictionary Encoding_) para cadenas de texto de baja cardinalidad, maximizando el aprovechamiento de la memoria caché L1/L2 del CPU.
+ *Desnormalización OLAP:* Construcción de una tabla ancha consolidada (_Wide-Table OLAP_) que integra las variables de crédito, superficie cultivada, inventario pecuario y fuerza laboral en un solo esquema desacoplado.

== Almacén de Datos Analítico en DuckDB

Sobre la base de los archivos Parquet optimizados, se implementó un almacén de datos dimensional administrado mediante el motor DuckDB. La bodega analítica estructura vistas y tablas de agregación pre-calculadas que alimentan directamente las figuras del estudio, ejecutando consultas SQL avanzadas con soporte de _zero-copy reads_:
- Modelado de las tablas de hechos: `farm_credit_access`, `farm_labor` y `farm_land_use`.
- Integración de operadores `UNPIVOT` para reorganizar matricialmente las fuentes de crédito y el uso del suelo sin generar duplicidad física de datos.
- Agregaciones deterministas exportadas automáticamente a formatos ligeros para la alimentación de gráficos científicos.

== Plataforma Interactiva de Inteligencia de Negocios y Publicación Abierta

Como componente de interfaz y divulgación del producto integrador, se desarrolló un portal analítico web interactivo mediante el framework _Evidence.dev_, desplegado públicamente en la web (#link("https://cenagro-analytics-ni.netlify.app")[https://cenagro-analytics-ni.netlify.app]). La plataforma permite al público general, investigadores y tomadores de decisiones explorar dinámicamente las distribuciones censales, filtrar por departamento y verificar de forma interactiva los contrastes cuantitativos reportados en esta investigación.

#pagebreak()

// ==========================================
// CAPÍTULO VII: RESULTADOS Y ANÁLISIS
// ==========================================
= Resultados y Análisis

Los resultados derivados del procesamiento cuantitativo del universo censal (CENAGRO 2011) se presentan organizados en correspondencia directa con los tres objetivos específicos planteados en la investigación. Para cada dimensión, se contrasta la evidencia empírica provista por las visualizaciones vectoriales nativas con los datos numéricos y el marco teórico de la economía agraria.

== Eficiencia del Ecosistema Financiero y Fuentes de Crédito

En correspondencia con el tercer objetivo específico, se modeló el embudo de acceso al crédito (_Credit Funnel_) para cuantificar la fricción institucional que experimentan los productores agropecuarios al interactuar con el sistema financiero formal e informal.

#figure(
  chart-embudo(),
  caption: [Embudo de Acceso al Crédito.]
) <fig-embudo>

Como se demuestra en la @fig-embudo, la contracción más aguda del sistema no ocurre en la fase de evaluación bancaria en ventanilla, sino en la entrada misma al circuito de financiamiento: de las 262,546 explotaciones censadas en el país, únicamente 41,756 unidades (15.9%) lograron tramitar una solicitud de financiamiento. En marcado contraste, entre los productores que consiguen formalizar su solicitud, la tasa empírica de aprobación asciende a un elevado 92.6% (38,680 créditos concedidos), frente a un rechazo de apenas el 7.4%.

Este contraste empírico desmiente la hipótesis tradicional de que la restricción crediticia obedece a una denegación masiva de solicitudes en ventanilla. Por el contrario, corrobora la formulación teórica de @boucher2008 sobre el racionamiento por riesgo y la autoexclusión: la principal falla de mercado reside en una barrera estructural de base (carencia de garantías hipotecarias, asimetrías de información, lejanía geográfica o aversión al riesgo de pérdida patrimonial) que margina al 84.1% de los productores antes de formular una solicitud.

Paralelamente, se analizó la matriz de orígenes de financiamiento para caracterizar la composición institucional de los proveedores de capital en el agro.

#figure(
  chart-fuentes(),
  caption: [Principales Fuentes de Financiamiento.]
) <fig-fuentes>

De acuerdo con los datos reflejados en la @fig-fuentes, la banca comercial privada es el proveedor líder absoluto con 18,255 créditos otorgados, duplicando casi el alcance de las estructuras asociativas (cooperativas con 9,793 créditos) y superando con amplitud a las ONGs (2,662 créditos). Por su parte, las vías informales (1,801 prestamistas y 1,618 acopiadores) y la banca estatal de fomento (Banco Produzcamos con 586 créditos) presentan participaciones minoritarias en el volumen censal.

Estos datos demuestran que, para la minoría de explotaciones que logran superar las barreras de entrada, el apalancamiento depende predominantemente de la banca tradicional y sus exigencias colaterales clásicas @stiglitz1981, limitando el alcance democratizador de las instituciones financieras solidarias o estatales durante el ciclo estudiado.

#pagebreak()

== Dinámica de la Fuerza Laboral: Densidad y Estabilidad Contractual

Para dar respuesta al primer objetivo específico, se evaluó la Intensidad Laboral (absorción de trabajadores totales por manzana de superficie). Con el propósito de aislar el sesgo de economías de escala y evitar que los minifundios distorsionaran la comparación, la muestra se segmentó rigurosamente por clases de tamaño (`farm_size_class`), omitiendo el estrato micro (menor a una manzana) en este indicador.

#figure(
  chart-intensidad(),
  caption: [Intensidad Laboral Mediana por Escala y Acceso a Crédito.]
) <fig-intensidad>

Como se observa en la @fig-intensidad, los resultados confirman que el financiamiento actúa como un multiplicador expansivo de la absorción laboral, desestimando la hipótesis de sustitución tecnológica de mano de obra por maquinaria. Las explotaciones medianas y grandes (_Medium/Large_) que recibieron crédito registraron un incremento masivo en su capacidad de absorción, superando en un 171.6% la mediana de intensidad laboral de las fincas homólogas sin crédito (0.326 vs. 0.120 trabajadores/Mz). Asimismo, en las unidades pequeñas (_Small_), la inyección de liquidez generó una brecha positiva del 33.3% (1.667 vs. 1.250 trabajadores/Mz).

Más allá del volumen absoluto de contratación, se examinó la calidad del empleo a través del Ratio de Trabajo Permanente, midiendo si la liquidez facilita la transición de un esquema estacional (ratio 0.0) hacia relaciones laborales estables (ratio 1.0).

#figure(
  chart-estabilidad(),
  caption: [Distribución de la Estabilidad Laboral (Proporción Relativa).]
) <fig-estabilidad>

La @fig-estabilidad confirma una estructura bimodal y altamente polarizada en el mercado laboral rural nicaragüense. El 72.5% de las explotaciones financiadas operan exclusivamente con trabajadores temporales (ratio 0.0), cifra superior al 68.3% reportado por el grupo no financiado. En contraposición, las planillas compuestas en un 100% por personal permanente presentan una mayor prevalencia relativa en fincas no financiadas (12.0% frente a 5.88%).

Esta evidencia demuestra que, si bien el apalancamiento expande de manera notable la escala de contratación agregada, el capital crediticio se canaliza preponderantemente a solventar necesidades de capital de trabajo para picos estacionales de siembra y cosecha, perpetuando la dependencia estructural hacia la mano de obra transitoria sin inducir formalización contractual permanente.

== Complejidad Productiva y Transición hacia la Intensificación Agrícola

En correspondencia con el segundo objetivo específico, se contrastó el Índice de Diversificación (conteo de rubros operativos simultáneos) y la composición del uso del suelo para verificar si el capital inyectado permite mitigar el riesgo de monocultivo y superar la extensificación pecuaria.

#figure(
  chart-complejidad(),
  caption: [Densidad de Complejidad Productiva (Distribución Normalizada).]
) <fig-complejidad>

Al evaluar la distribución en la @fig-complejidad, se evidencia un desplazamiento estadístico hacia niveles superiores de diversificación en el grupo financiado. Mientras que las unidades no financiadas concentran su pico modal en apenas 2 rubros (25.1% de las fincas), la cohorte capitalizada traslada su moda hacia los 3 rubros (23.7%) y sostiene una mayor presencia en estratos de alta complejidad (4 a 6 rubros). En términos absolutos, las fincas con crédito incorporan en promedio 0.29 rubros adicionales (media de 3.65 frente a 3.36 rubros), confirmando que el financiamiento mitiga las barreras de entrada para la diversificación de cultivos.

Complementariamente, se examinó la transición en la vocación del uso de la tierra a través de la superficie asignada a Cultivos Permanentes frente a Pasto Natural y el Ratio Pasto-Cultivo.

#figure(
  chart-vocacion(),
  caption: [Proporción del Área Destinada a Cultivos vs. Pasturas Naturales.]
) <fig-pasto>

La @fig-pasto ilustra una reconfiguración estructural en la vocación económica del suelo inducida por el financiamiento. Las fincas financiadas destinan en promedio un 22.9% de su área total a Cultivos Permanentes, superando notablemente el 13.6% registrado en las no financiadas (+9.3 puntos porcentuales). Paralelamente, la superficie asignada a Pasto Natural desciende del 19.1% al 16.8%. En consecuencia, el Ratio Pasto-Cultivo promedio desciende marcadamente de 4.18 a 2.71 (un delta absoluto de -1.47).

Este comportamiento valida empíricamente la teoría de intensificación de @boserup1965: el acceso a capital permite a los productores escapar de la «trampa de la extensificación» ganadera tradicional (potreros extensivos de bajo rendimiento), invirtiendo en rubros perennes de ciclo largo (café, cacao, frutales) que demandan una alta inversión inicial y maduración biológica, pero garantizan mayor rentabilidad por manzana y resiliencia en el largo plazo.

#pagebreak()

// ==========================================
// CAPÍTULO VIII: CONCLUSIONES
// ==========================================
= Conclusiones

El procesamiento determinista y el análisis empírico de los microdatos del IV Censo Nacional Agropecuario (CENAGRO 2011) mediante una arquitectura de _Modern Data Stack_ permiten establecer las siguientes conclusiones estructurales en correspondencia directa con los objetivos planteados:

+ *Expansión laboral estacional y refutación de la sustitución tecnológica:* Se comprobó empíricamente que el financiamiento actúa como un potente catalizador de escala operativa y absorción de mano de obra en el campo, desestimando la hipótesis de sustitución tecnológica por mecanización. Las unidades medianas y grandes financiadas registraron un incremento masivo del 171.6% en su mediana de intensidad laboral (0.326 vs. 0.120 trabajadores/Mz), y las unidades pequeñas un aumento del 33.3% (1.667 vs. 1.250 trabajadores/Mz). Sin embargo, se evidenció una paradoja en la calidad contractual: el capital inyectado se destina predominantemente a financiar picos de demanda estacional (siembra y cosecha), perpetuando la dependencia del trabajo transitorio (72.5% de unidades financiadas operan con ratio permanente 0.0) en lugar de consolidar planillas fijas.
+ *Ruptura de la trampa de extensificación y diversificación productiva:* Se verificó que el apalancamiento financiero promueve una reconfiguración favorable en la vocación del uso del suelo, validando los postulados de intensificación agrícola de Boserup. Las explotaciones con crédito aumentaron significativamente su proporción de cultivos permanentes del 13.6% al 22.9% (+9.3 puntos porcentuales) y redujeron la superficie en pastos naturales del 19.1% al 16.8%, contrayendo el Ratio Pasto-Cultivo promedio de 4.18 a 2.71. Asimismo, el crédito facilitó la superación de barreras de entrada hacia nuevos rubros, desplazando el pico modal del Índice de Diversificación de 2 a 3 actividades productivas y mejorando la resiliencia económica frente al monocultivo.
+ *Falla de mercado por exclusión estructural de entrada, no por rechazo bancario:* El análisis del embudo de financiamiento demostró que el cuello de botella crítico del ecosistema rural no radica en una denegación generalizada de solicitudes en ventanilla bancaria (donde la tasa empírica de aprobación alcanza un elevado 92.6%), sino en una severa exclusión de base. El 84.1% de los productores censados ni siquiera formalizó una solicitud de préstamo formal, condicionados por la carencia de garantías hipotecarias, aislamiento geográfico y la autoexclusión por aversión al riesgo de pérdida patrimonial ante choques productivos.
+ *Aporte y pertinencia del producto integrador en Ciencia de Datos:* Se demostró la viabilidad técnica y el valor metodológico de integrar herramientas modernas de código abierto (Rust, Apache DataFusion, DuckDB, Parquet y Evidence.dev) para procesar censos masivos en hardware de consumo estándar. La articulación interdisciplinaria del plan de estudios permitió construir una infraestructura analítica reproducible, inmutable y auditada, capaz de transformar microdatos censales brutos en evidencia empírica rigurosa para el diseño de políticas públicas.

#pagebreak()

// ==========================================
// CAPÍTULO IX: RECOMENDACIONES O PROYECCIONES
// ==========================================
= Recomendaciones o Proyecciones

A partir de los hallazgos cuantitativos y de la experiencia en el desarrollo del producto integrador, se formulan las siguientes recomendaciones y proyecciones:

== Recomendaciones de Política Pública y Fomento Financiero

+ *Diseño de esquemas de garantías no colaterales:* Dado que la falla principal radica en la exclusión de entrada y no en el rechazo en ventanilla, se recomienda fortalecer los fondos de garantía recíproca y promover figuras de aval solidario o garantías reputacionales mediante el Banco Produzcamos y el movimiento cooperativo, reduciendo la dependencia excluyente del título hipotecario formal.
+ *Incentivos al crédito orientados a la formalización laboral:* Formular líneas crediticias preferenciales o bonificaciones de tasa de interés para aquellas unidades productivas que utilicen el apalancamiento no solo para financiar zafras temporales, sino para formalizar contratos laborales continuos y estables durante todo el ciclo anual.
+ *Crédito verde y asistencia técnica para intensificación perenne:* Canalizar recursos financieros condicionados a planes de reconversión de pasturas naturales degradadas hacia sistemas agroforestales y cultivos perennes de alto valor biológico (café, cacao, frutales), impulsando la productividad por manzana y mitigando la presión de frontera agrícola.

== Modernización de la Gestión Pública Basada en Datos

+ *Adopción de arquitecturas analíticas desacopladas en el sector público:* Promover en instituciones rectoras (INIDE, MAG, MEFCCA) la implementación de estándares de datos abiertos (Parquet/Arrow) y bases analíticas embebidas (DuckDB), permitiendo a analistas y funcionarios auditar microdatos masivos con costos de infraestructura computacional mínimos.
+ *Portal de inteligencia territorial para la toma de decisiones:* Utilizar plataformas analíticas basadas en código (similares al portal desarrollado en Evidence.dev) para visibilizar transparentemente las brechas departamentales de crédito y empleo, facilitando la focalización territorial de subsidios y programas sociales.

== Proyecciones de Continuidad Investigativa

+ *Modelado predictivo de riesgo crediticio con variables productivas:* Extender este producto integrador mediante algoritmos de aprendizaje automático (_Machine Learning_) que evalúen el perfil crediticio del productor incorporando su diversificación productiva y aptitud agroecológica como factores atenuantes de riesgo.
+ *Análisis dinámico longitudinal con censos agropecuarios futuros:* Desarrollar metodologías de emparejamiento por panel sintético cuando se publiquen nuevos levantamientos censales, permitiendo evaluar el impacto causal de mediano y largo plazo del crédito sobre la productividad total de los factores.

#pagebreak()

// ==========================================
// REFERENCIAS
// ==========================================
= Referencias

#bibliography("references.bib", style: "apa", title: none)

#pagebreak()

// ==========================================
// ANEXOS
// ==========================================
= Anexos

== Anexo A: Diccionario de Variables Analíticas Clave (CENAGRO 2011)

A continuación, se describen las principales variables operativas del CENAGRO 2011 procesadas y transformadas en la bodega de datos analítica:

#align(center)[
  #text(size: 9.5pt)[
    #table(
      columns: (2.3fr, 0.9fr, 1.4fr, 2.7fr),
      fill: (col, row) => if row == 0 { rgb("e2e8f0") } else { none },
      align: (col, row) => if col == 1 { center } else { left },
      stroke: 0.5pt + luma(120),
      [Nombre de Variable], [Tipo], [Tabla de Origen], [Descripción Operativa],
      [`farm_uid`], [`INT64`], [`farms`], [Identificador único de la Explotación Agropecuaria (EA).],
      [`received_loan`], [`BOOLEAN`], [`farm_credit_access`], [Indica si la EA recibió financiamiento en el ciclo censal.],
      [`requested_loan`], [`BOOLEAN`], [`farm_credit_access`], [Indica si la EA gestionó una solicitud formal de crédito.],
      [`farm_size_class`], [`VARCHAR`], [`farms`], [Estrato de tamaño censal: Micro (< 1 Mz), Small (1 a 10 Mz), Medium/Large (> 10 Mz).],
      [`total_area_mz`], [`FLOAT64`], [`farms`], [Superficie total de la EA en manzanas censales.],
      [`labor_intensity`], [`FLOAT64`], [`farm_labor`], [Total de trabajadores absorbidos dividido entre la superficie total (trabajadores/Mz).],
      [`permanent_labor_ratio`], [`FLOAT64`], [`farm_labor`], [Proporción de trabajadores permanentes respecto a la mano de obra total (0.0 a 1.0).],
      [`diversification_index`], [`INT32`], [`farms`], [Conteo de actividades productivas simultáneas presentes en la finca (1 a 8 rubros).],
      [`pasture_to_crop_ratio`], [`FLOAT64`], [`farms`], [Superficie de pastos dividida entre superficie de cultivos activos.]
    )
  ]
]

#pagebreak()

== Anexo B: Diagrama de Arquitectura del Producto Integrador

El siguiente esquema describe el flujo de ingeniería de datos y la arquitectura desacoplada de _Modern Data Stack_ implementada en el proyecto:

#align(center)[
  #block(
    width: 95%,
    stroke: 0.5pt + luma(140),
    radius: 4pt,
    inset: 1.2em,
    fill: rgb("f8fafc")
  )[
    #text(weight: "bold", size: 11pt)[Flujo de Datos e Infraestructura Computacional:] \
    #v(0.6em)
    *1. Microdatos Binarios Crudos* (`CENAGRO 2011 .sav`) \
    #text(size: 9pt)[Archivos relacionales originales provistos por INIDE y MAGFOR (~100 MB)] \
    $arrow.b$ \
    *2. Pipeline ETL Vectorizado en Rust* (`Apache DataFusion` + `Apache Arrow`) \
    #text(size: 9pt)[Downcasting de tipos, Dictionary Encoding, saneamiento de nulos y conversión columnar Parquet (~10 MB)] \
    $arrow.b$ \
    *3. Bodega de Datos Analítica OLAP* (`DuckDB In-Process Engine`) \
    #text(size: 9pt)[Tablas de hechos normalizadas (`farm_labor`, `farm_credit_access`, `farm_land_use`) y consultas SQL con UNPIVOT] \
    $arrow.b$ \
    *4. Capas de Divulgación y Síntesis Científica:* \
    - *Portal Web Interactivo:* Framework `Evidence.dev` desplegado en Netlify \
    - *Informe Científico:* Tipografía vectorial y gráficos dinámicos con `Typst` y `CeTZ` \
    - *Repositorio de Datos Abiertos:* Dataset Parquet inmutable con DOI en `Zenodo`
  ]
]

== Anexo C: Evidencias y Recursos de Acceso Abierto

Para garantizar la auditoría, transparencia y reproducibilidad completa del estudio, los recursos se encuentran disponibles públicamente en las siguientes plataformas:

- *Repositorio de Código Fuente (GitHub):* Contiene los scripts de ingesta en Rust, consultas en DuckDB, código de Evidence y la maquetación en Typst: \
  #link("https://github.com/vect-maker/cenagro-analytics-nicaragua")[https://github.com/vect-maker/cenagro-analytics-nicaragua]
- *Plataforma Analítica Interactiva (Netlify):* Portal web para consulta pública con visualizaciones interactivas de las distribuciones censales: \
  #link("https://cenagro-analytics-ni.netlify.app")[https://cenagro-analytics-ni.netlify.app]
- *Conjunto de Datos Procesado (Zenodo):* Base de microdatos censales depurada en formato Parquet, con DOI permanente y licencia Creative Commons Atribución 4.0 Internacional (CC-BY 4.0): \
  #link("https://doi.org/10.5281/zenodo.20652059")[https://doi.org/10.5281/zenodo.20652059] (Miranda Pérez, 2026).

