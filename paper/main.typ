#set document(
  title: "Impacto del Financiamiento en la Generación de Empleo y Diversificación Productiva de las Explotaciones Agropecuarias de Nicaragua (CENAGRO 2011)",
  author: (
    "Kendall Ezequiel Aguilar Rodríguez",
    "José Daniel Miranda Pérez",
    "Ricardo Alberto Oyarzo Morales",
    "Luis David Medrano Dávila"
  ),
  date: datetime(year: 2025, month: 6, day: 6)
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
  size: 11pt,
  lang: "es"
)

#show link: it => text(fill: rgb("1b58a6"), underline(it))

#set par(
  justify: true,
  leading: 0.65em,
  spacing: 1.2em
)

#set figure(gap: 1em)
#set figure.caption(separator: [. ])

#show heading.where(level: 1): it => block(
  width: 100%,
  above: 2.0em,
  below: 1.2em,
  align(center, text(weight: "bold", size: 18pt)[#it.body])
)

#show heading.where(level: 2): it => block(
  above: 1.5em,
  below: 0.8em,
  text(weight: "bold", size: 14pt)[#it.body]
)

#show heading.where(level: 3): it => block(
  above: 1.2em,
  below: 0.6em,
  text(weight: "bold", size: 11pt)[#it.body]
)

// ==========================================
// PORTADA / COVER PAGE
// ==========================================
#align(center)[
  #v(0.2cm)
  #image("images/image.jpg", width: 7.0cm)

  #v(0.6cm)
  #text(weight: "bold", size: 12pt)[
    Universidad Nacional Autónoma de Nicaragua, Managua \
    #v(0.2cm)
    Recinto Universitario Rubén Darío \
    Área de Ciencias Básicas y Tecnología \
    Departamento de Matemáticas \
    #v(0.3cm)
    Ingeniería en Ciencias de Datos – 2 Año \
    #v(0.2cm)
    Componente Curricular: Integrador III
  ]

  #v(0.9cm)
  #text(size: 13pt)[
    Impacto del Financiamiento en la Generación de Empleo y Diversificación Productiva de las \
    Explotaciones Agropecuarias de Nicaragua (CENAGRO 2011)
  ]

  #v(0.8cm)
  #text(weight: "bold", size: 11pt)[Autores:]

  #align(center)[
    #block(width: 60%, align(left)[
      - Aguilar Rodríguez, Kendall Ezequiel: 25416812
        - Miranda Pérez, José Daniel: 25405450
      - Oyarzo Morales, Ricardo Alberto: 25405614
        - Medrano Dávila, Luis David: 25414997
    ])
  ]

  #v(0.6cm)
  #text(weight: "bold", size: 11pt)[
    Docente: Deyvi Antonio López Rojas \
    #v(0.15cm)
    Asesor metodológico: Gerardo Mendoza J
  ]

  #v(0.8cm)
  #text(size: 11pt)[
    #text(weight: "bold")[Lugar y fecha:] \
    #v(0.1cm)
    Managua, 6 de junio de 2025
  ]
]

#pagebreak()

// ==========================================
// RESUMEN
// ==========================================
= Resumen

El acceso al crédito rural es un factor determinante para el desarrollo socioeconómico; sin embargo, su impacto cuantitativo en la estructura agraria requiere evaluación empírica. El presente artículo analiza el efecto del financiamiento en la generación de empleo y la diversificación productiva de las explotaciones agropecuarias nicaragüenses durante el ciclo 2010-2011. Se aplicó un enfoque cuantitativo y un diseño no experimental de corte transversal, procesando más de 226,000 registros del IV Censo Nacional Agropecuario (CENAGRO). Para superar las limitaciones de hardware ante el volumen de datos, se implementó una arquitectura de _Modern Data Stack_, utilizando transformaciones vectorizadas en el lenguaje Rust (Apache DataFusion) y modelado analítico mediante DuckDB. La investigación establece un marco metodológico reproducible que permite aislar el impacto del capital en la intensidad laboral y la vocación económica, sentando las bases empíricas para evaluar si el ecosistema financiero actúa como un motor de desarrollo humano o como un cuello de botella institucional.

*Palabras clave:* Financiamiento agropecuario, Intensidad laboral, Diversificación productiva, Ingeniería de datos.

#pagebreak()

// ==========================================
// INTRODUCCIÓN
// ==========================================
= Introducción

En el sector agropecuario, el acceso al financiamiento representa un factor estructural que influye de manera decisiva en el desarrollo productivo y en las condiciones socioeconómicas de las explotaciones. El análisis de la matriz agraria nicaragüense, capturada a través del IV Censo Nacional Agropecuario (CENAGRO 2011), exige comprender un contexto histórico caracterizado por la recuperación económica posterior a la crisis financiera global de 2008-2009. Durante este ciclo agrícola, el país experimentó una reconfiguración de sus políticas de fomento productivo, transitando hacia un modelo de mayor intervención y apoyo directo por parte del Estado. Las respuestas de los productores capturadas en la boleta censal reflejan su adaptación a las condiciones de producción y al ecosistema de financiamiento durante el ciclo agrícola de referencia @cenagro2013[pp. 1-3].

A pesar de la centralidad del crédito rural para dinamizar el campo, existe una limitada evidencia empírica desde un enfoque estrictamente cuantitativo que permita contrastar de manera rigurosa el desempeño de las unidades productivas que acceden a recursos financieros frente a aquellas que operan en la exclusión. Esta falta de análisis estadístico dificulta la comprensión del impacto real del apalancamiento en la dinámica productiva. Por ello, resulta pertinente analizar si existen diferencias estadísticamente significativas en variables críticas como el volumen de absorción de mano de obra y la diversificación del uso del suelo entre ambos grupos de explotaciones.

Este análisis se fundamenta en la premisa de que el acceso al capital no es solo un indicador de rentabilidad, sino un mecanismo para el fortalecimiento de las capacidades productivas y la reducción de la vulnerabilidad socioeconómica. Se postula que el financiamiento actúa como un catalizador que permite a las unidades agropecuarias estabilizar su fuerza laboral y mejorar la eficiencia operativa. Este planteamiento concuerda estratégicamente con los ejes del Plan Nacional de Lucha contra la Pobreza para el Desarrollo Humano, proveyendo evidencia basada en datos para el diseño de políticas de Soberanía Alimentaria y fomento a la producción rural @grun2021[pp. 21, 98-103].

El objetivo general de la presente investigación es analizar el impacto del financiamiento en la generación de empleo y la diversificación productiva de las explotaciones agropecuarias en Nicaragua. Para alcanzar este propósito, se establecieron tres objetivos específicos: primero, comparar el volumen de generación de empleo entre explotaciones financiadas y no financiadas aislando el sesgo de economías de escala; segundo, evaluar el nivel de diversificación productiva frente a la dependencia del monocultivo o la ganadería extensiva; y tercero, contrastar empíricamente la fricción institucional en las tasas de aprobación crediticia.

Para dar respuesta a estos objetivos, el presente artículo se ha estructurado de la siguiente manera: la sección posterior detalla la metodología implementada, fundamentada en una arquitectura de Modern Data Stack (Apache DataFusion y DuckDB) que permite el procesamiento inmutable y vectorizado del universo censal; seguido del análisis y discusión de los resultados derivados del contraste de cohortes (A/B Testing); finalizando con las conclusiones que sintetizan los hallazgos sobre la capacidad del ecosistema financiero para actuar como motor de desarrollo humano.

#pagebreak()

// ==========================================
// MATERIAL Y MÉTODOS
// ==========================================
= Material y Métodos

Se aplicó un enfoque cuantitativo mixto con un diseño no experimental de corte transversal, tratando la base de datos oficial del IV Censo Nacional Agropecuario (CENAGRO 2011) como un artefacto estático e inmutable. El universo de estudio comprendió más de 226,000 registros correspondientes a las explotaciones agropecuarias operativas durante el ciclo de referencia @cenagro2013[p. 12]. El alcance de la investigación es descriptivo-correlacional, orientado a evaluar las brechas relativas generadas por la inyección de capital en el sector rural.

== Referentes conceptuales o marco teórico

Para garantizar el rigor analítico y evitar ambigüedades, los conceptos fundamentales de esta investigación se alinean estrictamente con el manual de aspectos metodológicos del CENAGRO @cenagro2013. Estos conceptos constituyen la base semántica sobre la cual se estructuran las variables procesadas por el motor analítico:

- *Explotación Agropecuaria (EA):* Se define como toda extensión de tierra utilizada total o parcialmente para la producción agrícola, pecuaria o forestal, bajo una gerencia o administración única (p. 4). En el modelo computacional implementado, cada registro único en la tabla consolidada representa una EA.
- *Financiamiento Agropecuario:* Se refiere a la provisión de capital líquido o en especie para el desarrollo de actividades productivas. En la arquitectura de datos, este concepto se rastrea mediante la matriz de demanda y acceso, clasificándose según su origen en formal (bancos, cooperativas, gobierno) e informal (prestamistas, acopiadores).
- *Fuerza Laboral (Generación de Empleo):* Representa la intensidad de la mano de obra absorbida por la unidad productiva. Se clasifica operativamente por su duración en empleo permanente (contratación regular ≥ 6 meses) y empleo temporal (contratación estacional < 6 meses) (p. 9).
- *Aprovechamiento de la Tierra (Uso de Suelo):* Corresponde a la clasificación física del destino dado a las parcelas durante el año agrícola de referencia, diferenciando la vocación agrícola, pecuaria o forestal (p. 8).

#pagebreak()

== Métricas y Variables de Estudio

Para evaluar el impacto del financiamiento, se establecieron métricas analíticas calculadas dinámicamente que permiten normalizar los datos y aislar el efecto del tamaño de la unidad productiva:

+ *Intensidad Laboral:* Representa la cantidad de fuerza laboral absorbida por cada manzana (Mz) de tierra. Esta métrica permite comparar explotaciones de distintas escalas en igualdad de condiciones. Se formula mediante la suma de trabajadores permanentes y temporales dividida entre el área total explotada.
+ *Ratio de Trabajo Permanente:* Mide la calidad y estabilidad del empleo generado. Se calcula como la proporción de trabajadores permanentes sobre el total de la fuerza laboral contratada. Una ratio elevada sugiere que el acceso al crédito favorece la estabilización de la mano de obra frente a la contratación estacional.
+ *Índice de Diversificación:* Proporciona un conteo de la variedad de actividades productivas (anuales, permanentes, pastos, forestal) dentro de una misma EA. Funciona como un indicador de resiliencia económica y complejidad técnica.
+ *Ratio Pasto-Cultivo:* Cuantifica el balance entre la intensificación pecuaria y la intensificación agrícola. Se enfoca exclusivamente en el suelo activo, donde una ratio mayor a 1.0 indica un perfil predominantemente ganadero y una ratio menor a 1.0 señala una vocación mayoritariamente agrícola.
+ *Eficiencia de Aprobación de Crédito:* Mide la tasa de éxito de las solicitudes de préstamo. Se obtiene dividiendo el total de créditos recibidos entre el total de créditos solicitados, permitiendo identificar obstáculos institucionales según el rubro productivo.

Esta fundamentación teórica permite transformar los microdatos del censo en indicadores de impacto socioeconómico rigurosos y coherentes con los lineamientos nacionales de desarrollo rural.

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
  image("images/image1.png", width: 100%),
  caption: [Embudo de Acceso al Crédito.]
) <fig-embudo>

Como se demuestra en la @fig-embudo, la contracción más aguda no ocurre en la fase de evaluación bancaria, sino en la entrada misma al sistema crediticio: de las 262,546 explotaciones censadas en el país, únicamente 41,756 unidades (15.9%) lograron tramitar una solicitud de financiamiento. En contraste, entre los productores que consiguen formalizar su solicitud, la tasa empírica de aprobación asciende a un elevado 92.6% (38,680 créditos concedidos), frente a un rechazo de apenas el 7.4%. Este contraste demuestra empíricamente que la principal falla de mercado no reside en una denegación masiva de créditos en ventanilla, sino en una exclusión estructural de base (carencia de garantías hipotecarias, aislamiento geográfico o autoexclusión por informalidad) que impide al 84.1% de los productores tan siquiera postularse al sistema formal.

Paralelamente, el análisis de la matriz de orígenes de financiamiento confirma la estructura del mercado financiero en el sector agrario.

#figure(
  image("images/image2.png", width: 100%),
  caption: [Principales Fuentes de Financiamiento.]
) <fig-fuentes>

De acuerdo con los datos reflejados en la @fig-fuentes, contrario a la asunción de que el agro nicaragüense se sostiene primariamente por vías informales o solidarias, la banca comercial privada (18,255 créditos) es el proveedor líder absoluto, duplicando casi el alcance de las estructuras asociativas (Cooperativas con 9,793) y superando ampliamente a las ONGs (2,662). Las fuentes informales (1,801 prestamistas y 1,618 acopiadores) y la banca estatal de fomento (Banco Produzcamos con 586) representan participaciones minoritarias en el volumen global. Este comportamiento demuestra que, para la minoría de explotaciones que logran insertarse en el circuito de crédito, el apalancamiento depende primariamente del ecosistema bancario tradicional y sus exigencias colaterales.

En síntesis, los datos prueban que la privación de servicios financieros formales actúa como una barrera de entrada que margina a la mayoría del universo censal. El ecosistema financiero, lejos de funcionar como un habilitador fluido, limita el crecimiento macroeconómico del sector y confina a una gran proporción de las explotaciones a operar bajo modelos de subsistencia y vulnerabilidad de capital.

#pagebreak()

== Dinámica de la Fuerza Laboral: Densidad y Calidad del Empleo

Para cuantificar el impacto real de la inyección de capital en la generación de empleo agropecuario, se evaluó la Intensidad Laboral (absorción de trabajadores por manzana). Con el fin de aislar el sesgo generado por las economías de escala y evitar que el comportamiento de los minifundios distorsionara el análisis comparativo, la muestra se segmentó rigurosamente por clase de tamaño (`farm_size_class`). El sector micro no es tomado en cuenta para la métrica de intensidad laboral, agrupando en esa categoria las explotaciones agronomas que poseen menos de una manzana.

#figure(
  image("images/image3.png", width: 100%),
  caption: [Intensidad Laboral Mediana por Escala y Acceso a Crédito.]
) <fig-intensidad>

Como se observa en la @fig-intensidad, los datos demuestran empíricamente que el financiamiento actúa como un catalizador expansivo para la contratación, desestimando la hipótesis de que el capital se destina primariamente a la sustitución tecnológica del trabajador. Las fincas clasificadas como medianas y grandes (Medium/Large) que recibieron crédito registraron un incremento masivo en su capacidad de absorción, superando en un 171.6% la mediana de intensidad laboral de las unidades equivalentes sin acceso a financiamiento. Asimismo, en el segmento de pequeñas explotaciones (Small), la brecha relativa se situó en un incremento del 33.3%.

Más allá del volumen absoluto de contrataciones, resulta crítico evaluar la calidad y estabilidad del empleo generado. Se procedió a analizar el Ratio de Trabajo Permanente para determinar si la disponibilidad de liquidez permite a las explotaciones transitar desde un modelo dependiente de mano de obra puramente estacional (ratio 0.0) hacia estructuras de contratación continuas y estables (ratio 1.0).

#figure(
  image("images/image4.png", width: 100%),
  caption: [Distribución de la Estabilidad Laboral (Proporción Relativa).]
) <fig-estabilidad>

La @fig-estabilidad confirma la naturaleza estructuralmente bimodal y polarizada del mercado laboral rural nicaragüense. El análisis de la distribución revela que el 72.5% de las unidades financiadas operan exclusivamente con trabajadores temporales, una proporción ligeramente superior al 68.3% observado en el grupo no financiado. Inversamente, la consolidación de planillas compuestas en un 100% por personal permanente presenta una mayor prevalencia relativa en fincas sin crédito (12.0% frente a 5.8%).

Estos resultados indican que el apalancamiento financiero funciona como un multiplicador extraordinario del volumen absoluto de empleo, pero dicho capital es inyectado predominantemente para satisfacer picos de demanda estacional (procesos intensivos de siembra, mantenimiento o cosecha). En consecuencia, si bien el crédito formaliza y expande drásticamente las operaciones agrícolas, la estructura de contratación subyacente mantiene una dependencia histórica hacia la fuerza laboral transitoria.

== Complejidad Productiva y Transición hacia la Intensificación Agrícola

La resiliencia económica de una unidad productiva frente a la volatilidad climática y de mercado está estrechamente vinculada a su nivel de diversificación. Para evaluar si la inyección de capital promueve la adopción del policultivo como mecanismo de mitigación de riesgo, se contrastó el Índice de Diversificación (conteo de rubros operativos) entre las cohortes analizadas.

#figure(
  image("images/image8.png", width: 100%),
  caption: [Densidad de Complejidad Productiva (Distribución Normalizada).]
) <fig-complejidad>

Al contrastar la distribución en la @fig-complejidad, se evidencia un claro desplazamiento estadístico hacia una mayor diversificación en el grupo capitalizado. Mientras que las explotaciones no financiadas concentran su pico modal en apenas 2 rubros (25.1% de las fincas), la cohorte financiada traslada su moda hacia los 3 rubros (23.7%) y sostiene una mayor presencia relativa en niveles superiores de complejidad (4 a 6 rubros). Los cálculos de los deltas absolutos confirman que las unidades con acceso a crédito incorporan en promedio 0.29 rubros adicionales (media de 3.65 frente a 3.36 rubros). Este comportamiento demuestra empíricamente que el apalancamiento financiero reduce el riesgo y supera las barreras de entrada para nuevos cultivos, rompiendo la dependencia hacia el monocultivo o la especialización pecuaria pura.

De forma complementaria, el análisis evaluó si el acceso a crédito fomenta una transición desde la ganadería extensiva (modelo de bajo rendimiento dominante a nivel nacional) hacia la intensificación agrícola. Para ello, se contrastó la composición del uso del suelo y el Ratio Pasto-Cultivo. Una ratio menor a 1.0 indica un dominio de la superficie agrícola, mientras que un valor superior refleja una vocación de intensificación ganadera.

#figure(
  image("images/image6.png", width: 100%),
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
