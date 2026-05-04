# Entorno de Ejecución y Arquitectura del Sistema

El procesamiento y análisis de los datos se ejecutan bajo una arquitectura desacoplada orientada a la **reproducibilidad y la eficiencia en el consumo de recursos**. Se trata a la base de datos original del CENAGRO 2011 como un artefacto estático e inmutable, permitiendo que el flujo de trabajo opere como una función de transformación pura y determinista.

## 1. Entorno y Hardware (Restricciones y Soluciones)

Las limitaciones físicas del hardware dictaron la necesidad de construir una arquitectura capaz de procesar datos de forma vectorizada, minimizando la carga en la memoria central para evitar cuellos de botella (OOM kills).

*   **Hardware Base:** Computadora portátil HP ProBook 450 G8 (Intel Core i7-1165G7, 16 GB RAM).
*   **Sistema Operativo:** **Aurora Fedora**, una variante atómica e inmutable de Linux que garantiza un entorno host estéril y predecible.
*   **Orquestación de Contenedores:** Toda la infraestructura (compilación en Rust y servidor BI) está contenerizada mediante **Podman**. Se descartó Docker en favor de Podman debido a su arquitectura sin demonios (*daemonless*) y su capacidad nativa de ejecución segura sin privilegios de superusuario (*rootless*), lo cual es una mejor práctica de seguridad industrial.

---

## 2. Flujo de Procesamiento de Datos (Pipeline ETL)

La ingeniería de datos se diseñó en tres fases secuenciales, separando la extracción pesada (I/O) de la computación intensiva en memoria (CPU).

### Fase I: Extracción e Ingesta Cruda
*   **Herramienta:** Script aislado en Python.
*   **Mecanismo:** Lectura de archivos binarios originales de SPSS y volcado directo a formato columnar **Parquet**.
*   **Optimización:** Al convertir de un formato basado en filas a columnar, el peso se reduce de ~100 MB a tan solo 10 MB. Aislar este paso en Python impide que la ineficiencia del *Garbage Collector* de este lenguaje afecte el rendimiento del núcleo del pipeline.

### Fase II: Transformación y Tipificación Estricta
*   **Herramienta:** Motor de ejecución **Apache DataFusion** (escrito en Rust).
*   **Mecanismo:** El esquema sufre un proceso agresivo de *downcasting*. Los valores de coma flotante por defecto se reducen a los tipos enteros mínimos viables (ej. `UInt8`, `UInt16`).
*   **Dictionary Encoding:** Variables categóricas de cardinalidad baja (ej. actividad principal) reemplazan cadenas de texto con punteros numéricos utilizando el tipo nativo *Dictionary* de Apache Arrow. Esto maximiza la compresión y la velocidad de escaneo en caché L1/L2.
*   **Desnormalización:** Para evitar costosos *Joins* en tiempo de ejecución, el pipeline pre-agrega las parcelas y genera una única tabla OLAP denormalizada (`farms`).

### Fase III: Modelado y Motor Analítico
*   **Herramienta:** **DuckDB**.
*   **Mecanismo:** Actúa como motor analítico en proceso. DuckDB realiza lecturas directas (*zero-copy reads*) directamente sobre los archivos Parquet optimizados sin necesidad de cargarlos en memoria o requerir un servidor de base de datos en ejecución constante.

---

## 3. Capa Semántica y Materialización

El volumen del dataset presenta un problema clásico de arquitectura web: renderizar y enviar más de 226,000 registros colapsaría la memoria de cualquier navegador cliente (*browser crash*). 

*   **Materialización Estática:** Se utiliza el framework de BI como código, **Evidence.dev**. Las funciones de agregación y el cálculo de métricas (ej. *Intensidad Laboral*) no ocurren cuando el usuario visita la página. Todo se ejecuta en **tiempo de compilación** (Build-Time).
*   **Componentes Desacoplados:** Las consultas SQL (DuckDB) dentro de los archivos Markdown generan tablas de resumen altamente comprimidas (JSON/Parquet ligeros). Los gráficos interactivos del cliente consumen únicamente estos resultados precomputados, no la base de datos cruda.
*   **Despliegue:** La salida es un sitio web 100% estático (HTML/JS/CSS), distribuido a través de la CDN global de **Netlify**. Esto garantiza tiempos de carga de milisegundos, alta disponibilidad, acceso abierto de los datos y coste de alojamiento cero operativo.