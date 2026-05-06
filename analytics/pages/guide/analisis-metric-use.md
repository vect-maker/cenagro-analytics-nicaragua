### **01-perfilado-datos.md (System Baselines & Control Variables)**
* **`requested_loan` & `received_loan`:** Used to define the independent variable baseline (Credit Funnel).
* **`farm_size_class`:** Used to establish the demographic baseline of the control cohorts.
* **`traction_tractor` / `traction_animal`:** Defines the baseline technological profile before analyzing financing impacts.

### **02-analisis-univariado.md (Statistical Distributions)**
* **`labor_intensity`:** Analyzed via Log10 histograms and quartiles to map the power-law distribution of agricultural employment.
* **`permanent_labor_ratio`:** Analyzed via binned histograms to prove the bimodal nature of agricultural hiring (seasonal vs. stable).
* **`diversification_index`:** Mapped as an ordinal category (1 to 8) to establish the baseline complexity of the farms.
* **`pasture_to_crop_ratio`:** Used to categorize the dataset into discrete economic vocations (e.g., Pure Livestock, Mixed, Pure Agriculture) bypassing division-by-zero edge cases.

### **03-analisis-comparativo-financiamiento.md (Core Cohort A/B Testing)**
* **Split Key:** All queries here use `received_loan` (True/False) as the primary split.
* **`labor_intensity`:** Compared between cohorts to calculate the **Relative Intensity Gap** (Objective 1).
* **`permanent_labor_ratio`:** Compared between cohorts to determine if financing stabilizes job quality.
* **`diversification_index`:** Compared to test if financing drives polyculture and risk mitigation (Objective 2).
* **`ratio_mz_[category]` (Land Use Composition Ratio):** Cross-tabulated to see if financed farms dedicate a higher percentage of land to permanent crops vs. natural pasture.
* **`pasture_to_crop_ratio`:** Tested against the cohorts to prove if financing shifts the farm's vocation from livestock to agriculture.

### **04-sintesis-resultados.md (Executive Aggregation)**
* **Delta `labor_intensity`:** Summarized as the final percentage increase/decrease in job creation linked to financing.
* **Delta `diversification_index`:** Summarized as the absolute shift in productive complexity.
* **Credit Approval Efficiency:** Calculated strictly as `received_loan` / `requested_loan`.