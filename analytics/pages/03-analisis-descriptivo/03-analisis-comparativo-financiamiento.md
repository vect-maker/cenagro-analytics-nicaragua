
# Análisis Comparativo del Financiamiento
Esta sección ejecuta el **A/B Testing Transversal** central de la investigación. Se aísla el impacto socioeconómico del crédito agrícola dividiendo el universo censal en dos cohortes definitivas (Financiadas vs. No Financiadas), utilizando la variable `received_loan` como clave de partición principal para evaluar las brechas relativas en generación de empleo y diversificación productiva.

```sql agg_group_sizing
SELECT * FROM agg_group_sizing
```

<Grid cols={2}>
    <BigValue 
        data={agg_group_sizing.filter(d => d.cohort === 'Financed')} 
        value=total_farms 
        title="Grupo A: Financiadas" 
        fmt="num0"
    />
    <BigValue 
        data={agg_group_sizing.filter(d => d.cohort === 'Non-Financed')} 
        value=total_farms 
        title="Grupo B: No Financiadas" 
        fmt="num0"
    />
</Grid>

---


## 1. Generación de Empleo y Absorción Laboral

Para medir el impacto real del crédito en la generación de empleo, utilizamos la Mediana de Intensidad Laboral (trabajadores por manzana). Se segmenta por `farm_size_class` para controlar el sesgo de las economías de escala y evitar que los minifundios distorsionen la comparación.

```sql agg_intensity_gap
SELECT 
    farm_size_class,
    CASE WHEN received_loan THEN 'Financiadas' ELSE 'No Financiadas' END AS grupo,
    median_intensity
FROM agg_intensity_gap
```

<BarChart
    data={agg_intensity_gap}
    x=farm_size_class
    y=median_intensity
    series=grupo
    type=grouped
    title="Intensidad Laboral Mediana por Escala y Acceso a Crédito"
    yAxisTitle="Trabajadores por Manzana"
    colorPalette={['#5ba423', '#d5d75e']}
    labels=true
    yMax=2
/>

## 2. Calidad y Estabilidad del Empleo (Formalización)
Más allá del volumen absoluto de contrataciones, es crítico evaluar la calidad del empleo generado. Esta métrica analiza si la inyección de capital permite a las unidades productivas transitar de un modelo dependiente de mano de obra puramente estacional (ratio 0.0) hacia estructuras de contratación permanentes y estables (ratio 1.0).

```sql job_quality_relative
WITH totales_grupo AS (
    SELECT 
        received_loan, 
        SUM(frequency) as total_cohort
    FROM agg_job_quality_shift
    GROUP BY 1
)
SELECT 
    a.ratio_bin,
    CASE WHEN a.received_loan THEN 'Financiadas' ELSE 'No Financiadas' END AS grupo,
    (a.frequency * 1.0 / t.total_cohort) AS pct_relativo
FROM agg_job_quality_shift a
JOIN totales_grupo t ON a.received_loan = t.received_loan
ORDER BY a.ratio_bin, grupo;
```

<BarChart
    data={job_quality_relative}
    x=ratio_bin
    y=pct_relativo
    series=grupo
    type=stacked
    title="Distribución de la Estabilidad Laboral (Proporción Relativa)"
    xAxisTitle="Ratio de Trabajo Permanente (0 = Estacional, 1 = Permanente)"
    yAxisTitle="% de Fincas en el Grupo"
    yFmt="pct1"
    colorPalette={['#5ba423', '#d5d75e']}
/>

<Details title="Nota Analítica: Distribución Estructural de la Temporalidad Laboral">
  <b>Evidencia:</b> La distribución se concentra masivamente en el extremo estacional (ratio 0.0). El <b>72.5%</b> de las unidades financiadas operan exclusivamente con trabajadores temporales, superando al <b>68.3%</b> del grupo no financiado. Inversamente, la consolidación de planillas 100% permanentes (ratio 1.0) es del doble en fincas sin crédito (<b>12.0%</b> vs <b>5.8%</b>).
  <br/><br/>
  <b>Implicación:</b> Contrario a la hipótesis de formalización inmediata, el modelo A/B demuestra empíricamente que la inyección de liquidez se destina a financiar <b>picos de demanda estacional</b> (ej. periodos críticos de siembra o cosecha). El apalancamiento actúa como un multiplicador del <i>volumen</i> absoluto de contratación, pero no altera la dependencia estructural del ecosistema hacia la fuerza laboral transitoria.
</Details>

## 3. Complejidad Productiva (Diversificación Horizontal)

El indice de Diversificación mide el número de rubros (pastos, cultivos anuales, etc.) presentes en una explotación. Evalúa si el capital inyectado promueve el policultivo como mecanismo de mitigación de riesgo frente a la volatilidad climática y de mercado.

```sql diversification_relative
WITH totales_grupo AS (
    SELECT 
        received_loan, 
        SUM(total_farms) as total_cohort
    FROM agg_diversification_shift
    GROUP BY 1
)
SELECT 
    a.index_score,
    CASE WHEN a.received_loan THEN 'Financiadas' ELSE 'No Financiadas' END AS grupo,
    (a.total_farms * 1.0 / t.total_cohort) AS pct_relativo
FROM agg_diversification_shift a
JOIN totales_grupo t ON a.received_loan = t.received_loan
ORDER BY a.index_score, grupo;
```

<AreaChart
    data={diversification_relative}
    x=index_score
    y=pct_relativo
    series=grupo
    title="Densidad de Complejidad Productiva (Distribución Normalizada)"
    xAxisTitle="Puntaje del Índice de Diversificación (1-8 Rubros)"
    yAxisTitle="% de Fincas en el Grupo"
    yFmt="pct1"
    colorPalette={['#5ba423', '#d5d75e']}
    opacity=0.6
/>

<Details title="Nota Analítica: Desplazamiento hacia el Policultivo">
  <b>Evidencia:</b> Al superponer las áreas relativas, observamos la forma de la distribución. Si el "pico" (moda) del grupo Financiado está desplazado hacia la derecha (índices 3 o mayores) en comparación con el grupo No Financiado, demuestra empíricamente una mayor diversidad.
  <br/><br/>
  <b>Implicación:</b> Esto sugeriría que el apalancamiento financiero facilita la barrera de entrada de nuevos cultivos, rompiendo la tendencia de dependencia hacia un único rubro principal (monocultivo o solo ganadería).
</Details>

## 4. Transición de Vocación Económica (Intensificación)

Esta sección evalúa si el acceso a capital rompe la **trampa de la extensificación** ganadera, incentivando una transición hacia la agricultura de alto rendimiento (cultivos permanentes) en lugar de mantener tierras ociosas como pastos naturales.

<Alert status="info">
  <b>Interpretación del Ratio Pasto-Cultivo:</b> Un valor menor a 1.0 indica dominio agrícola (intensificación). Un valor mayor a 1.0 señala dominio ganadero. Un descenso de este ratio en el grupo financiado confirmaría una transición hacia la intensificación.
</Alert>

```sql vocation_kpis
SELECT 
    CASE WHEN received_loan THEN 'Financiadas' ELSE 'No Financiadas' END AS grupo,
    avg_pasture_to_crop_ratio
FROM agg_vocation_shift
ORDER BY grupo;
```

```sql vocation_unpivot
UNPIVOT (
    SELECT 
        CASE WHEN received_loan THEN 'Financiadas' ELSE 'No Financiadas' END AS grupo,
        avg_ratio_permanent_crops AS "Cultivos Permanentes",
        avg_ratio_natural_pasture AS "Pasto Natural"
    FROM agg_vocation_shift
)
ON "Cultivos Permanentes", "Pasto Natural"
INTO
    NAME rubro
    VALUE proporcion;
```

### Contraste del Ratio Pasto-Cultivo
<Grid cols={2}>
    <BigValue 
        data={vocation_kpis.filter(d => d.grupo === 'Financiadas')} 
        value=avg_pasture_to_crop_ratio 
        title="Ratio (Financiadas)" 
        fmt="num2"
    />
    <BigValue 
        data={vocation_kpis.filter(d => d.grupo === 'No Financiadas')} 
        value=avg_pasture_to_crop_ratio 
        title="Ratio (No Financiadas)" 
        fmt="num2"
    />
</Grid>

### Composición del Suelo Promedio
<BarChart
    data={vocation_unpivot}
    x=rubro
    y=proporcion
    series=grupo
    type=grouped
    swapXY=true
    title="Proporción del Área Destinada a Cultivos vs. Pasturas Naturales"
    xAxisTitle="Proporción del Área Total"
    yAxisTitle="Rubro de Uso de Suelo"
    yFmt="pct1"
    colorPalette={['#5ba423', '#d5d75e']}
/>

<Details title="Nota Analítica: El Apalancamiento hacia la Intensificación">
  <b>Evidencia:</b> Observe si la barra verde oscuro (Financiadas) es mayor en "Cultivos Permanentes" y menor en "Pasto Natural". Adicionalmente, el KPI del Ratio Pasto-Cultivo debería ser más bajo en la cohorte financiada.
  <br/><br/>
  <b>Implicación:</b> Si los datos lo confirman, el financiamiento actúa como una barrera contra la deforestación y la ganadería extensiva ineficiente, dotando al productor de los recursos necesarios para invertir en rubros perennes de ciclo largo (café, cacao, frutales).
</Details>
