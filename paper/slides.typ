#import "slides-template.typ": *
#import "metadata.typ": *

#show: cenagro-theme.with()

// ============================================================
// DIAPOSITIVA 1: PORTADA / TITLE SLIDE
// ============================================================
// Por defecto muestra el texto de la plantilla original para verificación 1:1.
// Para usar metadatos del proyecto, reemplace los textos por `#title` y `#university`.
#title-slide(
  title: [Escriba su texto],
  subtitle: [Escriba el texto],
)

// ============================================================
// DIAPOSITIVA 2: CONTENIDO / BODY SLIDE
// ============================================================
= Escriba el texto

- Texto

// ============================================================
// DIAPOSITIVA 3: CIERRE / ENDING SLIDE
// ============================================================
#ending-slide()
