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