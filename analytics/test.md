## 2. Impacto en la Generación y Estabilidad del Empleo (Delta Laboral)

El acceso al capital transforma radicalmente la capacidad de absorción de mano de obra del ecosistema rural. Al aislar el efecto por escala productiva, la data demuestra que la inyección de liquidez no se utiliza para automatizar y recortar personal, sino que actúa como un catalizador expansivo para la contratación.

```sql labor_intensity_kpi
SELECT * FROM agg_labor_intensity_delta;
```

<Grid cols=2>
    <BigValue 
      data={labor_intensity_kpi.filter(d => d.farm_size_class === 'Medium/Large')} 
      value=relative_gap_pct
      title="Brecha de Empleo (Medianas/Grandes)" 
      fmt="pct1"
    />
    <BigValue 
      data={labor_intensity_kpi.filter(d => d.farm_size_class === 'Small')} 
      value=relative_gap_pct
      title="Brecha de Empleo (Pequeñas)" 
      fmt="pct1"
    />
</Grid>

<Details title="Nota Analítica: El Crédito como Motor de Contratación">
  <b>Evidencia:</b> Las fincas medianas/grandes con crédito incrementan su intensidad laboral mediana en un 171.6%, y las pequeñas en un 33.3%, frente a las no financiadas.
  <br/><br/>
  <b>Implicación:</b> El apalancamiento financiero permite estabilizar contratos estacionales en empleos permanentes, rompiendo el estándar de agricultura de subsistencia.
</Details>
