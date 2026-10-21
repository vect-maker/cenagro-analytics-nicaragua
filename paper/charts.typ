#import "@preview/cetz:0.3.4"
#import "@preview/cetz-plot:0.1.1": plot, chart

// Theme Colors
#let color-financiadas = rgb("#5ba423")     // Emerald green
#let color-no-financiadas = rgb("#d5d75e")  // Olive / light yellow-green
#let color-accent = rgb("#1d4ed8")         // Deep blue
#let color-amber = rgb("#f59e0b")          // Amber gold

#let palette-dual = (color-financiadas, color-no-financiadas)
#let style-dual = (i) => (fill: palette-dual.at(i), stroke: 0.3pt + luma(100))

// -------------------------------------------------------------
// Fig 1: Embudo de Acceso al Crédito
// -------------------------------------------------------------
#let chart-embudo() = {
  let raw = csv("data/fig1_funnel.csv").slice(1)
  let data = (
    ([Universo Total], float(raw.at(0).at(1))),
    ([Solicitaron], float(raw.at(1).at(1))),
    ([Recibieron], float(raw.at(2).at(1))),
  )
  
  cetz.canvas({
    chart.columnchart(
      data,
      size: (12, 4.5),
      fill: color-accent,
      stroke: 0.3pt + luma(100),
      x-label: [Etapa del Proceso de Crédito],
      y-label: [Explotaciones Agropecuarias],
      y-max: 300000,
      y-tick-step: none,
      y-ticks: (
        (0, [0]),
        (50000, [50k]),
        (100000, [100k]),
        (150000, [150k]),
        (200000, [200k]),
        (250000, [250k]),
        (300000, [300k]),
      ),
      bar-width: 0.55,
    )
  })
}

// -------------------------------------------------------------
// Fig 2: Principales Fuentes de Financiamiento
// -------------------------------------------------------------
#let chart-fuentes() = {
  let raw = csv("data/fig2_fuentes.csv").slice(1)
  let data = raw.map(row => (row.at(0), float(row.at(1))))
  
  cetz.canvas({
    chart.barchart(
      data,
      size: (12, 5.2),
      fill: color-accent,
      stroke: 0.3pt + luma(100),
      x-label: [Número de Créditos Otorgados],
      y-label: [Fuente de Financiamiento],
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
      legend-style: (stroke: none, fill: rgb(255, 255, 255, 220), padding: 0.15),
      bar-style: style-dual,
      size: (10, 4.5),
      x-label: [Estrato de Tamaño de Finca],
      y-label: [Trabajadores / Manzana (Mediana)],
      y-max: 2.0,
      bar-width: 0.55,
    )
  })
}

// -------------------------------------------------------------
// Fig 4: Distribución de la Estabilidad Laboral
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
      legend-style: (stroke: none, fill: rgb(255, 255, 255, 220), padding: 0.15),
      bar-style: style-dual,
      size: (12.5, 4.5),
      x-label: [Ratio de Empleo Permanente (0 = Estacional, 1 = Fijo)],
      y-label: [% de Fincas en Cohorte],
      y-max: 80,
      bar-width: 0.7,
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
      legend-style: (stroke: none, fill: rgb(255, 255, 255, 220), padding: 0.15),
      bar-style: style-dual,
      size: (12.5, 4.5),
      x-label: [Índice de Diversificación Productiva (Rubros)],
      y-label: [% de Fincas en Cohorte],
      y-max: 30,
      bar-width: 0.7,
    )
  })
}

// -------------------------------------------------------------
// Fig 6: Vocación Económica (Uso del Suelo)
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
      legend-style: (stroke: none, fill: rgb(255, 255, 255, 220), padding: 0.15),
      bar-style: style-dual,
      size: (12, 4.2),
      x-label: [% del Área Total Asignada],
      y-label: [Uso del Suelo],
      x-max: 30,
      bar-width: 0.55,
    )
  })
}
