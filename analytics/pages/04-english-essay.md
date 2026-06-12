# Impact of Financing on Employment and Agricultural Diversification in Nicaragua

> **Authors:** Miranda Pérez, José Daniel; Aguilar Rodríguez, Kendall Ezequiel; Medrano Dávila, Luis David; Oyarzo Morales, Ricardo Alberto  
> **Institution:** Universidad Nacional Autónoma de Nicaragua (UNAN-Managua)

Access to rural credit is a fundamental driver of economic development; however, evaluating its impact on Nicaragua's agricultural landscape remains complex. This study leverages microdata from the IV National Agricultural Census (CENAGRO 2011) to analyze how financing influences productive outcomes, providing an empirical basis for understanding rural economic dynamics. This essay argues that agricultural financing served as a primary catalyst for land diversification and labor absorption during the period studied, shifting production models toward more complex, multi-crop systems. The following analysis examines this transition from a Macro Impact perspective, encompassing the interplay between employment generation and scale, productive diversification, and the institutional friction that limited formal credit access.

From a Macro Impact perspective, the injection of capital into the Nicaraguan agricultural sector between 2010 and 2011 was intrinsically linked to its ability to stabilize the workforce and improve productive efficiency, aligning with broader goals for rural development. When analyzing employment generation and scale, the 2011 census data indicated that financing acted as a powerful engine for labor absorption rather than a tool for technological replacement. By isolating the bias of economies of scale, it was observed that financed medium and large farms exhibited a 171.6% increase in median labor intensity per manzana compared to non-financed equivalents.

```sql agg_intensity_gap_en
SELECT 
    farm_size_class,
    CASE WHEN received_loan THEN 'Financed' ELSE 'Non-Financed' END AS cohort,
    median_intensity
FROM agg_intensity_gap

```

<BarChart
data={agg_intensity_gap_en} x=farm_size_class y=median_intensity series=cohort type=grouped
title="Median Labor Intensity by Scale and Credit Access" yAxisTitle="Workers per Manzana"
colorPalette={['#5ba423', '#d5d75e']} labels=true yMax=2
/>

Furthermore, the evidence suggested that access to capital allowed producers to scale operations during critical seasonal periods, such as planting and harvesting, though this primarily intensified reliance on temporary labor rather than creating year-round payroll stability.

```sql job_quality_relative_en
WITH totales_grupo AS (
    SELECT received_loan, SUM(frequency) as total_cohort FROM agg_job_quality_shift GROUP BY 1
)
SELECT 
    a.ratio_bin,
    CASE WHEN a.received_loan THEN 'Financed' ELSE 'Non-Financed' END AS cohort,
    (a.frequency * 1.0 / t.total_cohort) AS pct_relativo
FROM agg_job_quality_shift a
JOIN totales_grupo t ON a.received_loan = t.received_loan
ORDER BY a.ratio_bin, cohort;

```

<BarChart
data={job_quality_relative_en} x=ratio_bin y=pct_relativo series=cohort type=stacked
title="Labor Stability Distribution (Relative Proportion)" xAxisTitle="Permanent Labor Ratio (0 = Seasonal, 1 = Permanent)" yAxisTitle="% of Farms in Cohort"
yFmt="pct1" colorPalette={['#5ba423', '#d5d75e']}
/>

Beyond labor dynamics, access to financial resources played a critical role in productive diversification. The data demonstrated that liquidity facilitated the growth of multiple crop types, effectively helping farms mitigate the risks associated with monoculture or over-reliance on extensive cattle ranching. Financed operations showed a clear trend toward higher complexity, adding an average of 0.29 extra crop types compared to their non-financed counterparts.

```sql diversification_relative_en
WITH totales_grupo AS (
    SELECT received_loan, SUM(total_farms) as total_cohort FROM agg_diversification_shift GROUP BY 1
)
SELECT 
    a.index_score,
    CASE WHEN a.received_loan THEN 'Financed' ELSE 'Non-Financed' END AS cohort,
    (a.total_farms * 1.0 / t.total_cohort) AS pct_relativo
FROM agg_diversification_shift a
JOIN totales_grupo t ON a.received_loan = t.received_loan
ORDER BY a.index_score, cohort;

```

<BarChart
data={diversification_relative_en} x=index_score y=pct_relativo series=cohort type=grouped
title="Productive Complexity Distribution (Financed vs. Non-Financed)" xAxisTitle="Diversification Index Score (1-8 Categories)" yAxisTitle="% of Farms in Cohort"
yFmt="pct1" colorPalette={['#5ba423', '#d5d75e']}
/>

This shift allowed producers to move away from the degradation of natural forests for pasture, incentivizing instead the adoption of long-term, high-value perennial crops. Consequently, financial support served as a mechanism for modernizing land use and increasing the resilience of rural productive models.

```sql vocation_unpivot_en
UNPIVOT (
    SELECT 
        CASE WHEN received_loan THEN 'Financed' ELSE 'Non-Financed' END AS cohort,
        avg_ratio_permanent_crops AS "Permanent Crops",
        avg_ratio_natural_pasture AS "Natural Pasture"
    FROM agg_vocation_shift
)
ON "Permanent Crops", "Natural Pasture"
INTO NAME category VALUE proportion;

```

<BarChart
data={vocation_unpivot_en} x=category y=proportion series=cohort type=grouped swapXY=true
title="Proportion of Area Allocated to Crops vs. Natural Pastures" xAxisTitle="Proportion of Total Area" yAxisTitle="Land Use Category"
yFmt="pct1" colorPalette={['#5ba423', '#d5d75e']}
/>

However, despite these benefits, the analysis of the credit process highlights significant institutional friction. While the rate of approval for those who entered the system was exceptionally high, approximately 92.6%, the primary obstacle was not bank-driven denial, but rather the low overall penetration of the formal credit system.

```sql credit_funnel_en
SELECT '1. Total Universe' AS stage, COUNT(*) AS farms FROM farm_credit_access
UNION ALL
SELECT '2. Requested Credit' AS stage, COUNT(*) FROM farm_credit_access WHERE requested_loan = true
UNION ALL
SELECT '3. Received Credit' AS stage, COUNT(*) FROM farm_credit_access WHERE received_loan = true
ORDER BY stage ASC;

```
<BarChart data="{credit_funnel_en}" fillColor="#f4b548" labels="true" title="Credit Access Funnel" x="stage" y="farms" yFmt="num0"/>
   


With only 15.9% of farms requesting credit, the data suggested that structural barriers such as a lack of collateral, informality, or auto-exclusion prevented the vast majority of the agricultural sector from entering the financial ecosystem. However, contrary to the assumption that informal lending filled this gap, the data revealed that among the minority of producers who did secure loans, formal private banks (*Banco Privado*) were the overwhelming providers. The dominance of commercial banking over cooperatives and informal lenders indicates that the sector's financial leverage was strictly tied to formal institutional requirements, further solidifying the exclusion of subsistence operations.

```sql credit_sources_en
UNPIVOT (
    SELECT 
        SUM(CAST(loan_banco AS INT)) AS "Private Bank",
        SUM(CAST(loan_cooperativa AS INT)) AS "Cooperatives",
        SUM(CAST(loan_ong AS INT)) AS "NGOs",
        SUM(CAST(loan_prestamista AS INT)) AS "Informal Lender",
        SUM(CAST(loan_acopiador AS INT)) AS "Aggregator / Middleman",
        SUM(CAST(loan_banco_produzcamos AS INT)) AS "Produzcamos Bank"
    FROM farm_credit_access
)
ON "Private Bank", "Cooperatives", "NGOs", "Informal Lender", "Aggregator / Middleman", "Produzcamos Bank"
INTO NAME source VALUE farms;

```
 <BarChart data="{credit_sources_en}" fillColor="#dc2626" labels="true" sort="farms" swapXY="true" title="Primary Sources of Financing" x="source" y="farms" yFmt="num0"/>

In conclusion, agricultural credit during the 2011 census period proved to be a vital driver of job creation and productive variety, yet its potential remained constrained by systemic exclusion. While capital injection significantly increased labor volume and facilitated a transition toward intensified, diversified land use, the formal banking system failed to reach the majority of small-scale producers. To foster comprehensive growth and reduce rural poverty, future policies must prioritize the expansion of financial inclusion and the development of credit architectures that address the barriers preventing formal applications in the first place.


**References**
Instituto Nacional de Información de Desarrollo. (2011). IV Censo Nacional Agropecuario (CENAGRO 2011). Managua, Nicaragua.
