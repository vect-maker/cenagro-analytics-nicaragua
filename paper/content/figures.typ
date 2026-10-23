// Shared figure metadata, titles, enumeration, and captions for monograph and presentation

#let figures-data = (
  embudo: (
    number: 1,
    title: [Embudo de Acceso al Crédito: Tasa de Entrada vs. Resolución Bancaria],
    label: "fig-embudo",
  ),
  fuentes: (
    number: 2,
    title: [Principales Fuentes de Financiamiento],
    label: "fig-fuentes",
  ),
  intensidad: (
    number: 3,
    title: [Intensidad Laboral Mediana por Escala y Acceso a Crédito],
    label: "fig-intensidad",
  ),
  estabilidad: (
    number: 4,
    title: [Distribución de la Fuerza Laboral por Régimen Contractual],
    label: "fig-estabilidad",
  ),
  complejidad: (
    number: 5,
    title: [Densidad de Complejidad Productiva (Distribución Normalizada)],
    label: "fig-complejidad",
  ),
  vocacion: (
    number: 6,
    title: [Distribución del Uso de la Tierra según Acceso a Financiamiento],
    label: "fig-pasto",
  ),
)

/// Formatted caption with figure number for presentation slides
#let fig-caption(key) = {
  let item = figures-data.at(key)
  [Figura #item.number. #item.title.]
}

/// Short reference string (e.g. "Figura 1")
#let fig-ref(key) = {
  let item = figures-data.at(key)
  [Figura #item.number]
}
