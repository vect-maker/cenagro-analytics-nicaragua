# Perfilado y Calidad de Datos

Este apartado documenta el estado de integridad del censo y la distribución de las métricas clave tras el proceso de transformación ETL.

<Alert status="info">
  <b>Nota Metodológica:</b> La Intensidad Laboral se calcula exclusivamente para explotaciones mayores a 1 Manzana (Mz) para evitar sesgos por infraestructura en explotaciones de patio (Backyard/Micro).
</Alert>

---

## 1. Intensidad Laboral (Productividad Marginal)
La intensidad laboral mide cuántos trabajadores se contratan por cada manzana (Mz) de tierra. Debido a que la mayoría de las fincas en Nicaragua son pequeñas y unas pocas propiedades gigantes concentran casi toda la tierra, los datos están muy desequilibrados (sesgados). Usamos una escala logarítmica para ajustar estos valores en los gráficos. Esto asegura que los patrones de las fincas pequeñas sigan siendo visibles y no queden ocultos por las cifras enormes de los grandes terrenos.

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


---

## 3. Perfil Demográfico y Vocación Productiva
Distribución de la titularidad de las explotaciones y la naturaleza de las actividades económicas declaradas.
```sql gender_dist
SELECT 
    producer_gender AS Genero, 
    COUNT(*) AS Total,
    COUNT(*) * 1.0 / SUM(COUNT(*)) OVER() AS Porcentaje
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
<Tabs>
    <Tab label="Género del Productor">
       <BarChart
            data={gender_dist} x=Genero y=Porcentaje
            title="Distribución por Género" yAxisTitle="% de Fincas"
            swapXY=true fillColor="#8dacbf" labels=true yFmt="pct1"
        />
    </Tab>
    <Tab label="Actividad Principal">
       <BarChart
            data={activity_dist} x=Actividad y=Fincas
            title="Top 8 Actividades Principales" yAxisTitle="Número de Fincas"
            swapXY=true fillColor="#236aa4" labels=true yFmt="num0"
        />
    </Tab>
</Tabs>

<Details title="Nota Analítica: Brecha de Género y Autoconsumo">
  <b>Evidencia:</b> Los hombres dirigen el <b>76.3%</b> de las fincas, frente a solo un <b>23.2%</b> dirigido por mujeres. Además, la mayoría produce solo para sobrevivir: <b>138,316 fincas</b> se dedican al <b>autoconsumo</b>, muy por encima de las que venden al mercado interno (51,153) o exportan (17,219).
  <br/><br/>
  <b>Implicación:</b> El sector agrario produce poco dinero y tiene una fuerte desigualdad entre hombres y mujeres. Los bancos y financieras necesitan crear créditos especiales que ayuden a las mujeres productoras y que se adapten a las fincas que no generan ganancias comerciales directas.
</Details>

### Detalle de Estructuras Organizadas
Para observar la distribución entre modelos asociativos y corporativos, se excluye el segmento individual que representa la mayoría del universo censal.

```sql individual_weight
SELECT 
    COUNT(*) FILTER (WHERE operational_structure = 'individual') * 100.0 / COUNT(*) AS weight
FROM farm_profiles
```

<Alert status="info">
  <b>Nota de Escala:</b> Se ha excluido la categoría "Individual" de la visualización inferior para permitir la comparación efectiva de los modelos asociativos y empresariales, los cuales de otro modo quedarían ocultos por la magnitud del sector minifundista.
</Alert>

```sql operational_long_tail
SELECT 
    operational_structure AS Estructura,
    COUNT(*) AS Total,
    COUNT(*) * 1.0 / SUM(COUNT(*)) OVER() AS Porcentaje
FROM farm_profiles
WHERE operational_structure != 'individual' 
GROUP BY 1
ORDER BY Total DESC;
```

<BarChart
    data={operational_long_tail} x=Estructura y=Porcentaje
    title="Distribución de No Individuales"
    swapXY=true fillColor="#85c7c6" labels=true yFmt="pct1"
/>

<Details title="Nota Analítica: La Larga Cola de la Organización Asociativa">
  <b>Evidencia:</b> Al aislar el ruido estadístico de la categoría dominante (Individual), las Cooperativas y los Colectivos Familiares emergen gráficamente como las formas de organización secundaria más prevalentes.
  <br/><br/>
  <b>Implicación:</b> Esta distinción es crítica para perfilar el riesgo. Mientras que el productor individual suele depender de redes informales, estas estructuras organizadas fungen como vehículos de agregación que facilitan el acceso al sistema bancario formal.
</Details>


---

## 4. Estructura Operacional y Tenencia
Esta sección analiza la naturaleza jurídica de las unidades productivas. Diferenciar entre la gestión individual y modelos organizados es vital, ya que la personería jurídica es el principal predictor del acceso al crédito formal y la estabilidad del empleo.

```sql individual_weight
SELECT 
    COUNT(*) FILTER (WHERE operational_structure = 'individual') * 1.0 / COUNT(*) AS weight
FROM farm_profiles;
```

```sql individual_count
SELECT 
    COUNT(*) AS count
FROM farm_profiles
WHERE operational_structure = 'individual';
```

```sql total_organizadas
SELECT 
    COUNT(*) AS total
FROM farm_profiles
WHERE operational_structure != 'individual' AND operational_structure != 'ignorado';
```



<Grid cols={3}>
    <BigValue 
        data={individual_weight} 
        value=weight 
        title="Predominancia Individual" 
        subtitle="Productores independientes (Base del Censo)"
        fmt="pct1"
    />
    <BigValue 
        data={individual_count} 
        value=count 
        title="Total de individuales" 
        subtitle="Productores independientes (Base del Censo)"
        fmt="num0"
    />
    <BigValue 
        data={total_organizadas} 
        value=total 
        title="Unidades Organizadas" 
        subtitle="Empresas, Cooperativas y Colectivos"
        fmt="num0"
    />
</Grid>


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

<Tabs>
    <Tab label="Frecuencia por Modelo">
        <BarChart 
            data={operational_stats} x=estructura y=total 
            title="Conteo de Unidades Asociativas y Corporativas"
            swapXY=true fillColor="#85c7c6" labels=true yFmt="num0"
        />
    </Tab>
    <Tab label="Escala y Tamaño (Mz)">
        <BarChart 
            data={operational_stats} x=estructura y=avg_size 
            title="Superficie Promedio por Tipo de Estructura"
            swapXY=true fillColor="#d2c6ac" yAxisTitle="Promedio de Manzanas (Mz)"
            labels=true yFmt="num0" 
        />
    </Tab>
</Tabs>

<Details title="Nota Analítica: La Larga Cola de la Organización Asociativa y Corporativa">
  <b>Evidencia:</b> Al aislar la categoría dominante (Individual), los <b>Colectivos Familiares (470)</b>, las <b>Empresas (297)</b> y las <b>Cooperativas (262)</b> emergen como las formas de organización secundaria más prevalentes.
  <br/><br/>
  <b>Implicación:</b> Esta distinción es crítica para perfilar el riesgo. Mientras que el productor individual suele depender de redes informales, las figuras corporativas (empresas) y asociativas (cooperativas) actúan como vehículos formales que cumplen más fácilmente con los requisitos fiduciarios del sistema bancario tradicional.
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
    data={land_use_macro} x=Categoria y=Total_Manzanas
    title="Superficie Total por Categoría de Uso"
    yAxisTitle="Mz" sort="Total_Manzanas"
    fillColor="#46a485" labels=true yFmt="num0"
/>
<Details title="Nota Analítica: Asimetría Estructural hacia la Ganadería Extensiva">
  <b>Evidencia:</b> El balance de tierras expone que las áreas destinadas a pastos (naturales y cultivados, ~4.6M Mz) triplican la superficie dedicada a la agricultura de cultivos anuales y permanentes (~1.55M Mz).
  <br/><br/>
  <b>Implicación:</b> Esta es nuestra línea base principal de diversificación. Dado que la ganadería tradicional domina el paisaje.
</Details>

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

<Tabs>
    <Tab label="Acceso a credito">
           <BarChart
        data={credit_funnel}
        x=Etapa
        y=Fincas
        title="Embudo de Acceso al Crédito"
        fillColor="#f4b548"
          labels=true 
          yFmt="num0"
    />
    </Tab>
    <Tab label="Fuentes de financiamiento">
           <BarChart
        data={credit_sources}
        x=Fuente
        y=Fincas
        title="Principales Fuentes de Financiamiento"
        swapXY=true
        sort="Fincas"
        fillColor="#dc2626"
          labels=true 
          yFmt="num0"
    />
    </Tab>
</Tabs>

<Details title="Nota Analítica: Baja Penetración y Dominio de la Banca Privada">
  <b>Evidencia:</b> El embudo revela que el verdadero cuello de botella es la baja demanda: solo 41,756 fincas (~15.9%) solicitaron financiamiento. Sin embargo, la tasa de aprobación es altísima (~92.6%), con 38,680 créditos desembolsados. Paralelamente, la matriz de origen confirma que la <b>banca privada (18,255)</b> es el proveedor líder absoluto, duplicando casi el alcance de las Cooperativas (9,793) y superando ampliamente a las ONGs (2,662).
  <br/><br/>
  <b>Implicación:</b> El problema estructural no es el "rechazo bancario", sino las barreras de entrada previas a la solicitud (falta de garantías, autoexclusión o aislamiento). Además, el apalancamiento agrario nicaragüense depende primariamente de la banca comercial formal, refutando la hipótesis de una dependencia mayoritaria hacia el sector asociativo o informal.
</Details>
