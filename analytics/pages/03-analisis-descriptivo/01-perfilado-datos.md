## Integridad Estructural

```sql integrity
SELECT * FROM warehouse.integrity;
```
<Grid cols=3>
    <BigValue 
      data={integrity} 
      value=total_rows
      title="Total de Explotaciones" 
      fmt="num0"
    />
    <BigValue 
      data={integrity} 
      value=unique_farms 
      title="Explotaciones unicas" 
      fmt="num0"
    />
    <BigValue 
      data={integrity} 
      value=potential_duplicates 
      title="Duplicados" 
      fmt="num0"
    />
</Grid>

## Casos Límite y Anomalías

```sql anomalies
SELECT * FROM warehouse.anomalies;
```

<DataTable data={anomalies} search=true/>



## Intensidad laboral
```sql farm_intensity_stats
SELECT * FROM warehouse.farm_intensity_stats
```

<DataTable data={farm_intensity_stats}>
  <Column id="size_group" title="Segmento"/>
  <Column id="avg_intensity" title="Intensidad Promedio" fmt="num2"/>
  <Column id="median_intensity" title="Intensidad Mediana" fmt="num2"/>
  <Column id="max_intensity" title="Intensidad Maxima" fmt="num2"/>
  <Column id="farm_count" title="Total Fincas" fmt="num0"/>
</DataTable>



## Intensidad laboral
```sql labor_intensity
SELECT LOG10(labor_intensity + 1) AS log_intensity FROM warehouse.farm_labor
WHERE farm_size_class = 'Small' AND labor_intensity > 0.0; 
```

<Histogram
    data={labor_intensity}
    x=log_intensity
    title="Distribución de Intensidad Laboral (Log10)"
    xAxisTitle="Log10(Trabajadores por Mz + 1)"
    bins={10} 
/>