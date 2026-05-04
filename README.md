# Proyecto Integrador III: Data Analytics Ecosystem (CENAGRO 2011)

Este repositorio contiene una solución de ingeniería de datos integral para procesar, modelar y visualizar los resultados del **IV Censo Nacional Agropecuario de Nicaragua (CENAGRO 2011)**. El proyecto implementa una arquitectura de **Modern Data Stack** local, diseñada para maximizar la eficiencia computacional en hardware limitado.

## 🌐 Despliegue Público
La versión compilada de este informe se sirve estáticamente al público en la siguiente dirección:
**[cenagro-analytics-ni.netlify.app](https://cenagro-analytics-ni.netlify.app)**

## 🚀 Capacidades del Sistema

*   **Procesamiento de Alto Rendimiento:** Motor ETL desarrollado en **Rust** utilizando **Apache DataFusion** para transformaciones vectorizadas y multihilo sobre memoria columnar **Arrow**.
*   **Arquitectura Desacoplada:** Separación estricta entre la ingesta (Python), transformación pesada (Rust), orquestación (Just), almacenamiento (DuckDB) y visualización (Evidence.dev).
*   **Análisis OLAP Eficiente:** Uso de **DuckDB** como motor analítico *in-process*, permitiendo consultas complejas sobre archivos Parquet con un consumo mínimo de memoria.
*   **Capa de Presentación como Código:** Portal de BI estático generado mediante **Evidence.dev**, donde los gráficos y métricas se definen mediante Markdown y SQL.
*   **Infraestructura Atómica:** Despliegue contenerizado mediante **Podman** (daemonless/rootless), garantizando la reproducibilidad del entorno sobre sistemas operativos inmutables como **Aurora Fedora**.

---

## 📂 Estructura del Repositorio

| Directorio | Propósito |
| :--- | :--- |
| `etl/` | Código fuente en **Rust** para el pipeline de transformación y normalización de datos. |
| `analytics/` | Portal de visualización en **Evidence.dev**, incluyendo el marco teórico y análisis descriptivos. |
| `infra/` | Definiciones de contenedores (**Containerfiles**) para el compilador, transformador y servidor de BI. |
| `pipes/` | Scripts de soporte en Python para la ingesta inicial de archivos SPSS (`.sav`) a Parquet. |
| `mappings/` | Diccionarios maestros en CSV para la tipificación de variables geográficas y categóricas. |
| `sql/` | Scripts DDL/DML para la construcción del warehouse y carga de tablas en **DuckDB**. |

---

## 🛠️ Flujo de Operación (Justfile)

El proyecto utiliza `just` para orquestar todas las fases del pipeline. Asegúrese de tener instalados **Podman** y **Just** antes de comenzar.

### 1. Preparación del Envornment
```bash
just build-compiler     # Prepara la imagen base de compilación Rust
just build-pipeline     # Compila el ejecutable ETL en un contenedor ligero
just build-bi-container   # Prepara el entorno para el portal de analytics
```

### 2. Ejecución del Pipeline
```bash
just run-pipeline       # Ejecuta la transformación Rust (genera farms.parquet)
just build-werehouse    # Inicializa DuckDB y carga las dimensiones y hechos
just add-meta-bi        # Sincroniza los metadatos de las fuentes de datos
```

### 3. Visualización y Análisis
```bash
just run-bi             # Levanta el servidor local en localhost:3000 con hot-reload
just build-bi           # Genera el sitio web estático para despliegue final
```

---

## 📊 Capa Semántica y Métricas
El repositorio implementa métricas críticas para el análisis del sector agropecuario, tales como:
*   **Intensidad Laboral:** Factor de trabajo permanente y temporal absorbido por manzana de tierra.
*   **Matrices de Acceso a Crédito:** Mapeo detallado de fuentes de financiamiento y tasas de aprobación por rubro específico (Agrícola, Pecuario, Acuícola, Forestal).
*   **Aprovechamiento de Suelo:** Clasificación pre-agregada de uso de tierra en categorías anuales, permanentes, pastos y forestales.

---

## 👨‍💻 Desarrollo
Para iniciar un entorno de desarrollo integrado con **Zellij** y **Neovim** (NvChad) pre-configurado:
```bash
just enter
```
Este comando activa una sesión de terminal multiplexada con el editor, consola de bash y cliente SQL de **DuckDB** listos para operar.
