#  Impacto del Financiamiento en la Generación de Empleo y Diversificación Productiva de las Explotaciones Agropecuarias de Nicaragua (CENAGRO 2011) 

> **Autores:** Aguilar Rodríguez, Miranda Pérez, Oyarzo Morales, Medrano Dávila.  
> **Componente:** Integrador III - Ingeniería en Ciencias de Datos (UNAN-Managua).

---

## Planteamiento del Problema

En el sector agropecuario, el acceso al financiamiento representa un factor clave que puede influir en el desarrollo productivo y en las condiciones socioeconómicas de las explotaciones. Sin embargo, no todas las unidades productivas logran acceder a estos recursos, lo que podría generar diferencias significativas en su desempeño económico y en la forma en que utilizan sus recursos.

En particular, resulta relevante analizar si existen **diferencias estadísticamente significativas en variables como el volumen de generación de empleo y la diversificación del uso del suelo** entre las explotaciones agropecuarias que recibieron financiamiento y aquellas que no, durante el año agrícola 2010-2011. Estas variables no solo reflejan la capacidad productiva de las explotaciones, sino también su impacto en el desarrollo local y la sostenibilidad económica.

A pesar de la importancia del financiamiento rural, existe una limitada evidencia empírica, especialmente desde un enfoque cuantitativo, que permita comparar de manera rigurosa ambos grupos de explotaciones. Esta falta de análisis dificulta la comprensión del verdadero impacto del acceso al crédito en la dinámica productiva y social del sector agropecuario.

Por ello, surge la necesidad de aplicar herramientas estadísticas y de análisis de datos que permitan identificar, medir y contrastar estas diferencias, contribuyendo así a una mejor toma de decisiones en políticas públicas y estrategias de desarrollo rural.

---

## Justificación

El análisis del impacto del financiamiento en el sector agropecuario es fundamental para comprender cómo se generan y distribuyen las oportunidades económicas en contextos rurales. En particular, estudiar las diferencias en la generación de empleo y en la diversificación del uso del suelo permite evaluar no solo el rendimiento productivo de las explotaciones, sino también su **contribución al desarrollo socioeconómico sostenible**.

*   **Perspectiva Económica y Social:** El acceso al financiamiento puede actuar como un mecanismo de inclusión o exclusión productiva. Las explotaciones que reciben apoyo financiero podrían tener mayores capacidades para invertir, innovar y diversificar sus actividades, lo que potencialmente se traduce en mayor generación de empleo y un uso más eficiente del suelo. En contraste, aquellas que no acceden a financiamiento podrían enfrentar limitaciones estructurales que restringen su crecimiento y competitividad.
*   **Perspectiva Académica y Metodológica:** Este estudio aporta al desarrollo de habilidades clave en Ciencia de Datos, empleando técnicas estadísticas inferenciales como pruebas de hipótesis y análisis comparativos para identificar diferencias significativas. Fomenta el pensamiento crítico al interpretar si dichas diferencias son producto del financiamiento o de otros factores asociados basados en evidencia.
*   **Impacto Práctico:** Los resultados pueden servir como insumo para la formulación de políticas públicas orientadas a la mejora del acceso al financiamiento rural, optimizar el uso del suelo y promover la generación de empleo. Nicaragua es un país eminentemente agrícola y este estudio es un punto de partida para futuras investigaciones que motiven la inversión y la producción.

---

## Objetivos de la Investigación

### Objetivo General
**Analizar el impacto del financiamiento en la generación de empleo y la diversificación productiva** de las explotaciones agropecuarias en Nicaragua, utilizando datos del CENAGRO 2011.

### Objetivos Específicos
*   **Comparar** el volumen de generación de empleo entre explotaciones agropecuarias financiadas y no financiadas durante el período de estudio.
*   **Evaluar** el nivel de diversificación productiva en las explotaciones agropecuarias financiadas frente a las no financiadas.
*   **Contrastar** las brechas observadas en la generación de empleo y diversificación entre ambos grupos para identificar tendencias predominantes.

---

## Enfoque y Diseño de la Investigación

<Grid cols={2}>

###  Enfoque Cuantitativo Mixto
Procesamiento de un alto volumen de datos estructurados (más de 226,000 registros) mediante herramientas analíticas y la aplicación de técnicas de análisis estadístico descriptivo para el abordaje del problema.

###  Diseño No Experimental
Análisis puramente observacional de la realidad productiva; la base de datos censal se trata como un artefacto estático e inmutable sin manipulación alguna de variables de control por parte de los investigadores.

</Grid>

## Temporalidad y Alcance de la Investigación

<Grid cols={2}>

###  Corte Transversal
Evaluación de datos correspondientes a un único periodo o corte temporal específico delimitado por la recolección censal (el año agrícola 2010-2011).

###  Alcance Descriptivo
El estudio se enfoca en detallar y documentar las características productivas, específicamente el volumen de empleo y el uso del suelo, proporcionando un panorama claro de la situación entre ambos grupos.

</Grid>

---

## Panorama Global del Censo

```sql global_summary
SELECT 
    total_farms,
    total_area_mz,
    financed_farms
FROM global_summary
```

<Grid cols=3>
    <BigValue 
      data={global_summary} 
      value=total_farms base
      title="Total de Explotaciones" 
      fmt="num0"
    />
    <BigValue 
      data={global_summary} 
      value=total_area_mz 
      title="Área Total (Manzanas)" 
      fmt="num0"
    />
    <BigValue 
      data={global_summary} 
      value=financed_farms 
      title="Fincas con Financiamiento" 
      fmt="num0"
    />
</Grid>


