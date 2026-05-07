# Definiciones Metodológicas Oficiales (INIDE / MAGFOR)

Para garantizar el rigor analítico y evitar ambigüedades, los conceptos fundamentales de esta investigación se alinean estrictamente con el manual de aspectos metodológicos del CENAGRO. Estos conceptos se mapean directamente a las variables procesadas por el motor analítico.

### Explotación Agropecuaria (EA)
Constituye la unidad estadística y de observación fundamental del censo. Se define como toda extensión de tierra que se utiliza total o parcialmente para la producción agrícola, pecuaria o forestal, bajo una gerencia o administración única. 
*   **Mapeo de Datos:** En el modelo computacional, cada registro único en la tabla consolidada `farms` representa una EA.

### Financiamiento Agropecuario
Provisión de capital líquido o en especie para el desarrollo de actividades productivas. 
*   **Mapeo de Datos:** En la arquitectura de datos, este concepto se rastrea mediante la matriz de demanda y acceso (`requested_loan`, `received_loan`) y se clasifica según su origen en formal (ej. `loan_banco`, `loan_cooperativa`, `loan_gobierno`) o informal (ej. `loan_prestamista`, `loan_acopiador`).

### Fuerza Laboral (Generación de Empleo)
Representa la intensidad de la mano de obra absorbida por la unidad productiva. El manual censal la clasifica operativamente por su duración:
*   **Empleo Permanente:** Conformado por los trabajadores contratados de manera regular por un período continuo igual o superior a seis meses. Capturado en la variable `permanent_workers_total`.
*   **Empleo Temporal:** Mano de obra contratada por un tiempo fijo menor a seis meses, generalmente asociada a picos de demanda laboral estacional (preparación de tierra, siembra, cosecha). Capturado en la variable `temporal_workers_total`.

### Manzana (Mz)
Unidad de medida de superficie agraria estándar en Nicaragua. Equivale aproximadamente a 0.705 hectáreas (o 10,000 varas cuadradas). Todas las métricas de área del proyecto están normalizadas bajo esta unidad.
*   **Mapeo de Datos:** Cuantificada en variables agregadas como `total_area_mz` y desglosada en las matrices de aprovechamiento del suelo.

### Estructura Operacional
Naturaleza jurídica o administrativa bajo la cual se organiza y dirige la Explotación Agropecuaria, dictando frecuentemente su nivel de formalidad en el acceso a crédito.
*   **Mapeo de Datos:** Identificada en la variable categórica `operational_structure` (ej. individual, cooperativa, empresa, colectivo familiar).

### Aprovechamiento de la Tierra (Uso de Suelo)
Clasificación física del destino dado a las parcelas que componen la explotación durante el año agrícola de referencia. Diferencia la vocación agrícola, pecuaria o forestal.
*   **Mapeo de Datos:** Segmentado en las variables `mz_annual_crops`, `mz_permanent_crops`, `mz_cultivated_pasture`, `mz_natural_pasture`, `mz_forest`, `mz_fallow`, `mz_infrastructure` y `mz_unusable`.

### Mecanización (Tracción Tecnológica)
Método principal de fuerza motriz empleado para la preparación de la tierra y labores de campo, sirviendo como indicador proxy del nivel tecnológico de la explotación.
*   **Mapeo de Datos:** Rastreado a través de los indicadores booleanos `traction_animal` y `traction_tractor`.