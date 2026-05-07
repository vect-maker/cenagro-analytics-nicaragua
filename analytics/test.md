
## 1. Generación de Empleo y Absorción Laboral

Para medir el impacto real del crédito en la generación de empleo, utilizamos la **Mediana de Intensidad Laboral** (trabajadores por manzana). Se segmenta por `farm_size_class` para controlar el sesgo de las economías de escala y evitar que los minifundios distorsionen la comparación.

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
    fillColor={['#236aa4', '#8dacbf']}
    labels=true
/>

### Brecha de Intensidad Relativa (Delta)
La siguiente tabla cuantifica el incremento porcentual exacto en la absorción de mano de obra atribuible al financiamiento.

```sql intensity_delta
SELECT 
    farm_size_class AS "Tamaño de Finca",
    MAX(CASE WHEN grupo = 'Financiadas' THEN median_intensity END) AS "Mediana Financiadas",
    MAX(CASE WHEN grupo = 'No Financiadas' THEN median_intensity END) AS "Mediana No Financiadas",
    (MAX(CASE WHEN grupo = 'Financiadas' THEN median_intensity END) - MAX(CASE WHEN grupo = 'No Financiadas' THEN median_intensity END)) / NULLIF(MAX(CASE WHEN grupo = 'No Financiadas' THEN median_intensity END), 0) AS "Brecha Relativa"
FROM agg_intensity_gap
GROUP BY 1
ORDER BY 
    CASE farm_size_class 
        WHEN 'Micro' THEN 1 
        WHEN 'Small' THEN 2 
        WHEN 'Medium/Large' THEN 3 
    END;
```

<DataTable data={intensity_delta}>
  <Column id="Tamaño de Finca" />
  <Column id="Mediana Financiadas" fmt="num2" />
  <Column id="Mediana No Financiadas" fmt="num2" />
  <Column id="Brecha Relativa" fmt="pct1" color={intensity_delta[0]['Brecha Relativa'] > 0 ? 'green' : 'red'} />
</DataTable>

<Details title="Nota Analítica: El Efecto del Financiamiento en la Absorción Laboral">
  <b>Evidencia:</b> Observe la columna "Brecha Relativa". Si los valores son positivos y significativos, indica que el grupo financiado contrata sistemáticamente más personal por manzana que su contraparte en el mismo estrato de tamaño.
  <br/><br/>
  <b>Implicación:</b> El financiamiento no solo sirve para capital de trabajo pasivo, sino que se traduce directamente en una mayor demanda de fuerza laboral, impactando el mercado de empleo rural.
</Details>
