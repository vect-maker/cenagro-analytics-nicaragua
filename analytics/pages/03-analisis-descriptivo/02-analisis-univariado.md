# Analisis univariado

Este apartado constituye la fase diagnóstica del análisis, donde se caracterizan las unidades productivas a través de sus dimensiones fundamentales: productividad marginal, calidad del empleo, complejidad técnica y vocación económica. Dado que los datos agrarios de Nicaragua presentan una asimetría extrema (distribuciones de potencia), aquí se aplican técnicas de normalización Log10 y segmentación por deciles para estabilizar la varianza. El resultado de este análisis univariado provee el contexto estructural necesario para determinar, en fases posteriores, si el acceso al crédito actúa como un catalizador de cambio o si las fincas permanecen ancladas en modelos de subsistencia y baja tecnificación.

---

## 1. Distribución de la Intensidad Laboral (Labor Intensity Log10)
Visualización de la densidad de trabajadores por unidad de área. La transformación logarítmica permite normalizar la asimetría extrema y observar la estructura de contratación subyacente.

<Alert status="info">
  <b>Nota sobre la Escala Log10:</b> 
  Para normalizar la visualización, aplicamos la transformación: log10(Intensidad + 1).
  <ul>
    <li><b>0.0:</b> Fincas con bajísima densidad o sin trabajadores externos.</li>
    <li><b>0.3:</b> Aproximadamente 1 trabajador por manzana.</li>
    <li><b>1.0:</b> 9 trabajadores por manzana (Alta intensidad).</li>
  </ul>
</Alert>


```sql labor_binned
SELECT 
    *,
FROM agg_labor_hist_by_size
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
          <BarChart
            data={labor_binned.filter(d => d.farm_size_class === category.farm_size_class)}
            x=bin_end
            y=frequency
            title="Distribución Log10: {category.farm_size_class}"
            xAxisTitle="Rango Log10(Trabajadores/Mz + 1)"
            yAxisTitle="Frecuencia"
            fillColor="#236aa4"
            sort="bin_start" 
            yFmt="num0"
        />
        
         <Details title="Nota Analítica: Comportamiento de Distribución en Segmento {category.farm_size_class}">
            {#if category.farm_size_class === 'Small'}
                <b>Evidencia:</b> El segmento Small tiende a dibujar una distribución log-normal (forma de campana) en la gráfica.
                <br/><br/>
                <b>Implicación:</b> Esto indica un patrón de contratación altamente estandarizado y estable en la absorción de mano de obra por manzana dentro de las fincas de menor escala.
            {:else}
                <b>Evidencia:</b> Los segmentos Medium y Large muestran un marcado sesgo o asimetría hacia la izquierda (cola inferior extendida).
                <br/><br/>
                <b>Implicación:</b> Refleja la transición hacia modelos de economía de escala, donde la producción extensiva o la inserción de tracción mecanizada (tractores) reduce drásticamente la densidad de trabajadores manuales requeridos por manzana.
            {/if}
        </Details>
        
    </Tab>
{/each}
</Tabs>



### Estadística Descriptiva de Intensidad
Resumen de la capacidad de absorción de mano de obra segmentada por escala productiva.

```sql labor_boxplot
SELECT * FROM agg_labor_boxplot
```

<BoxPlot 
    data={labor_boxplot} 
    name="farm_size_class" 
    min="log_min"
    intervalBottom="log_q1"
    midpoint="log_median"
    intervalTop="log_q3"
    max="log_max"
    title="Rango Intercuartílico y Valores Atípicos (Escala Log10)" 
    fillColor="#85c7c6"
    swapXY=true
/>

<Details title="Nota Analítica: Economías de Escala y Asimetría en Minifundios">
  <b>Evidencia:</b> La mediana de intensidad laboral y los valores máximos absolutos disminuyen conforme aumenta el tamaño de la finca. El segmento "Micro" concentra los valores atípicos más extremos (log_max de 2.69) y las medianas más altas, mientras que las fincas "Medium/Large" presentan la caja (IQR) más baja y compacta.
  <br/><br/>
  <b>Implicación:</b> Esto corrobora un fuerte efecto de economías de escala. Las fincas grandes logran operar de forma mucho más predecible y con menor mano de obra por manzana (probablemente por tracción mecanizada o vocación ganadera). En contraste, los minifundios absorben trabajo de forma desproporcionada, y su extensa "cola larga" refleja sistemas de patio hiper-intensivos.
</Details>

```sql farm_intensity_stats
SELECT * FROM farm_intensity_stats
```

<DataTable data={farm_intensity_stats}>
  <Column id="farm_size_class" title="Segmento de Tamaño"/>
  <Column id="total_farms" title="Total Fincas" fmt="num0"/>
  <Column id="avg_intensity" title="Promedio" fmt="num2"/>
  <Column id="std_dev" title="Desv. Estándar" fmt="num2"/>
  <Column id="p25" title="P25 (Q1)" fmt="num2"/>
  <Column id="median_intensity" title="Mediana (P50)" fmt="num2"/>
  <Column id="p75" title="P75 (Q3)" fmt="num2"/>
  <Column id="max_intensity" title="Máximo" fmt="num0"/>
  <Column id="asimetria" title="Asimetría" fmt="num2"/>
</DataTable>

---

## 2. Estabilidad del Empleo (Ratio de Trabajo Permanente)
Visualización de la proporción de trabajadores permanentes sobre el total de la fuerza laboral contratada. Esta métrica identifica si el empleo generado es estructural (permanente) o estacional (temporal).

```sql agg_permanent_labor_hist
SELECT * FROM agg_permanent_labor_hist
```

<BarChart
    data={agg_permanent_labor_hist}
    x=bin_end
    y=frequency
    series=farm_size_class
    title="Distribución de Estabilidad Laboral (0.0 = Temporal, 1.0 = Permanente)"
    xAxisTitle="Ratio de Trabajo Permanente"
    yAxisTitle="Número de Fincas"
    fillColor="#236aa4"
    sort="bin_start" 
    yFmt="num0"
    stack=false
/>

<Details title="Nota Analítica: Polarización y Dependencia de Mano de Obra Estacional">
  <b>Evidencia:</b> Los datos confirman una distribución fuertemente bimodal y polarizada. Entre el 63% (Medium/Large) y el 82% (Small) de las explotaciones se concentran en el bin de 0.0, indicando que operan exclusivamente con mano de obra temporal. Existe un segundo pico menor en el valor 1.0 (empleo 100% permanente), mientras que los valores intermedios (contratación mixta) son estadísticamente marginales.
  <br/><br/>
  <b>Implicación:</b> La estructura laboral agropecuaria de Nicaragua es predominantemente transitoria y estacional. La baja prevalencia de modelos mixtos sugiere que las fincas no transitan gradualmente hacia la estabilidad; el acceso al crédito será evaluado para determinar si funciona como un catalizador que logre "mover" a las fincas del extremo de temporalidad (0.0) hacia el de permanencia (1.0).
</Details>

---

## 3. Índice de Diversificación
El Índice de Diversificación cuantifica el número de categorías de uso de suelo (anuales, permanentes, pastos, bosques, etc.) presentes en una misma unidad productiva. Este indicador sirve como proxy de la resiliencia económica y la complejidad técnica del ecosistema agrario nicaragüense.

```sql agg_diversification_dist
SELECT * FROM agg_diversification_dist
```

<BarChart
    data={agg_diversification_dist}
    x=index_score
    y=total_farms
    title="Distribución de la Complejidad Productiva (Conteo de Rubros)"
    xAxisTitle="Puntaje del Índice (1-8)"
    yAxisTitle="Número de Fincas"
    fillColor="#45a1bf"
    labels=true
    yFmt="num0"
/>

<Details title="Nota Analítica: Predominancia de Sistemas de Baja Complejidad">
  <b>Evidencia:</b> La distribución revela una concentración masiva en niveles de baja complejidad; el 57.13% de las explotaciones reportan entre 1 y 3 rubros distintos, con la moda estadística situada en el indice 2 (24.67% de la muestra). Por el contrario, la diversificación extrema (índices 7-8) es un fenómeno marginal que abarca a menos del 5% del universo censado.
  <br/><br/>
  <b>Implicación:</b> El perfil productivo base es mayoritariamente especializado o de baja mixtura. Esta métrica es el "baseline" para el Objetivo 2: permitirá determinar si el financiamiento actúa como motor de complejidad horizontal, incentivando a los productores a integrar nuevos rubros para mitigar riesgos climáticos o de mercado.
</Details>

---

## 4. Vocación Económica (Pasture-to-Crop Ratio)

Esta métrica categoriza a las unidades productivas según su balance entre la **extensificación pecuaria** y la **intensificación agrícola**. Al discretizar el ratio continuo, se eliminan los sesgos por valores atípicos y se facilita la comparación de modelos de negocio divergentes.

<Alert status="info">
  <b>Lógica de Agrupación:</b> Las categorías se determinan mediante el balance de superficies de pastos (<code>mz_pasture &gt; 0</code> y <code>mz_crops = 0</code>) versus cultivos (<code>mz_crops &gt; 0</code>):
  <ul>
    <li><b>Pure Livestock:</b> <code>mz_pasture &gt; 0</code> y <code>mz_crops = 0</code>.</li>
    <li><b>Pure Agriculture:</b> <code>mz_pasture = 0</code> y <code>mz_crops &gt; 0</code>.</li>
    <li><b>Mixed - Livestock Dominant:</b> <code>Ratio &gt; 1</code> (Mayor superficie de pastos).</li>
    <li><b>Mixed - Agriculture Dominant:</b> <code>Ratio &lt; 1</code> (Mayor superficie de cultivos).</li>
  </ul>
</Alert>

```sql agg_vocation_split
SELECT * FROM agg_vocation_split
```

<BarChart 
    data={agg_vocation_split} 
    x=economic_vocation 
    y=total_farms 
    title="Vocación Económica de las Explotaciones" 
    xAxisTitle="Categoría de Vocación"
    yAxisTitle="Número de Fincas"
    labels=true 
    swapXY=true 
    fillColor="#46a485"
/>

<Details title="Nota Analítica: Predominancia de la Especialización Pecuaria">
  <b>Evidencia:</b> La estructura agraria presenta una marcada asimetría hacia la ganadería. Según el inventario de uso de suelo, las áreas de pastos (~4.6M Mz) triplican a las agrícolas (~1.55M Mz). Se observa que el grueso de la muestra se concentra en <b>Pure Livestock</b> y <b>Mixed - Livestock Dominant</b>.
  <br/><br/>
  <b>Implicación:</b> El financiamiento en este contexto enfrenta el reto de la "trampa de la extensificación". Las fincas con vocación puramente ganadera suelen demandar créditos para mantenimiento de hato, mientras que los segmentos <b>Mixed - Agriculture Dominant</b> representan los focos de mayor potencial para la intensificación tecnológica y diversificación de cultivos de alto valor.
</Details>

