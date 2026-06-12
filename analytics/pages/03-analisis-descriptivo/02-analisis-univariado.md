# Analisis univariado

Este apartado constituye la fase diagnóstica del análisis, donde se caracterizan las unidades productivas a través de sus dimensiones fundamentales: productividad marginal, calidad del empleo, complejidad técnica y vocación económica. Dado que los datos agrarios de Nicaragua presentan una asimetría extrema (distribuciones de potencia), aquí se aplican técnicas de normalización Log10 y segmentación por deciles para estabilizar la varianza. El resultado de este análisis univariado provee el contexto estructural necesario para determinar, en fases posteriores, si el acceso al crédito actúa como un catalizador de cambio o si las fincas permanecen ancladas en modelos de subsistencia y baja tecnificación.

---

## 1. Distribución de la Intensidad Laboral (Labor Intensity Log10)
Visualización de la densidad de trabajadores por unidad de área. La transformación logarítmica permite normalizar la asimetría extrema y observar la estructura de contratación.

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
                <b>Evidencia:</b> La distribución aproxima una curva log-normal canónica con la moda estadística centrada en el rango [0.30, 0.35].
                <br/><br/>
                <b>Implicación:</b> El segmento obedece a un patrón estandarizado y resiliente de absorción laboral, indicando un nivel base de intensidad manual inelástico.
            {:else}
                <b>Evidencia:</b> Presenta una asimetría extrema hacia la derecha (Positive Skew), con el máximo de densidad (33,729 fincas) anclado en el límite inferior [0.00, 0.05] y una pronunciada decadencia exponencial.
                <br/><br/>
                <b>Implicación:</b> Confirma empíricamente la presencia de economías de escala estructurales, donde la consolidación territorial o tracción mecanizada reducen asintóticamente la dependencia de densidad laboral.
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
  <b>Evidencia:</b> La mediana de intensidad laboral y los valores máximos absolutos disminuyen drásticamente conforme aumenta el tamaño de la finca. El segmento <b>Small</b> concentra los valores atípicos más extremos (log_max de 2.03, máximo absoluto de ~106 trabajadores/Mz) y las medianas más altas (1.33). En cambio, las fincas <b>Medium/Large</b> presentan una caja intercuartílica (IQR) considerablemente más baja y compacta (mediana de 0.15).
  <br/><br/>
  <b>Implicación:</b> Esto confirma empíricamente la presencia de economías de escala estructurales. Las operaciones de mayor tamaño optimizan su densidad laboral mediante tracción mecanizada o modelos de extensificación pecuaria, reduciendo asintóticamente la dependencia manual. En contraste, los minifundios (Small) absorben la fuerza laboral de forma intensiva y asimétrica.
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

<Details title="Nota Analítica: Polarización y Dependencia de Trabajo Temporal">
  <b>Evidencia:</b> Los datos muestran una distribución bimodal extrema. El <b>63.7%</b> de las fincas medianas/grandes y el <b>82.5%</b> de las pequeñas operan exclusivamente con mano de obra temporal (ratio 0.0). Existe un segundo pico menor de fincas que contratan personal 100% permanente (ratio 1.0), pero casi no hay fincas en los niveles intermedios.
  <br/><br/>
  <b>Implicación:</b> El empleo agrícola en Nicaragua es estructuralmente inestable. Las fincas no formalizan a sus trabajadores de forma gradual; operan por temporadas o tienen planillas fijas completas. El análisis evaluará si el acceso al crédito logra empujar a las fincas del extremo temporal (0.0) hacia la estabilidad permanente (1.0).
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

<Details title="Nota Analítica: Predominancia de Sistemas con Baja Complejidad">
  <b>Evidencia:</b> La mayoría de las fincas operan con poca variedad de cultivos o pastos. El <b>57.13%</b> reporta entre 1 y 3 rubros, siendo 2 rubros la configuración más común (<b>24.67%</b>). Por el contrario, la diversificación extrema (7 a 8 rubros) es mínima y representa menos del <b>5%</b> del total censado.
  <br/><br/>
  <b>Implicación:</b> El modelo de producción base es especializado o poco variado. Este indicador servirá para comprobar si el financiamiento impulsa a los productores a diversificar sus tierras e integrar nuevos rubros para protegerse de los riesgos del clima y el mercado.
</Details>

---

## 4. Vocación Económica (Pasture-to-Crop Ratio)

Esta métrica categoriza a las unidades productivas según su balance entre la extensificación pecuaria y la intensificación agrícola. Al discretizar el ratio continuo, se eliminan los sesgos por valores atípicos y se facilita la comparación de modelos de negocio divergentes.

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

<Details title="Nota Analítica: El Contraste entre la Tierra y la Cantidad de Fincas">
  <b>Evidencia:</b> Existe un gran contraste entre el uso del suelo y la cantidad de productores. Aunque los pastos ocupan la mayor parte del país (~4.6M Mz), la gráfica muestra que la mayoría de las unidades productivas se dedican exclusivamente a la agricultura (<b>Pure Agriculture</b> con 108,659 fincas). Por el contrario, las fincas dedicadas solo a la ganadería (<b>Pure Livestock</b>) son una minoría (15,511 fincas).
  <br/><br/>
  <b>Implicación:</b> El sistema financiero enfrenta un reto doble. Para llegar a más personas y tener un verdadero impacto social, el crédito debe enfocarse en esa inmensa base de pequeños agricultores (para comprar semillas e insumos). Sin embargo, como la mayor parte de la tierra física está concentrada en la ganadería, se necesitan créditos diferentes para transformar esos grandes pastizales en sistemas más eficientes y modernos.
</Details>