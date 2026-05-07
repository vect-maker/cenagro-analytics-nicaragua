# Evidence.dev Workflow & Architecture Guidelines

## 1. Data Pipeline & Transformations (ETL to OLAP)
* **Row-Level Transformations:** **Must** be applied inside the Rust/DataFusion pipeline. 
    * *Architecture Note:* Pushing row-level operations (casting, null imputation, string manipulation) to DataFusion leverages Arrow's vectorized memory model. Doing this in DuckDB at build-time creates unnecessary CPU overhead and memory spikes.
* **Semantic Layer Build:** The DuckDB warehouse build script initializes the database. Domain-specific data marts are generated directly from the central `farms` fact table (the final output of DataFusion).

## 2. Aggregation Standards (`sources/warehouse/aggs/`)
* **Naming Convention:** Every aggregation file **must** use the `agg_` prefix (e.g., `agg_intensity_gap.sql`). This explicitly prevents namespace collisions with base tables or dimension tables in the warehouse.
* **Pre-computation:** Always materialize complex grouped aggregations in this folder to guarantee **O(1) rendering performance** on the frontend.
* **Localization (L10n) at the Edge:** **Do not** apply display names or translations (e.g., Spanish labels) inside the base aggregation files. Keep the warehouse aggregations language-agnostic and column names programmatic. Apply localization at the page level.

## 3. Query Implementation in Markdown
* **Pass-Through Queries:** If the Markdown requires the exact aggregation without modifications, execute a direct `SELECT *` and ensure the query block name matches the source table exactly:
    ```sql
    ```sql agg_vocation_shift
    SELECT * FROM agg_vocation_shift;
    ```
    ```
* **Transformed Queries:** If you apply page-level modifications (e.g., pivoting, localized `CASE WHEN` aliases, or CTEs) to the base aggregation, you **must** assign a new, distinct name to the query block. 
    * *Edge Case:* Reusing the same name for a mutated query will corrupt Evidence's build cache and cause rendering mismatches.
    ```sql
    ```sql vocation_shift_localized
    SELECT 
        CASE WHEN received_loan THEN 'Financiadas' ELSE 'No Financiadas' END AS grupo,
        total_farms
    FROM agg_vocation_shift;
    ```
    ```

## 4. UI Component Architecture (Page Sections)
Enforce a strict visual hierarchy to minimize cognitive load across the dashboard. Every analytical section **must** follow this exact vertical order:
1.  **Heading (`##`):** Clear, descriptive section title.
2.  **Narrative:** A brief introductory paragraph explaining the methodology and the business context of the metric.
3.  **Visualization:** The Evidence.dev component (example `<BarChart>`, `<Grid>`, `<DataTable>`).
4.  **`<Details>` Block:** The interpretive layer, strictly broken down into **Evidencia** (what the data shows) and **Implicación** (the business or socioeconomic impact).