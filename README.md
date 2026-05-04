# Proyecto Integrador III: Pipeline de Datos CENAGRO 2011

Pipeline de datos de alto rendimiento para el procesamiento y análisis del censo agrícola CENAGRO 2011. Implementa una arquitectura ETL desacoplada utilizando **Rust (Apache DataFusion)** para transformación, **DuckDB** como motor OLAP y **Evidence.dev** para la capa de presentación. Orquestado localmente mediante **Podman** y **Just**.

## Arquitectura y Patrones de Diseño
* **Motor de Consultas Distribuidas:** Implementación de **Apache DataFusion** sobre **Tokio** para la ejecución asíncrona y multihilo de planes de consulta físicos utilizando el estándar de memoria columnar Arrow.
* **Separación de Inquietudes (SoC):** Desacoplamiento estricto entre transformación pesada (`/etl`), almacenamiento analítico (`/sql`) y visualización (`/analytics`).
* **Patrón de Extensión (Extension Trait):** Uso de `DataFrameExt` en Rust para inyectar mutaciones dinámicas de columnas (`with_columns`) directamente en el plan lógico de DataFusion, manteniendo la inmutabilidad y el tipado estricto.
* **Infraestructura Inmutable (IaC):** Entornos aislados definidos en `infra/*.Containerfile`, ejecutados vía **Podman** (arquitectura *daemonless* sin privilegios de root).

## Stack Tecnológico
* **Motor ETL:** Rust, Apache DataFusion, Tokio, snmalloc (asignador de memoria optimizado).
* **Data Warehouse:** DuckDB (SQL).
* **Frontend Analytics:** Evidence.dev (Markdown-as-Code + SQL).
* **Orquestación y Entorno:** Just, Podman, Zellij.

## Consideraciones de Escalabilidad y Casos Límite
* **Gestión de Memoria y Planes de Ejecución:** DataFusion procesa datos en lotes (RecordBatches). Las operaciones costosas (como *Joins* o *Aggregations*) sobre el dataset CENAGRO deben aprovechar particionamiento para evitar cuellos de botella y errores OOM (Out of Memory).
* **Manejo de Asignación de Memoria:** La integración de `snmalloc-rs` reduce la contención de bloqueos en operaciones altamente concurrentes durante la evaluación de expresiones de DataFusion.
* **Concurrencia de Escritura:** DuckDB limita las transacciones de escritura concurrentes. Las cargas (`build-warehouse.sql`) deben ser secuenciales antes de inicializar la capa de BI.

## Comandos de Operación
Utilizar `just` desde la raíz del proyecto para orquestar la infraestructura:

* **Entorno de Desarrollo:**
  `just enter` - Inicializa el layout del IDE en Zellij.

* **Pipeline ETL (Rust):**
  `just build-compiler` - Construye la imagen del compilador.
  `just build-pipeline` - Construye el contenedor del transformador.
  `just run-pipeline` - Ejecuta la ingesta procesando archivos Parquet (Farms & Parcels).

* **Almacenamiento (DuckDB):**
  `just build-werehouse` - Inicializa el motor OLAP y ejecuta los scripts de carga DDL/DML.

* **Analytics (Evidence):**
  `just build-bi-container` - Prepara la imagen para el servidor de BI.
  `just add-meta-bi` - Sincroniza fuentes de datos y metadatos.
  `just run-bi` - Levanta el servidor de desarrollo UI en `localhost:3000`.
  `just build-bi` - Compila los artefactos estáticos de Evidence.


## Open werehouse with cli 

.open analytics/sources/warehouse/warehouse.duckdb
