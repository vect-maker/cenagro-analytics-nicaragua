# Proyecto Integrador III: Pipeline de Datos CENAGRO 2011

Pipeline de datos de alto rendimiento para el procesamiento y análisis del censo agrícola CENAGRO 2011. Implementa una arquitectura ETL desacoplada utilizando **Rust (Polars)** para transformación vectorial, **Python** para ingesta, **DuckDB** como motor OLAP y **Evidence.dev** para la capa de presentación. Orquestado localmente mediante **Podman** y **Just**.

## Arquitectura y Patrones de Diseño
* **Separación de Inquietudes (SoC):** Desacoplamiento estricto entre extracción (`/pipes`), transformación pesada (`/etl`), almacenamiento (`/sql`) y visualización (`/analytics`).
* **Procesamiento Vectorizado en Memoria:** Implementación de **Polars** (Rust) para transformaciones de datos (`DataFrames` / `LazyFrames`), maximizando la eficiencia de la caché de la CPU y minimizando copias en memoria.
* **Infraestructura como Código (IaC):** Entornos de ejecución aislados e inmutables definidos en `infra/*.Containerfile`, ejecutados vía **Podman** (arquitectura *daemonless*).
* **Almacenamiento Analítico (OLAP):** Uso de **DuckDB** para proveer un motor SQL columnar de alto rendimiento embebido directamente en la capa analítica.

## Stack Tecnológico
* **Motor ETL:** Rust, Polars.
* **Ingesta de Datos:** Python.
* **Data Warehouse:** DuckDB (SQL).
* **Frontend Analytics:** Evidence.dev (Markdown-as-Code + SQL).
* **Orquestación y Contenedores:** Just (command runner), Podman.

## Estructura del Repositorio
* **`/etl/`**: Core del procesamiento en Rust. Incluye validación de esquemas (`src/schema/`), mapeo de catálogos (`src/mappings/`) y ejecución de grafos de transformación (`src/pipelines/`).
* **`/pipes/`**: Scripts base para adquisición de datos crudos (`ingest.py`).
* **`/analytics/`**: Definición de dashboards y métricas usando componentes UI de Evidence. Las queries analíticas residen en `sources/warehouse/`.
* **`/sql/`**: DDLs y rutinas de carga de DuckDB (`build-warehouse.sql`, `load-tables.sql`).
* **`/infra/`**: Definiciones de contenedores para cada etapa del ciclo de vida (`compiler`, `transformer`, `evidence`).

## Consideraciones de Escalabilidad y Casos Límite (Edge Cases)
* **Cuellos de botella de Memoria (OOM):** Procesar datasets censales completos in-memory puede saturar sistemas de 16GB de RAM. **Mitigación:** Asegurar el uso exclusivo de `LazyFrame` en el código Rust y aplicar *predicate pushdown* antes de invocar `.collect()`.
* **Escrituras Concurrentes en DuckDB:** DuckDB limita la concurrencia de escritura. **Mitigación:** Diseñar el flujo de orquestación (`justfile`) de manera que las operaciones DML (carga de datos del ETL al DB) sean estrictamente secuenciales y bloqueantes antes de inicializar el servidor de lectura de Evidence.
* **Manejo de Valores Nulos:** En datos censales, la ausencia de respuesta es común. Las reglas de validación en `etl/src/schema` deben usar tipos `Option<T>` estables para evitar `Panics` en tiempo de ejecución durante el parsing estructural.

## Comandos de Operación
Utilizar `just` desde la raíz del proyecto para orquestar los contenedores:
* `just build`: Construye las imágenes de Podman necesarias.
* `just etl`: Ejecuta el binario de transformación en Rust.
* `just db`: Inicializa DuckDB y ejecuta los scripts de carga en `/sql`.
* `just analytics`: Levanta el servidor de desarrollo de Evidence para visualizar resultados.
