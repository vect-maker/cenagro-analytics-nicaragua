# Perfilado y Calidad de Datos

Este apartado documenta el estado de integridad del censo y la distribución de las métricas clave tras el proceso de transformación ETL.

<Alert status="info">
  <b>Nota Metodológica:</b> La Intensidad Laboral se calcula exclusivamente para explotaciones mayores a 1 Manzana (Mz) para evitar sesgos por infraestructura en explotaciones de patio (Backyard/Micro).
</Alert>

## 1. Integridad Estructural
Verificación de la consistencia de registros y detección de duplicidad mediante `farm_uid`.
```sql integrity
SELECT * FROM integrity;
```

<Grid cols=3>
    <BigValue 
      data={integrity} 
      value=total_rows
      title="Total de Registros" 
      fmt="num0"
    />
    <BigValue 
      data={integrity} 
      value=unique_farms 
      title="Unidades Únicas" 
      fmt="num0"
    />
    <BigValue 
      data={integrity} 
      value=potential_duplicates 
      title="Registros Duplicados" 
      fmt="num0"
      color={integrity[0].potential_duplicates > 0 ? 'red' : 'green'}
    />
</Grid>

---

## 2. Validación Técnica y Detección de Anomalías
Identificación de valores fuera de rango o inconsistencias lógicas que requieren atención antes del análisis inferencial.

```sql anomalies
SELECT * FROM anomalies;
```

<Grid cols={4}>
    <BigValue 
      data={anomalies} 
      value=anomaly_workers_no_land
      title="Errores: Trabajadores sin Tierra" 
      subtitle="Fincas con 0 Mz y personal permanente"
      color={anomalies[0].anomaly_workers_no_land > 0 ? 'red' : 'green'}
    />
    <BigValue 
      data={anomalies} 
      value=min_intensity 
      title="Intensidad Mínima" 
      fmt="num2"
    />
    <BigValue 
      data={anomalies} 
      value=max_intensity 
      title="Intensidad Máxima" 
      fmt="num2"
      color={anomalies[0].max_intensity > 50 ? 'orange' : 'blue'}
    />
    <BigValue 
      data={anomalies} 
      value=max_area 
      title="Área Máxima (Mz)" 
      fmt="num0"
    />
</Grid>

<Alert status="warning">
  <b>Umbral de Alerta:</b> Se ha marcado la Intensidad Máxima en naranja si supera los 50 trabajadores/Mz, lo cual podría indicar errores de digitación en la boleta censal original o casos atípicos de invernaderos de alta densidad.
</Alert>

---

## 3. Perfil Demográfico y Vocación Productiva
Distribución de la titularidad de las explotaciones y la naturaleza de las actividades económicas declaradas.
```sql gender_dist
SELECT 
    producer_gender AS Genero, 
    COUNT(*) AS Total,
    COUNT(*) * 100.0 / SUM(COUNT(*)) OVER() AS Porcentaje
FROM farm_profiles
GROUP BY 1
ORDER BY Total DESC;
```

```sql activity_dist
SELECT 
    principal_activity AS Actividad, 
    COUNT(*) AS Fincas
FROM farm_profiles
WHERE principal_activity != 'ignorado'
GROUP BY 1
ORDER BY Fincas DESC
LIMIT 8;
```

<Grid cols={1}>
    <BarChart
        data={gender_dist}
        x=Genero
        y=Porcentaje
        title="Distribución por Género"
        yAxisTitle="% de Fincas"
        swapXY=true
        fillColor="#8dacbf"
    />
 
        <BarChart
        data={activity_dist}
        x=Actividad
        y=Fincas
        title="Top 8 Actividades Principales"
        yAxisTitle="Número de Fincas"
        swapXY=true
        fillColor="#236aa4"
    />
</Grid>


<Details title="Interpretación del Perfil">
  La inclusión de la <b>Estructura Operacional</b> revela la predominancia de modelos individuales frente a cooperativos o empresas[cite: 1]. Este cruce es vital: las unidades con estructura de "Empresa" o "Cooperativa" suelen presentar comportamientos de intensidad laboral y acceso a crédito radicalmente distintos a los del productor individual.
</Details>



### Detalle de Estructuras Organizadas
Para observar la distribución entre modelos asociativos y corporativos, se excluye el segmento individual que representa la mayoría del universo censal.

```sql individual_weight
SELECT 
    COUNT(*) FILTER (WHERE operational_structure = 'individual') * 100.0 / COUNT(*) AS weight
FROM farm_profiles
```

<Grid cols={1}>
    <BigValue 
        data={individual_weight} 
        value=weight 
        title="Peso de la Categoría Individual" 
        fmt='num1'
        suffix="%"
    />
</Grid>

<Alert status="info">
  <b>Nota de Escala:</b> Se ha excluido la categoría "Individual" de la visualización inferior para permitir la comparación efectiva de los modelos asociativos y empresariales, los cuales de otro modo quedarían ocultos por la magnitud del sector minifundista.
</Alert>

```sql operational_long_tail
SELECT 
    operational_structure AS Estructura,
    COUNT(*) AS Total,
    COUNT(*) * 100.0 / SUM(COUNT(*)) OVER() AS Porcentaje
FROM farm_profiles
WHERE operational_structure != 'individual' 
GROUP BY 1
ORDER BY Total DESC;
```

<BarChart
    data={operational_long_tail}
    x=Estructura
    y=Porcentaje
    title="Distribución de No Individuales"
    swapXY=true
    fillColor="#85c7c6"
/>

<Details title="Interpretación: La Larga Cola de la Organización Rural">
  Al omitir el ruido estadístico de la categoría dominante, observamos que las Cooperativas y los Colectivos Familiares emergen como las formas de organización más prevalentes después del productor independiente. Esta distinción es crítica para el análisis de crédito: mientras que el productor individual suele depender de financiamiento informal, las Empresas y Cooperativas registradas en el censo muestran una mayor interacción con el sistema bancario formal (Banco Produzcamos) y ONGs.
</Details>


---

## 4. Estructura Operacional y Tenencia
Esta sección analiza la naturaleza jurídica de las unidades productivas. Diferenciar entre la gestión individual y modelos organizados es vital, ya que la personería jurídica es el principal predictor del acceso al crédito formal y la estabilidad del empleo[cite: 1].
```sql operational_stats
SELECT 
    operational_structure AS estructura,
    COUNT(*) AS total,
    AVG(total_area_mz) as avg_size,
    SUM(permanent_workers_total) as permanent_jobs,
    COUNT(*) * 100.0 / SUM(COUNT(*)) OVER() AS Porcentaje_Relativo
FROM farm_profiles
LEFT JOIN farm_labor ON farm_profiles.farm_uid = farm_labor.farm_uid
WHERE operational_structure != 'individual' AND operational_structure != 'ignorado'
GROUP BY 1
ORDER BY Total DESC;
```

<Grid cols={2}>
    <BigValue 
        data={individual_weight} 
        value=weight 
        title="Predominancia Individual" 
        subtitle="Productores independientes (Base del Censo)"
        fmt='num1'
        suffix="%"
    />
    <BigValue 
        data={operational_stats} 
        value=total 
        agg="sum"
        title="Unidades Organizadas" 
        subtitle="Empresas, Cooperativas y Colectivos"
        fmt='num0'
    />
</Grid>

<Tabs>
    <Tab label="Frecuencia por Modelo">
        <BarChart 
            data={operational_stats} 
            x=estructura 
            y=total 
            title="Conteo de Unidades Asociativas y Corporativas"
            swapXY=true
            fillColor="#85c7c6"
        />
    </Tab>
    <Tab label="Escala y Tamaño (Mz)">
        <BarChart 
            data={operational_stats} 
            x=estructura 
            y=avg_size 
            title="Superficie Promedio por Tipo de Estructura"
            swapXY=true
            fillColor="#d2c6ac"
            yAxisTitle="Promedio de Manzanas (Mz)"
        />
    </Tab>
</Tabs>

<Details title="Análisis de Tenencia y Gestión">
Mientras que el <b>98%</b> de las unidades operan bajo gestión individual dentro del sector minifundista, la "larga cola" de estructuras organizadas revela datos críticos para la política pública. Las <b>Cooperativas y Colectivos</b> representan el segundo bloque de organización más importante, funcionando como núcleos de agregación para pequeños productores, mientras que las <b>Empresas y la Administración Pública</b>, aunque minoritarias en conteo, presentan los mayores promedios de área y son las principales generadoras de empleo permanente estable. Finalmente, las <b>Comunidades Indígenas</b> reflejan modelos de tenencia colectiva con lógicas de diversificación de cultivos que difieren de la propiedad privada tradicional.
</Details>

---

## 5. Estructura Global de Uso de Suelo
Composición agregada de las tierras agropecuarias censadas. Esta línea base es fundamental para el posterior cálculo del Índice de Diversificación y Ratio Pasto-Cultivo.
```sql land_use_macro
UNPIVOT (
    SELECT 
        SUM(mz_annual_crops) AS "Cultivos Anuales",
        SUM(mz_permanent_crops) AS "Cultivos Permanentes",
        SUM(mz_cultivated_pasture) AS "Pasto Cultivado",
        SUM(mz_natural_pasture) AS "Pasto Natural",
        SUM(mz_forest) AS "Bosque",
        SUM(mz_fallow) AS "Descanso/Tacotal"
    FROM farm_land_use
)
ON "Cultivos Anuales", "Cultivos Permanentes", "Pasto Cultivado", "Pasto Natural", "Bosque", "Descanso/Tacotal"
INTO
    NAME Categoria
    VALUE Total_Manzanas;
```

<BarChart
    data={land_use_macro}
    x=Categoria
    y=Total_Manzanas
    title="Superficie Total por Categoría de Uso"
    yAxisTitle="Manzanas (Mz)"
    sort="Total_Manzanas"
    fillColor="#46a485"
/>

---

## 6. Línea Base de Inclusión Financiera
Proporción de unidades productivas que interactúan con el ecosistema de crédito formal e informal.
```sql credit_funnel
SELECT '1. Universo Total' AS Etapa, COUNT(*) AS Fincas FROM farm_credit_access
UNION ALL
SELECT '2. Solicitaron Crédito' AS Etapa, COUNT(*) FROM farm_credit_access WHERE requested_loan = true
UNION ALL
SELECT '3. Recibieron Crédito' AS Etapa, COUNT(*) FROM farm_credit_access WHERE received_loan = true
ORDER BY Etapa ASC;
```

```sql credit_sources
UNPIVOT (
    SELECT 
        SUM(CAST(loan_banco AS INT)) AS "Banco Privado",
        SUM(CAST(loan_banco_produzcamos AS INT)) AS "Banco Produzcamos",
        SUM(CAST(loan_cooperativa AS INT)) AS "Cooperativas",
        SUM(CAST(loan_ong AS INT)) AS "ONGs",
        SUM(CAST(loan_prestamista AS INT)) AS "Prestamista Informal",
        SUM(CAST(loan_acopiador AS INT)) AS "Acopiador"
    FROM farm_credit_access
)
ON "Banco Privado", "Banco Produzcamos", "Cooperativas", "ONGs", "Prestamista Informal", "Acopiador"
INTO
    NAME Fuente
    VALUE Fincas;
```

<Grid cols=1>
    <BarChart
        data={credit_funnel}
        x=Etapa
        y=Fincas
        title="Embudo de Acceso al Crédito"
        fillColor="#f4b548"
    />
    <BarChart
        data={credit_sources}
        x=Fuente
        y=Fincas
        title="Principales Fuentes de Financiamiento"
        swapXY=true
        sort="Fincas"
        fillColor="#dc2626"
    />
</Grid>

<Details title="Nota Analítica">
  La diferencia entre "Solicitaron" y "Recibieron" representa la tasa empírica de rechazo institucional. La matriz de fuentes de financiamiento evidencia la dependencia del sector respecto a entidades no tradicionales (ONGs y Cooperativas) frente a la banca privada.
</Details>

---

## 7. Estadística Descriptiva de Intensidad
Resumen de la capacidad de absorción de mano de obra segmentada por escala productiva.
```sql farm_intensity_stats
SELECT * FROM farm_intensity_stats
```

<DataTable data={farm_intensity_stats}>
  <Column id="farm_size_class" title="Segmento de Tamaño"/>
  <Column id="avg_intensity" title="Promedio" fmt="num2"/>
  <Column id="median_intensity" title="Mediana" fmt="num2"/>
  <Column id="max_intensity" title="Máximo" fmt="num2"/>
  <Column id="farm_count" title="Total Fincas" fmt="num0"/>
</DataTable>

---




## 8. Análisis de Distribución de Intensidad (Log10)
Visualización de la densidad de trabajadores por unidad de área. La transformación logarítmica permite normalizar la asimetría extrema y observar la estructura de contratación subyacente.
```sql labor_raw
SELECT 
    farm_size_class,
    LOG10(labor_intensity + 1) AS log_intensity 
FROM farm_labor
WHERE labor_intensity > 0.0;
```

```sql size_classes
SELECT DISTINCT farm_size_class 
FROM farm_labor 
WHERE labor_intensity > 0.0
ORDER BY farm_size_class;
```

<Tabs>
{#each size_classes as category}
    <Tab label={category.farm_size_class}>
        <Histogram
            data={labor_raw.filter(d => d.farm_size_class === category.farm_size_class)}
            x=log_intensity
            title="Distribución Log10: {category.farm_size_class}"
            xAxisTitle="Log10(Trabajadores/Mz + 1)"
            bins={15}
            fillColor="#236aa4"
        />
        
        <Details title="Nota de Interpretación: {category.farm_size_class}">
            {#if category.farm_size_class === 'Small'}
                El segmento <b>Small</b> tiende a una distribución log-normal (forma de campana), indicando una mayor estabilidad en la absorción de mano de obra por unidad de área.
            {:else}
                Los segmentos <b>Medium/Large</b> muestran una asimetría hacia la izquierda (cola inferior), reflejando un modelo de producción más extensivo o con mayor grado de mecanización.
            {/if}
        </Details>
    </Tab>
{/each}
</Tabs>




