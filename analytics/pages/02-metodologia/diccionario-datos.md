# Diccionario de Datos y Contratos de Esquema

## 1. Esquema Físico Desnormalizado (OLAP)

A diferencia del diseño relacional inicial, el motor Apache DataFusion ejecuta una pre-agregación de todas las parcelas y las fusiona directamente en la tabla de explotaciones (`farms`). Este **modelo desnormalizado (Wide-Table)** optimiza drásticamente las consultas analíticas en DuckDB al eliminar *joins* costosos en tiempo de ejecución.

### Claves Compuestas de Identificación
*   **`department`**: Código/Nombre del departamento.
*   **`municipality`**: Código/Nombre del municipio.
*   **`supervision_area_id`**: Identificador del área de supervisión.
*   **`census_segment_id`**: Número de segmento censal (SEA).
*   **`farm_id`**: Número de identificación de la explotación.

### Métricas de Parcelas Pre-agregadas
Variables computadas durante la fase ETL que cuantifican la superficie (en manzanas) dedicada a categorías específicas de aprovechamiento de tierra:
*   **`total_parcels`**: Número total de subdivisiones.
*   **`total_farm_manzanas`**: Área total agregada calculada por el pipeline.
*   **Aprovechamiento Específico (`DOUBLE`)**: `mz_annual_crops`, `mz_permanent_crops`, `mz_cultivated_pasture`, `mz_natural_pasture`, `mz_fallow`, `mz_forest`, `mz_infrastructure`, `mz_unusable`.

---

## 2. Mapeo de Categorías y Referencias Geográficas (Data Dictionary)

Las siguientes variables categóricas y anexos geográficos fueron tipificados usando diccionarios en memoria (Dimensional Modeling). La lógica de traducción se mantiene centralizada mediante consultas SQL, garantizando una única fuente de verdad.

### Género del Productor (S211D)
```sql map_gender
SELECT * FROM warehouse.dim_producer_gender;
```
<DataTable data={map_gender} />

### Estructura Operacional (S322)
```sql map_structure
SELECT * FROM warehouse.dim_operational_structure;
```
<DataTable data={map_structure} />

### Actividad Económica Principal (S324)
```sql map_activity
SELECT * FROM warehouse.dim_principal_activity;
```
<DataTable data={map_activity} search=true pagination=true rows=10 />

### Municipios (S102)
```sql map_municipality
SELECT * FROM warehouse.dim_municipality;
```
<DataTable data={map_municipality} search=true pagination=true rows=10 />

### Departamentos (S101)
```sql map_department
SELECT * FROM warehouse.dim_department;
```
<DataTable data={map_department} search=true />


## 3. Estructura de la Tabla de Hechos (`farms`)

Para facilitar el análisis programático en DuckDB, la tabla `farms` organiza sus variables en matrices de indicadores (booleanos agrupados por prefijo) y atributos escalares independientes.

### A. Matrices de Indicadores (One-Hot Encoding)
Estas columnas representan conjuntos de categorías expandidos en variables booleanas. Son ideales para realizar sumatorias (`SUM`) y determinar frecuencias de acceso sin necesidad de realizar uniones complejas.

*   **Origen del Financiamiento (`loan_`):**
    Identifica la entidad financiera proveedora del crédito: `loan_banco`, `loan_banco_produzcamos`, `loan_ong`, `loan_cooperativa`, `loan_gobierno`, `loan_comercial`, `loan_prestamista`, `loan_acopiador`, `loan_otro`.
*   **Categoría de Financiamiento Solicitado (`req_`):**
    Indica que la EA solicitó un préstamo para un rubro específico: `req_crop` (agrícola), `req_livestock` (pecuario), `req_aquaculture` (acuícola), `req_forestry` (forestal).
*   **Categoría de Financiamiento Recibido (`rec_`):**
    Indica que la EA efectivamente recibió el préstamo para el rubro correspondiente: `rec_crop`, `rec_livestock`, `rec_aquaculture`, `rec_forestry`.
*   **Método de Tracción (`traction_`):**
    Describe el nivel de mecanización: `traction_animal`, `traction_tractor`.

### B. Atributos Escalares e Identidad
Variables independientes que funcionan como dimensiones de filtrado o métricas continuas para el cálculo de promedios y proporciones.

*   **Booleanos de Estado:**
    `hired_workers`, `has_irrigation_system`, `has_any_loan`, `received_loan`, `requested_loan`.
*   **Identificadores y Geografía:**
    `department`, `municipality`, `supervision_area_id`, `census_segment_id`, `farm_id`.
*   **Variables Categóricas (Dimensiones):**
    `producer_gender`, `operational_structure`, `principal_activity`.
*   **Métricas de Superficie (Manzanas):**
    `total_area_mz`, `total_area_sqm`, `total_farm_manzanas`, `mz_annual_crops`, `mz_permanent_crops`, `mz_cultivated_pasture`, `mz_natural_pasture`, `mz_fallow`, `mz_forest`, `mz_infrastructure`, `mz_unusable`.
*   **Métricas de Fuerza Laboral y Conteo:**
    `permanent_workers_total`, `temporal_workers_total`, `permanent_labor_ratio`, `total_parcels`.

---

> **Nota Técnica:** El cruce de las matrices `req_` y `rec_` permite identificar la tasa de aprobación por rubro específico. Todas las métricas de superficie están expresadas en manzanas (Mz) para mantener la consistencia con el estándar del CENAGRO.