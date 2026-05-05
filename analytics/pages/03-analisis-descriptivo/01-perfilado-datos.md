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
```sql labor_intensity
SELECT LOG10(labor_intensity + 1) AS log_intensity FROM warehouse.farm_labor
WHERE labor_intensity > 0 
  AND labor_intensity <= 30; 
```

<Histogram
    data={labor_intensity}
    x=log_intensity
/>