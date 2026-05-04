# Métricas y Variables de Estudio

Para evaluar el impacto del financiamiento, se establecen métricas analíticas calculadas dinámicamente en nuestra capa semántica. Estas métricas permiten normalizar los datos y aislar el efecto del tamaño de la unidad productiva.

---

### 1. Labor Intensity (Intensidad Laboral)

Para normalizar la generación de empleo y evitar que el tamaño absoluto de la finca sesgue los resultados, la métrica de empleo se evalúa en función del área total explotada. Esta métrica representa la cantidad de fuerza laboral absorbida por cada manzana de tierra, permitiendo comparar una finca de 5 manzanas con una de 500 manzanas en igualdad de condiciones.

> **Labor Intensity (Intensidad Laboral)** = `(permanent_workers_total + temporal_workers_total) / total_area_mz`

**Mapeo en SQL:**
En nuestra base de datos consolidada `farms`, esta métrica se calcula al vuelo o se consulta mediante el alias `labor_to_land_ratio`, sumando las columnas `permanent_workers_total` y `temporal_workers_total`, divididas entre `total_area_mz`.

---

### 2. Permanent Labor Ratio (Proporción de Trabajo Permanente)

Mide la calidad y estabilidad del empleo generado dentro de la explotación. Una proporción más alta de trabajadores permanentes en fincas financiadas sugeriría que el acceso al crédito ayuda a formalizar o estabilizar la fuerza laboral frente a la contratación meramente estacional.

> **Permanent Labor Ratio (Proporción de Trabajo Permanente)** = `permanent_workers_total / (permanent_workers_total + temporal_workers_total)`

**Mapeo en SQL:**
Esta métrica se calcula bajo el alias `permanent_labor_ratio` dentro del pipeline de transformación, permitiendo evaluar la composición del empleo contratado.

---

### 3. Hired Labor Prevalence (Prevalencia de Mano de Obra Contratada)

Es una métrica de frecuencia binaria utilizada para determinar qué porcentaje de explotaciones en cada grupo participa efectivamente en el mercado laboral más allá del trabajo familiar. 

> **Hired Labor Prevalence (Prevalencia de Mano de Obra Contratada)** = `count(hired_workers = true) / total_farms`

**Mapeo en SQL:**
Se obtiene utilizando la variable booleana `hired_workers` para identificar las explotaciones que reportaron explícitamente la contratación de personal en la boleta censal.

### 4. Land Use Composition Ratio (Ratio de Composición de Uso de Suelo)

Esta métrica identifica el **perfil productivo** de la explotación al desglosar cómo se distribuye el área total entre las distintas categorías de uso de suelo. Permite determinar, por ejemplo, si las fincas financiadas muestran una mayor inclinación hacia cultivos permanentes de exportación frente a cultivos anuales de consumo básico.

> **Land Use Composition Ratio (Ratio de Composición de Uso de Suelo)** = `mz_[categoría] / total_area_mz`

**Mapeo en SQL:**
Se calcula de forma iterativa para cada columna de la matriz de aprovechamiento (`mz_annual_crops`, `mz_permanent_crops`, etc.), dividiendo el valor de la columna entre `total_area_mz` para obtener la participación porcentual de cada rubro en la explotación.

---

### 5. Diversification Index (Índice de Diversificación)

Proporciona un conteo simple de la variedad de actividades productivas dentro de una sola explotación. Un conteo elevado indica una estrategia de diversificación (policultivo o sistemas mixtos), mientras que un conteo bajo señala una especialización productiva.

> **Diversification Index (Índice de Diversificación)** = `count_if(mz_annual, mz_permanent, mz_pasture, mz_forest > 0)`

**Mapeo en SQL:**
En el motor analítico, esta métrica se implementa sumando indicadores booleanos para cada categoría: `(CASE WHEN mz_annual_crops > 0 THEN 1 ELSE 0 END) + (CASE WHEN mz_permanent_crops > 0 THEN 1 ELSE 0 END) + ...`, evaluando la presencia de al menos cuatro tipos distintos de uso de suelo.

---

### 6. Pasture-to-Crop Ratio (Ratio Pasto-Cultivo)

Esta métrica resalta el balance entre la actividad pecuaria (extensificación) y la actividad agrícola (intensificación). Es fundamental para contrastar si el financiamiento fomenta la expansión de pastizales o la intensificación de áreas cultivables.

> **Pasture-to-Crop Ratio (Ratio Pasto-Cultivo)** = `(mz_cultivated_pasture + mz_natural_pasture) / (mz_annual_crops + mz_permanent_crops)`

**Mapeo en SQL:**
Utiliza el agregado de las columnas de pastos frente al agregado de cultivos temporales y permanentes. Un ratio > 1 indica un perfil predominantemente ganadero,mientras que un ratio menor a 1 indica una vocación mayoritariamente agrícola.

### 7. Credit Approval Efficiency (Eficiencia de Aprobación de Crédito)

Esta métrica mide la **"tasa de éxito"** de las solicitudes de préstamo. Al segmentar este resultado mediante la matriz `req_`, es posible identificar qué rubros productivos (ej. ganadería vs. cultivos) enfrentan mayores obstáculos institucionales para la obtención del crédito.

> **Credit Approval Efficiency (Eficiencia de Aprobación de Crédito)** = `count(received_loan = true) / count(requested_loan = true)`

**Mapeo en SQL:**
Se calcula dividiendo el total de registros con `received_loan` en verdadero entre el total de registros que marcaron `requested_loan` como verdadero. El cruce con las columnas de la matriz de solicitud (`req_crop`, `req_livestock`, etc.) permite desglosar esta eficiencia por finalidad del crédito.

---

### 8. Relative Intensity Gap (Brecha de Intensidad Relativa)

Cuantifica la **diferencia porcentual** en la absorción de mano de obra entre las explotaciones financiadas y las no financiadas. Proporciona una cifra única de **"impacto"** para el análisis comparativo, permitiendo concluir si el financiamiento se traduce en una generación de empleo significativamente mayor por unidad de área.

> **Relative Intensity Gap (Brecha de Intensidad Relativa)** = `(Avg_Intensity_Financed - Avg_Intensity_NonFinanced) / Avg_Intensity_NonFinanced`

**Mapeo en SQL:**
Esta métrica utiliza el promedio del alias `labor_to_land_ratio` calculado para los dos segmentos de la población (segmentados por la variable `received_loan`) para determinar la magnitud de la brecha observada.

---

### 9. Technological Traction Ratio (Ratio de Tracción Tecnológica)

Utiliza la matriz de tracción para evaluar si el financiamiento correlaciona con la **mecanización** de la unidad productiva. La incorporación de tecnología mecánica es un motor fundamental que afecta tanto la capacidad de diversificación del suelo como la composición de la fuerza laboral necesaria.

> **Technological Traction Ratio (Ratio de Tracción Tecnológica)** = `count(traction_tractor = true) / total_farms`

**Mapeo en SQL:**
Se obtiene mediante el conteo de la variable booleana `traction_tractor` en relación al universo total de explotaciones (`total_farms`), permitiendo observar la prevalencia de maquinaria frente a métodos tradicionales de tracción animal o manual.