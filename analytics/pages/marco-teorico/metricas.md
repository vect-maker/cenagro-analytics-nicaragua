# Métricas y Variables de Estudio

Para evaluar el impacto del financiamiento, se establecen métricas analíticas calculadas dinámicamente en nuestra capa semántica. Estas métricas permiten normalizar los datos y aislar el efecto del tamaño de la unidad productiva.

### 1. Intensidad Laboral (Factor Trabajo por Manzana)

Para normalizar la generación de empleo y evitar que el tamaño absoluto de la finca sesgue los resultados, la métrica de empleo se evalúa en función del área total explotada. Esta métrica representa la cantidad de fuerza laboral absorbida por cada manzana de tierra.

La fórmula aplicada en el motor analítico es la siguiente:

> **Intensidad Laboral** = `[ Empleo Permanente (S1068A) + Empleo Temporal (S1069A) ] / Area Total Mz (S427)`

**Mapeo en SQL:**
En nuestra base de datos consolidada `farms`, esta métrica se calcula al vuelo o se consulta mediante el alias `labor_to_land_ratio`, sumando las columnas `permanent_workers_total` y `temporal_workers_total`, divididas entre `total_area_mz`.