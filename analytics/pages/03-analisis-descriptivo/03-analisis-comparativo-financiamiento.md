
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

<Details title="Nota Analítica: El Crédito como Multiplicador de Empleo">
  <b>Evidencia:</b> En todos los tamaños de finca, el acceso a crédito aumenta la cantidad de trabajadores por manzana. Las fincas pequeñas financiadas pasan de 1.25 a 1.66 trabajadores/Mz (un aumento del 33.3%). Las fincas medianas y grandes financiadas casi triplican su densidad laboral, saltando de 0.12 a 0.32 trabajadores/Mz (un aumento del 171.6%).
  <br/><br/>
  <b>Implicación:</b> El dinero de los préstamos no se utiliza para comprar maquinaria que reemplace a los trabajadores, sino para expandir la producción. El crédito actúa como un motor directo de contratación masiva, impactando con mayor fuerza relativa a las fincas más grandes, las cuales normalmente operan con un mínimo de personal.
</Details>

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

<Details title="Nota Analítica: El Crédito y la Mano de Obra Temporal">
  <b>Evidencia:</b> La gran mayoría de las fincas usan el crédito para contratar mano de obra temporal. El <b>72.5%</b> de las unidades financiadas operan exclusivamente con trabajadores temporales (ratio 0.0), superando al <b>68.3%</b> del grupo no financiado. Por el contrario, tener planillas 100% permanentes (ratio 1.0) es el doble de común en fincas sin crédito (<b>12.0%</b> vs <b>5.9%</b>).
  <br/><br/>
  <b>Implicación:</b> El dinero de los préstamos se usa principalmente para cubrir picos de trabajo por temporadas (como la siembra o la cosecha), no para crear empleos fijos. El financiamiento permite contratar a más personas en total, pero mantiene la dependencia del campo hacia el trabajo temporal.
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

<BarChart
    data={diversification_relative}
    x=index_score
    y=pct_relativo
    series=grupo
    type=grouped
    title="Distribución de Complejidad Productiva (Financiadas vs No Financiadas)"
    xAxisTitle="Puntaje del Índice de Diversificación (1-8 Rubros)"
    yAxisTitle="% de Fincas en el Grupo"
    yFmt="pct1"
    colorPalette={['#5ba423', '#d5d75e']}
/>

<Details title="Nota Analítica: El Crédito como Motor de Diversificación">
  <b>Evidencia:</b> La gráfica muestra un desplazamiento claro. El grupo sin crédito se concentra en sistemas de baja diversidad, con su pico estadístico en 2 rubros (25.1%). En contraste, el grupo financiado desplaza su pico productivo hacia los 3 rubros (23.7%) y mantiene una mayor proporción de fincas operando en los niveles de mayor complejidad (4, 5 y 6).
  <br/><br/>
  <b>Implicación:</b> El apalancamiento financiero sí actúa como un facilitador de la diversificación. Al inyectar liquidez, los productores logran superar la barrera de entrada requerida para sembrar nuevos cultivos o integrar ganado, rompiendo la dependencia riesgosa hacia un modelo de monocultivo o ganadería pura.
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

<Details title="Nota Analítica: Transición hacia la Intensificación Agrícola">
  <b>Evidencia:</b> Los datos confirman empíricamente el cambio de vocación productiva. Las fincas con acceso a crédito destinan el <b>22.9%</b> de su área a Cultivos Permanentes, superando por un margen sustancial el <b>13.6%</b> del grupo sin crédito. Simultáneamente, la cobertura de Pastos Naturales se reduce del <b>19.1%</b> (no financiadas) al <b>16.8%</b> (financiadas).
  <br/><br/>
  <b>Implicación:</b> El financiamiento permite romper la trampa de la ganadería extensiva. Provee la liquidez necesaria para que el productor pueda asumir los costos iniciales y el tiempo de espera biológico de los rubros perennes de alto valor (como café o cacao), impulsando la intensificación y modernización del uso del suelo.
</Details>