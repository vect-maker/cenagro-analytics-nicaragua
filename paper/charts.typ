#import "@preview/cetz:0.3.4"
#import "@preview/cetz-plot:0.1.1": plot, chart

// High-Contrast Academic Theme Colors
#let color-financiadas = rgb("#1e40af")     // Deep Navy Blue (Financiadas)
#let color-no-financiadas = rgb("#d97706")  // Warm Amber / Ochre (No Financiadas)
#let color-accent = rgb("#2563eb")         // Primary Blue
#let color-secondary = rgb("#059669")      // Emerald
#let color-muted = rgb("#64748b")          // Slate grey
#let color-light-slate = rgb("#94a3b8")

#let palette-dual = (color-financiadas, color-no-financiadas)
#let style-dual = (i) => (fill: palette-dual.at(i), stroke: 0.3pt + luma(80))

// -------------------------------------------------------------
// Fig 1: Embudo de Acceso al Crédito (Desagregación en 2 Fases)
// -------------------------------------------------------------
#let chart-embudo() = {
  let raw = csv("data/fig1_funnel_rates.csv").slice(1)
  let data = (
    ([1. Entrada Censal (262k EA)], float(raw.at(0).at(1)), float(raw.at(0).at(2))),
    ([2. Ventanilla Bancaria (41.8k)], float(raw.at(1).at(1)), float(raw.at(1).at(2))),
  )
  
  cetz.canvas({
    chart.barchart(
      data,
      mode: "clustered",
      value-key: (1, 2),
      labels: ([Tasa Efectiva / Aprobación (%)], [Barrera / Sin Solicitud (%) ]),
      legend: "inner-north-east",
      legend-style: (stroke: none, fill: rgb(255, 255, 255, 230), padding: 0.15),
      bar-style: (i) => (fill: (color-financiadas, color-muted).at(i), stroke: 0.3pt + luma(80)),
      size: (12.5, 4.6),
      x-label: [Porcentaje (%) del Universo en cada Etapa],
      y-label: [Fase del Circuito Financiero],
      x-max: 100,
      x-tick-step: none,
      x-ticks: (
        (0, [0%]),
        (20, [20%]),
        (40, [40%]),
        (60, [60%]),
        (80, [80%]),
        (100, [100%]),
      ),
      bar-width: 0.6,
    )
  })
}

// -------------------------------------------------------------
// Fig 2: Principales Fuentes de Financiamiento
// -------------------------------------------------------------
#let chart-fuentes() = {
  let raw = csv("data/fig2_fuentes.csv").slice(1)
  let data = raw.map(row => (
    [#row.at(0) (#row.at(2)%)], 
    float(row.at(1))
  ))
  
  cetz.canvas({
    chart.barchart(
      data,
      size: (12.5, 5.2),
      fill: color-accent,
      stroke: 0.3pt + luma(80),
      x-label: [Número de Créditos Otorgados (y Cuota de Mercado %)],
      y-label: [Fuente Institucional],
      x-max: 20000,
      x-tick-step: none,
      x-ticks: (
        (0, [0]),
        (5000, [5k]),
        (10000, [10k]),
        (15000, [15k]),
        (20000, [20k]),
      ),
      bar-width: 0.6,
    )
  })
}

// -------------------------------------------------------------
// Fig 3: Intensidad Laboral Mediana por Escala y Acceso a Crédito
// -------------------------------------------------------------
#let chart-intensidad() = {
  let raw = csv("data/fig3_intensidad.csv").slice(1)
  let data = raw.map(row => (row.at(0), float(row.at(1)), float(row.at(2))))
  
  cetz.canvas({
    chart.columnchart(
      data,
      mode: "clustered",
      value-key: (1, 2),
      labels: ([Financiadas], [No Financiadas]),
      legend: "inner-north-east",
      legend-style: (stroke: none, fill: rgb(255, 255, 255, 230), padding: 0.15),
      bar-style: style-dual,
      size: (10.5, 4.5),
      x-label: [Estrato de Tamaño de Finca (Mz)],
      y-label: [Trabajadores / Manzana (Mediana)],
      y-max: 2.0,
      y-tick-step: 0.5,
      bar-width: 0.55,
    )
  })
}

// -------------------------------------------------------------
// Fig 4: Distribución de la Estabilidad Laboral (Regímenes)
// -------------------------------------------------------------
#let chart-estabilidad() = {
  let raw = csv("data/fig4_estabilidad.csv").slice(1)
  let data = raw.map(row => (row.at(0), float(row.at(1)), float(row.at(2))))
  
  cetz.canvas({
    chart.columnchart(
      data,
      mode: "clustered",
      value-key: (1, 2),
      labels: ([Financiadas], [No Financiadas]),
      legend: "inner-north-east",
      legend-style: (stroke: none, fill: rgb(255, 255, 255, 230), padding: 0.15),
      bar-style: style-dual,
      size: (12, 4.5),
      x-label: [Régimen Contractual de la Fuerza Laboral],
      y-label: [% de Fincas del Grupo],
      y-max: 80,
      y-tick-step: 20,
      bar-width: 0.6,
    )
  })
}

// -------------------------------------------------------------
// Fig 5: Densidad de Complejidad Productiva
// -------------------------------------------------------------
#let chart-complejidad() = {
  let raw = csv("data/fig5_complejidad.csv").slice(1)
  let data = raw.map(row => (row.at(0), float(row.at(1)), float(row.at(2))))
  
  cetz.canvas({
    chart.columnchart(
      data,
      mode: "clustered",
      value-key: (1, 2),
      labels: ([Financiadas], [No Financiadas]),
      legend: "inner-north-east",
      legend-style: (stroke: none, fill: rgb(255, 255, 255, 230), padding: 0.15),
      bar-style: style-dual,
      size: (12.5, 4.5),
      x-label: [Índice de Diversificación Productiva (Número de Rubros)],
      y-label: [% de Fincas del Grupo],
      y-max: 30,
      y-tick-step: 5,
      bar-width: 0.65,
    )
  })
}

// -------------------------------------------------------------
// Fig 6: Vocación Económica y Uso del Suelo
// -------------------------------------------------------------
#let chart-vocacion() = {
  let raw = csv("data/fig6_vocacion.csv").slice(1)
  let data = raw.map(row => (row.at(0), float(row.at(1)), float(row.at(2))))
  
  cetz.canvas({
    chart.barchart(
      data,
      mode: "clustered",
      value-key: (1, 2),
      labels: ([Financiadas], [No Financiadas]),
      legend: "inner-north-east",
      legend-style: (stroke: none, fill: rgb(255, 255, 255, 230), padding: 0.15),
      bar-style: style-dual,
      size: (12.5, 5.0),
      x-label: [% del Área Total Asignada en la Finca],
      y-label: [Uso del Suelo],
      x-max: 45,
      x-tick-step: 10,
      bar-width: 0.55,
    )
  })
}
