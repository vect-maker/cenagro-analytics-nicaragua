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
  leading: 0.8em,
  spacing: 1.4em
)

#set figure(gap: 1em)
#set figure.caption(separator: [. ])

#show heading.where(level: 1): it => block(
  width: 100%,
  above: 2.0em,
  below: 1.2em,
  align(center, text(weight: "bold", size: 16pt)[#it.body])
)

#show heading.where(level: 2): it => block(
  above: 1.5em,
  below: 0.8em,
  text(weight: "bold", size: 13pt)[#it.body]
)

#show heading.where(level: 3): it => block(
  above: 1.2em,
  below: 0.6em,
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
#outline(
  title: [Índice],
  depth: 3,
  indent: 1.5em,
)

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
== Arquitectura del Sistema y Entorno de Ejecución

Para procesar el volumen masivo de datos mitigando las limitaciones de hardware (equipo de cómputo con procesador Intel Core i7-1165G7 y 16 GB de RAM), se implementó una arquitectura de Modern Data Stack orientada a la alta eficiencia computacional y la reproducibilidad determinista. El entorno host se desplegó sobre el sistema operativo inmutable Aurora Fedora, utilizando el motor Podman para la orquestación de la infraestructura. La elección de contenedores en modo daemonless y rootless garantizó un ambiente de compilación estéril, predecible y alineado con los estándares de seguridad industrial.

== Pipeline ETL y Procesamiento Vectorizado

El flujo de ingeniería de datos se diseñó para separar la extracción de entrada/salida (I/O) de la computación intensiva en memoria (CPU), ejecutándose en tres fases secuenciales:

Extracción e Ingesta Cruda: Mediante un script aislado, se procedió a la lectura de los archivos binarios originales (SPSS) y su volcado directo a formato columnar Parquet. Esta conversión estructural redujo el peso de almacenamiento de las bases de aproximadamente 100 MB a 10 MB, optimizando las fases posteriores.

Transformación y Tipificación Estricta: El núcleo del procesamiento se ejecutó a través del motor Apache DataFusion, desarrollado en lenguaje Rust. El esquema de datos fue sometido a un proceso agresivo de downcasting, reduciendo los valores por defecto a los tipos enteros mínimos viables. Las variables categóricas de baja cardinalidad se optimizaron mediante codificación de diccionarios (Dictionary Encoding) sobre el formato Apache Arrow, maximizando la velocidad de escaneo en las memorias caché L1/L2 del procesador. Finalmente, se ejecutó una desnormalización completa del modelo relacional, consolidando una única tabla de hechos analítica (Wide-Table OLAP) para eliminar las uniones (joins) costosas en tiempo de ejecución.

Capa Semántica y Modelado Analítico: Se empleó DuckDB como motor analítico in-process, ejecutando lecturas de copia cero (zero-copy reads) directamente sobre los archivos Parquet. Para la materialización de los resultados, se utilizó el framework Evidence.dev. Las funciones de agregación y el cálculo de métricas se ejecutaron en tiempo de compilación (Build-Time), previniendo el colapso de memoria del cliente y asegurando la estabilidad en el análisis de los 226,000 registros. Con el propósito de garantizar la reproducibilidad y el escrutinio científico independiente, el conjunto de datos procesado y desnormalizado resultante de este flujo se encuentra depositado en acceso abierto bajo licencia CC-BY 4.0 en el repositorio Zenodo @miranda2026dataset.

== Métricas, Control de Sesgos y Análisis Comparativo

Para la ejecución del A/B Testing transversal, el universo de explotaciones se dividió en dos cohortes definitivas (Financiadas vs. No Financiadas), utilizando la variable booleana de recepción de crédito como clave de partición principal.

Debido a que los datos de superficie y producción agraria en Nicaragua presentan distribuciones de potencia con una asimetría extrema, se aplicaron técnicas de normalización para estabilizar la varianza. La métrica de Intensidad Laboral (trabajadores por manzana) fue sometida a una transformación logarítmica de base 10 (Log10). Asimismo, para aislar el efecto de las economías de escala y evitar que los micro-fundistas hiper-intensivos distorsionaran el análisis comparativo, las cohortes se segmentaron rigurosamente por clases de tamaño (Micro, Pequeña y Mediana/Grande). Las brechas relativas de absorción laboral, la transición de la vocación económica y los deltas del Índice de Diversificación se calcularon comparando exclusivamente las medianas dentro de segmentos demográficos idénticos.

== Publicación de informe completo

Para garantizar la total reproducibilidad, auditoría y transparencia metodológica del estudio, la arquitectura completa del código fuente —incluyendo el pipeline de extracción en Rust/DataFusion, las consultas analíticas en DuckDB y las transformaciones vectorizadas— ha sido liberada en un repositorio público (#link("https://github.com/vect-maker/cenagro-analytics-nicaragua")[https://github.com/vect-maker/cenagro-analytics-nicaragua]). Asimismo, el panel analítico interactivo y las métricas pre-calculadas mediante el framework Evidence.dev se encuentran desplegados para consulta pública en: #link("https://cenagro-analytics-ni.netlify.app/")[https://cenagro-analytics-ni.netlify.app/]

// ==========================================
// RESULTADOS Y DISCUSIÓN
// ==========================================
= Resultados y discusión

El análisis transversal segmentó el universo censal en dos cohortes definitivas (explotaciones financiadas y no financiadas), utilizando la variable de recepción de crédito como clave de partición principal. Esto permitió aislar estadísticamente el impacto socioeconómico de la inyección de capital, evaluando en primera instancia las barreras de acceso al ecosistema financiero, para luego contrastar las brechas relativas en la generación de empleo y la diversificación productiva.

== Eficiencia del Ecosistema y Barreras de Entrada

La eficiencia de aprobación de crédito constituye el primer filtro estructural para el desarrollo agropecuario, operando como un indicador directo de la fricción institucional. Al modelar el embudo de acceso al crédito (Credit Funnel), se contrasta el volumen masivo de solicitudes emitidas por los productores frente a los capitales que fueron efectivamente desembolsados. Esta métrica visibiliza las barreras formales que enfrenta el sector rural al intentar capitalizar sus operaciones.

#figure(
  chart-embudo(),
  caption: [Embudo de Acceso al Crédito.]
) <fig-embudo>

Como se demuestra en la @fig-embudo, la contracción más aguda no ocurre en la fase de evaluación bancaria, sino en la entrada misma al sistema crediticio: de las 262,546 explotaciones censadas en el país, únicamente 41,756 unidades (15.9%) lograron tramitar una solicitud de financiamiento. En contraste, entre los productores que consiguen formalizar su solicitud, la tasa empírica de aprobación asciende a un elevado 92.6% (38,680 créditos concedidos), frente a un rechazo de apenas el 7.4%. Este contraste demuestra empíricamente que la principal falla de mercado no reside en una denegación masiva de créditos en ventanilla, sino en una exclusión estructural de base (carencia de garantías hipotecarias, aislamiento geográfico o autoexclusión por informalidad) que impide al 84.1% de los productores tan siquiera postularse al sistema formal.

Paralelamente, el análisis de la matriz de orígenes de financiamiento confirma la estructura del mercado financiero en el sector agrario.

#figure(
  chart-fuentes(),
  caption: [Principales Fuentes de Financiamiento.]
) <fig-fuentes>

De acuerdo con los datos reflejados en la @fig-fuentes, contrario a la asunción de que el agro nicaragüense se sostiene primariamente por vías informales o solidarias, la banca comercial privada (18,255 créditos) es el proveedor líder absoluto, duplicando casi el alcance de las estructuras asociativas (Cooperativas con 9,793) y superando ampliamente a las ONGs (2,662). Las fuentes informales (1,801 prestamistas y 1,618 acopiadores) y la banca estatal de fomento (Banco Produzcamos con 586) representan participaciones minoritarias en el volumen global. Este comportamiento demuestra que, para la minoría de explotaciones que logran insertarse en el circuito de crédito, el apalancamiento depende primariamente del ecosistema bancario tradicional y sus exigencias colaterales.

En síntesis, los datos prueban que la privación de servicios financieros formales actúa como una barrera de entrada que margina a la mayoría del universo censal. El ecosistema financiero, lejos de funcionar como un habilitador fluido, limita el crecimiento macroeconómico del sector y confina a una gran proporción de las explotaciones a operar bajo modelos de subsistencia y vulnerabilidad de capital.

#pagebreak()

== Dinámica de la Fuerza Laboral: Densidad y Calidad del Empleo

Para cuantificar el impacto real de la inyección de capital en la generación de empleo agropecuario, se evaluó la Intensidad Laboral (absorción de trabajadores por manzana). Con el fin de aislar el sesgo generado por las economías de escala y evitar que el comportamiento de los minifundios distorsionara el análisis comparativo, la muestra se segmentó rigurosamente por clase de tamaño (`farm_size_class`). El sector micro no es tomado en cuenta para la métrica de intensidad laboral, agrupando en esa categoria las explotaciones agronomas que poseen menos de una manzana.

#figure(
  chart-intensidad(),
  caption: [Intensidad Laboral Mediana por Escala y Acceso a Crédito.]
) <fig-intensidad>

Como se observa en la @fig-intensidad, los datos demuestran empíricamente que el financiamiento actúa como un catalizador expansivo para la contratación, desestimando la hipótesis de que el capital se destina primariamente a la sustitución tecnológica del trabajador. Las fincas clasificadas como medianas y grandes (Medium/Large) que recibieron crédito registraron un incremento masivo en su capacidad de absorción, superando en un 171.6% la mediana de intensidad laboral de las unidades equivalentes sin acceso a financiamiento. Asimismo, en el segmento de pequeñas explotaciones (Small), la brecha relativa se situó en un incremento del 33.3%.

Más allá del volumen absoluto de contrataciones, resulta crítico evaluar la calidad y estabilidad del empleo generado. Se procedió a analizar el Ratio de Trabajo Permanente para determinar si la disponibilidad de liquidez permite a las explotaciones transitar desde un modelo dependiente de mano de obra puramente estacional (ratio 0.0) hacia estructuras de contratación continuas y estables (ratio 1.0).

#figure(
  chart-estabilidad(),
  caption: [Distribución de la Estabilidad Laboral (Proporción Relativa).]
) <fig-estabilidad>

La @fig-estabilidad confirma la naturaleza estructuralmente bimodal y polarizada del mercado laboral rural nicaragüense. El análisis de la distribución revela que el 72.5% de las unidades financiadas operan exclusivamente con trabajadores temporales, una proporción ligeramente superior al 68.3% observado en el grupo no financiado. Inversamente, la consolidación de planillas compuestas en un 100% por personal permanente presenta una mayor prevalencia relativa en fincas sin crédito (12.0% frente a 5.8%).

Estos resultados indican que el apalancamiento financiero funciona como un multiplicador extraordinario del volumen absoluto de empleo, pero dicho capital es inyectado predominantemente para satisfacer picos de demanda estacional (procesos intensivos de siembra, mantenimiento o cosecha). En consecuencia, si bien el crédito formaliza y expande drásticamente las operaciones agrícolas, la estructura de contratación subyacente mantiene una dependencia histórica hacia la fuerza laboral transitoria.

== Complejidad Productiva y Transición hacia la Intensificación Agrícola

La resiliencia económica de una unidad productiva frente a la volatilidad climática y de mercado está estrechamente vinculada a su nivel de diversificación. Para evaluar si la inyección de capital promueve la adopción del policultivo como mecanismo de mitigación de riesgo, se contrastó el Índice de Diversificación (conteo de rubros operativos) entre las cohortes analizadas.

#figure(
  chart-complejidad(),
  caption: [Densidad de Complejidad Productiva (Distribución Normalizada).]
) <fig-complejidad>

Al contrastar la distribución en la @fig-complejidad, se evidencia un claro desplazamiento estadístico hacia una mayor diversificación en el grupo capitalizado. Mientras que las explotaciones no financiadas concentran su pico modal en apenas 2 rubros (25.1% de las fincas), la cohorte financiada traslada su moda hacia los 3 rubros (23.7%) y sostiene una mayor presencia relativa en niveles superiores de complejidad (4 a 6 rubros). Los cálculos de los deltas absolutos confirman que las unidades con acceso a crédito incorporan en promedio 0.29 rubros adicionales (media de 3.65 frente a 3.36 rubros). Este comportamiento demuestra empíricamente que el apalancamiento financiero reduce el riesgo y supera las barreras de entrada para nuevos cultivos, rompiendo la dependencia hacia el monocultivo o la especialización pecuaria pura.

De forma complementaria, el análisis evaluó si el acceso a crédito fomenta una transición desde la ganadería extensiva (modelo de bajo rendimiento dominante a nivel nacional) hacia la intensificación agrícola. Para ello, se contrastó la composición del uso del suelo y el Ratio Pasto-Cultivo. Una ratio menor a 1.0 indica un dominio de la superficie agrícola, mientras que un valor superior refleja una vocación de intensificación ganadera.

#figure(
  chart-vocacion(),
  caption: [Proporción del Área Destinada a Cultivos vs. Pasturas Naturales.]
) <fig-pasto>

La @fig-pasto ilustra una alteración estructural en la vocación económica del suelo impulsada por el financiamiento. Las explotaciones con acceso a crédito destinan en promedio un 22.9% de su área total a Cultivos Permanentes, superando de forma sustancial el 13.6% observado en las unidades no financiadas. En contrapartida, la superficie asignada a Pasto Natural disminuye del 19.1% en las no financiadas al 16.8% en las financiadas. En consecuencia, el Ratio Pasto-Cultivo medio desciende marcadamente de 4.18 a 2.71 (un delta de -1.47), confirmando una transición efectiva hacia un modelo de intensificación agrícola.

Esta reducción relativa de pasturas y el incremento en cultivos permanentes corrobora que el financiamiento permite a los productores escapar de la "trampa de la extensificación" ganadera tradicional. Al dotar a la unidad agrícola de recursos suficientes, el capital inhibe la expansión pasiva mediante potreros extensivos y, en su lugar, canaliza la inversión hacia la intensificación tecnológica y la siembra de rubros perennes de ciclo largo (como café, cacao o frutales), los cuales exigen una alta inversión inicial y tiempo de maduración biológica, pero garantizan una mayor rentabilidad y estabilidad por manzana en el largo plazo.

#pagebreak()

// ==========================================
// CONCLUSIONES Y/O RECOMENDACIONES
// ==========================================
= Conclusiones y/o recomendaciones

El procesamiento determinista y el análisis empírico de los microdatos del CENAGRO 2011 mediante una arquitectura de Modern Data Stack permiten establecer las siguientes conclusiones estructurales sobre el impacto del financiamiento agropecuario en Nicaragua:

- *Expansión laboral estacional (Refutación de formalización):* Se demuestra estadísticamente que el financiamiento actúa como un multiplicador masivo de escala operativa. Las explotaciones capitalizadas absorben una densidad laboral exponencialmente mayor, registrando un incremento relativo del 171.6% por manzana en unidades medianas y grandes. Sin embargo, la liquidez no genera formalidad contractual; el capital es inyectado predominantemente para financiar picos de temporalidad, perpetuando un modelo agrario dependiente de la mano de obra estacional en lugar de consolidar planillas permanentes.
- *Resiliencia productiva e intensificación:* La inyección de capital rompe la trampa de la especialización de bajo valor. Se comprueba que el crédito mitiga el riesgo de entrada a nuevos mercados, incrementando el Índice de Diversificación. Este apalancamiento promueve el abandono sistemático de la ganadería extensiva tradicional a favor de modelos dinámicos de policultivo e intensificación agrícola.
- *Fricción institucional por exclusión, no por rechazo:* A pesar del impacto socioeconómico expansivo en las unidades capitalizadas, la falla sistémica del ecosistema financiero no radica en el rechazo crediticio, dado que la Tasa de Aprobación empírica es excepcionalmente alta (\~92.6%). El verdadero cuello de botella es la profunda exclusión estructural (penetración del \~15.9%), revelando que la inmensa mayoría de los productores operan bajo condiciones de subsistencia o informalidad que les impiden siquiera ingresar al sistema para solicitar un crédito.

#align(right)[*Recomendaciones estratégicas:*]

- *Democratización del crédito:* Se recomienda formular políticas públicas orientadas a reducir las barreras de entrada del sistema bancario formal, estableciendo al financiamiento como un catalizador indispensable para la reducción de la pobreza multidimensional, la fijación de la fuerza laboral rural y la modernización de la matriz productiva.
- *Optimización basada en datos:* Se sugiere la integración gubernamental de infraestructuras de datos desacopladas y procesamiento analítico de alto rendimiento para mejorar la trazabilidad, focalización y eficiencia en la distribución de los servicios financieros del Estado.

== Disponibilidad de datos y código

Para garantizar la reproducibilidad y el escrutinio científico independiente, los recursos computacionales desarrollados para esta investigación se encuentran disponibles públicamente:
- *Código fuente y pipeline ETL:* Repositorio en GitHub (#link("https://github.com/vect-maker/cenagro-analytics-nicaragua")[https://github.com/vect-maker/cenagro-analytics-nicaragua]), implementado por J. D. Miranda Pérez con Apache DataFusion, DuckDB y Evidence.dev.
- *Portal interactivo:* Panel analítico web para consulta pública (#link("https://cenagro-analytics-ni.netlify.app")[https://cenagro-analytics-ni.netlify.app]).
- *Dataset procesado:* Base consolidada en formato Parquet depositada en Zenodo bajo licencia CC-BY 4.0 @miranda2026dataset.

#pagebreak()

// ==========================================
// REFERENCIAS BIBLIOGRÁFICAS
// ==========================================
= Referencias bibliográficas

#bibliography("references.bib", style: "apa", title: none)
