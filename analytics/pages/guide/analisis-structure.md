

### **Phase 1: System Baselines & Integrity (`01-perfilado-datos.md`)**
* **Phase Objective:** Validate dataset integrity, establish the demographic control variables, and explicitly size the independent variable cohorts (Financed vs. Non-Financed).
* **Target Metrics:** `total_rows`, `farm_size_class`, `operational_structure`, `requested_loan`, `received_loan`, and macro land use (`mz_annual_crops`, etc.).
* **Analytical Approach:** **Macroscopic Profiling.** You are proving the data is clean and defining the control universe. You must demonstrate the structural biases of the agricultural sector (e.g., 98% individual producers, heavy livestock dominance) to ensure these are accounted for before testing.

### **Phase 2: Variable Distributions (`02-analisis-univariado.md`)**
* **Phase Objective:** Map the natural statistical behavior, central tendencies, and dispersion of your dependent variables (Employment and Diversification) *before* introducing the financing variable.
* **Target Metrics:** `labor_intensity`, `permanent_labor_ratio`, `diversification_index`, `pasture_to_crop_ratio`.
* **Analytical Approach:** **Distribution Mapping.** You are identifying power-law distributions and extreme outliers. Apply Log10 transformations for skewed data (labor) and binning for bimodal data (permanent labor). You must aggressively segment by `farm_size_class` to prevent mega-farms from distorting the baselines.

### **Phase 3: Core Cohort Analysis (`03-analisis-comparativo-financiamiento.md`)**
* **Phase Objective:** Directly answer Specific Objectives 1 and 2. Measure the exact variance in employment generation and productive diversification between financed and non-financed operations.
* **Target Metrics:** `received_loan` (Primary Split Key) cross-tabulated against `labor_intensity`, `permanent_labor_ratio`, `diversification_index`, and `pasture_to_crop_ratio`.
* **Analytical Approach:** **Cross-Sectional A/B Testing.** Compare the medians (IQR) between Cohort A (Financed) and Cohort B (Non-Financed). To isolate the true impact of the loan, you must control for confounding variables by running these tests within isolated segments (e.g., comparing only *Individual, Small* financed farms against *Individual, Small* non-financed farms). Calculate the **Relative Intensity Gap** here.

### **Phase 4: Executive Aggregation (`04-sintesis-resultados.md`)**
* **Phase Objective:** Directly answer Specific Objective 3 and the General Objective. Consolidate the observed gaps into definitive trends regarding the socioeconomic impact of agricultural credit.
* **Target Metrics:** Delta of `labor_intensity` (%), Delta of `diversification_index` (absolute shift), and `Credit Approval Efficiency`.
* **Analytical Approach:** **Domain-Specific Synthesis.** Abstract the statistical outputs into business logic. State clearly if financing formalizes the workforce (shifts from seasonal to permanent) and if it drives an agricultural transition (shifts from pure pasture to polyculture). Rely on pre-calculated summary tables from DuckDB, rendered as macroscopic `<BigValue>` KPIs.