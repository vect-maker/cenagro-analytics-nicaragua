### **TL;DR**
La estructura del artículo científico se deriva directamente de la arquitectura de la capa semántica (*Evidence.dev*) del repositorio. Se mapean los archivos Markdown (`.md`) al formato estándar IMRyD exigido por las normativas de la revista.

---

### **Objetivo de la Investigación**
**Objetivo General:** Analizar el impacto estructural del financiamiento en la generación de empleo y la diversificación productiva de las explotaciones agropecuarias en Nicaragua, procesando los microdatos del CENAGRO 2011 mediante una arquitectura de *Modern Data Stack*. *(Extraído de: `index.md`)*.

---

### **Estructura del Artículo Científico (Mapeo de Repositorio)**

* **1. Título, Autores y Resumen**
    * **Origen:** `index.md`
    * **Contenido:** Metadatos del proyecto Integrador III y síntesis ejecutiva.

* **2. Introducción**
    * **Origen:** `index.md` + `01-marco-teorico/01-contexto.md` + `01-marco-teorico/04-justificacion-estrategica.md`
    * **Contenido:** Contexto macroeconómico post-2008, planteamiento del problema (brecha empírica), justificación estratégica (enfoque de capacidades de Amartya Sen) y objetivos específicos.

* **3. Desarrollo**
    * **3.1 Referentes conceptuales (Marco Teórico)**
        * **Origen:** `01-marco-teorico/02-glosario.md` + `01-marco-teorico/03-metricas.md`
        * **Contenido:** Definiciones oficiales (INIDE/MAGFOR) y formulación matemática de las variables analíticas (ej. Intensidad Laboral, Ratio Pasto-Cultivo, Índice de Diversificación).
    * **3.2 Material y Método**
        * **Origen:** `02-metodologia/arquitectura-etl.md` + `02-metodologia/diccionario-datos.md` + `index.md`
        * **Contenido:** Enfoque cuantitativo mixto, diseño de corte transversal. Detalle de la arquitectura de datos: contenedores raíz (*Podman*), transformaciones vectorizadas (*Rust/Apache DataFusion*) y modelado OLAP in-process (*DuckDB*).
    * **3.3 Análisis y Discusión de Resultados**
        * **Origen:** `03-analisis-descriptivo/02-analisis-univariado.md` + `03-analisis-descriptivo/03-analisis-comparativo-financiamiento.md`
        * **Contenido:** *A/B Testing transversal*. Comparativa entre cohortes (Financiadas vs. No Financiadas). Presentación de brechas relativas en absorción laboral (Delta de formalización) y transiciones de vocación económica. **(Aquí se insertan las Figuras visuales)**.

* **4. Conclusiones y/o recomendaciones**
    * **Origen:** `03-analisis-descriptivo/04-sintesis-resultados.md`
    * **Contenido:** Resolución empírica de hipótesis. Verificación de la fricción institucional (cuello de botella del ecosistema financiero) y confirmación del crédito como motor de policultivo e intensificación agrícola.

* **5. Referencias bibliográficas**
    * **Origen:** Extraídas implícitamente de las menciones a INIDE/MAGFOR, PNLPDH y marcos del PNUD. A formular en formato APA.