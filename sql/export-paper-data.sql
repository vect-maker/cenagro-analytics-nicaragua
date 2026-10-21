-- Export queries for paper figures into paper/data/

-- Fig 1: Credit Funnel (Two-stage conversion data)
COPY (
    SELECT '1. Universo Censal' AS stage, COUNT(*) AS count_val, 100.0 AS pct FROM farm_credit_access
    UNION ALL
    SELECT '2. Solicitaron Crédito' AS stage, SUM(CASE WHEN requested_loan THEN 1 ELSE 0 END) AS count_val, ROUND(SUM(CASE WHEN requested_loan THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1) AS pct FROM farm_credit_access
    UNION ALL
    SELECT '3. Recibieron Crédito' AS stage, SUM(CASE WHEN received_loan THEN 1 ELSE 0 END) AS count_val, ROUND(SUM(CASE WHEN received_loan THEN 1 ELSE 0 END) * 100.0 / SUM(CASE WHEN requested_loan THEN 1 ELSE 0 END), 1) AS pct FROM farm_credit_access
    ORDER BY stage ASC
) TO 'paper/data/fig1_funnel.csv' (HEADER, DELIMITER ',');

-- Fig 1b: Conversion breakdown for detailed display
COPY (
    SELECT 
        '1. Entrada Censal (262k)' AS dimension,
        ROUND(SUM(CASE WHEN requested_loan THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1) AS solicitantes,
        ROUND((COUNT(*) - SUM(CASE WHEN requested_loan THEN 1 ELSE 0 END)) * 100.0 / COUNT(*), 1) AS autoexcluidos
    FROM farm_credit_access
    UNION ALL
    SELECT 
        '2. Resolución en Ventanilla (41.8k)' AS dimension,
        ROUND(SUM(CASE WHEN received_loan THEN 1 ELSE 0 END) * 100.0 / SUM(CASE WHEN requested_loan THEN 1 ELSE 0 END), 1) AS solicitantes,
        ROUND(SUM(CASE WHEN requested_loan AND NOT received_loan THEN 1 ELSE 0 END) * 100.0 / SUM(CASE WHEN requested_loan THEN 1 ELSE 0 END), 1) AS autoexcluidos
    FROM farm_credit_access
) TO 'paper/data/fig1_funnel_rates.csv' (HEADER, DELIMITER ',');

-- Fig 2: Sources of Financing with percentage shares
COPY (
    WITH raw AS (
        UNPIVOT (
            SELECT 
                SUM(CAST(loan_banco AS INT)) AS 'Banco Privado',
                SUM(CAST(loan_cooperativa AS INT)) AS 'Cooperativas',
                SUM(CAST(loan_ong AS INT)) AS 'ONGs',
                SUM(CAST(loan_prestamista AS INT)) AS 'Prestamistas',
                SUM(CAST(loan_acopiador AS INT)) AS 'Acopiadores',
                SUM(CAST(loan_banco_produzcamos AS INT)) AS 'Banco Produzcamos'
            FROM farm_credit_access
        )
        ON 'Banco Privado', 'Cooperativas', 'ONGs', 'Prestamistas', 'Acopiadores', 'Banco Produzcamos'
        INTO
            NAME source
            VALUE farms
    ),
    tot AS (SELECT SUM(farms) AS total_loans FROM raw)
    SELECT 
        r.source,
        r.farms,
        ROUND(r.farms * 100.0 / t.total_loans, 1) AS pct_share
    FROM raw r, tot t
    ORDER BY r.farms ASC
) TO 'paper/data/fig2_fuentes.csv' (HEADER, DELIMITER ',');

-- Fig 3: Labor Intensity Gap by Size Class
COPY (
    WITH raw AS (
        SELECT 
            l.farm_size_class,
            c.received_loan,
            quantile_cont(l.labor_intensity, 0.50) AS median_intensity
        FROM farm_labor l
        JOIN farm_credit_access c ON l.farm_uid = c.farm_uid
        WHERE l.labor_intensity > 0.0 AND l.farm_size_class IN ('Small', 'Medium/Large')
        GROUP BY 1, 2
    )
    SELECT 
        farm_size_class,
        ROUND(MAX(CASE WHEN received_loan THEN median_intensity END), 3) AS financiadas,
        ROUND(MAX(CASE WHEN NOT received_loan THEN median_intensity END), 3) AS no_financiadas
    FROM raw
    GROUP BY farm_size_class
    ORDER BY CASE farm_size_class WHEN 'Small' THEN 1 WHEN 'Medium/Large' THEN 2 END
) TO 'paper/data/fig3_intensidad.csv' (HEADER, DELIMITER ',');

-- Fig 4: Labor Stability Distribution (Grouped in 3 clear contractual regimes)
COPY (
    WITH categorized AS (
        SELECT 
            c.received_loan,
            CASE 
                WHEN l.permanent_workers_total = 0 THEN 'Solo Temporal'
                WHEN l.temporal_workers_total = 0 THEN 'Solo Permanente'
                ELSE 'Régimen Mixto'
            END AS regimen,
            CASE 
                WHEN l.permanent_workers_total = 0 THEN 1
                WHEN l.temporal_workers_total = 0 THEN 3
                ELSE 2
            END AS orden
        FROM farm_labor l
        JOIN farm_credit_access c ON l.farm_uid = c.farm_uid
        WHERE l.permanent_workers_total > 0 OR l.temporal_workers_total > 0
    ),
    totals AS (
        SELECT received_loan, COUNT(*) AS total
        FROM categorized
        GROUP BY 1
    )
    SELECT 
        c.regimen,
        ROUND(SUM(CASE WHEN c.received_loan THEN 1 ELSE 0 END) * 100.0 / MAX(CASE WHEN t.received_loan THEN t.total END), 1) AS financiadas,
        ROUND(SUM(CASE WHEN NOT c.received_loan THEN 1 ELSE 0 END) * 100.0 / MAX(CASE WHEN NOT t.received_loan THEN t.total END), 1) AS no_financiadas
    FROM categorized c
    JOIN totals t ON c.received_loan = t.received_loan
    GROUP BY c.regimen, c.orden
    ORDER BY c.orden ASC
) TO 'paper/data/fig4_estabilidad.csv' (HEADER, DELIMITER ',');

-- Fig 5: Productive Diversification Distribution
COPY (
    WITH counts AS (
        SELECT 
            c.received_loan,
            CAST(f.diversification_index AS INT) AS index_score,
            COUNT(*) as total_farms
        FROM farms f
        JOIN farm_credit_access c ON f.farm_uid = c.farm_uid
        GROUP BY 1, 2
    ),
    totals AS (
        SELECT received_loan, SUM(total_farms) AS total
        FROM counts
        GROUP BY 1
    ),
    rel AS (
        SELECT 
            c.index_score,
            c.received_loan,
            ROUND(c.total_farms * 100.0 / t.total, 2) AS pct
        FROM counts c
        JOIN totals t ON c.received_loan = t.received_loan
    )
    SELECT 
        CAST(index_score AS VARCHAR) AS index_score,
        MAX(CASE WHEN received_loan THEN pct END) AS financiadas,
        MAX(CASE WHEN NOT received_loan THEN pct END) AS no_financiadas
    FROM rel
    GROUP BY index_score
    ORDER BY CAST(index_score AS INT) ASC
) TO 'paper/data/fig5_complejidad.csv' (HEADER, DELIMITER ',');

-- Fig 6: Vocation Transition (Full Land Use Proportions)
COPY (
    WITH base AS (
        SELECT 
            c.received_loan,
            ROUND(AVG(f.ratio_mz_permanent_crops) * 100.0, 1) AS avg_permanent,
            ROUND(AVG(f.ratio_mz_annual_crops) * 100.0, 1) AS avg_annual,
            ROUND(AVG(f.ratio_mz_natural_pasture) * 100.0, 1) AS avg_pasture_nat,
            ROUND(AVG(f.ratio_mz_cultivated_pasture) * 100.0, 1) AS avg_pasture_cult,
            ROUND(AVG(f.ratio_mz_forest) * 100.0, 1) AS avg_forest
        FROM farms f
        JOIN farm_credit_access c ON f.farm_uid = c.farm_uid
        WHERE f.total_area_mz > 0
        GROUP BY 1
    )
    SELECT 
        'Cultivos Anuales' AS rubro,
        MAX(CASE WHEN received_loan THEN avg_annual END) AS financiadas,
        MAX(CASE WHEN NOT received_loan THEN avg_annual END) AS no_financiadas,
        1 AS orden
    FROM base
    UNION ALL
    SELECT 
        'Cultivos Permanentes' AS rubro,
        MAX(CASE WHEN received_loan THEN avg_permanent END) AS financiadas,
        MAX(CASE WHEN NOT received_loan THEN avg_permanent END) AS no_financiadas,
        2 AS orden
    FROM base
    UNION ALL
    SELECT 
        'Pasto Natural' AS rubro,
        MAX(CASE WHEN received_loan THEN avg_pasture_nat END) AS financiadas,
        MAX(CASE WHEN NOT received_loan THEN avg_pasture_nat END) AS no_financiadas,
        3 AS orden
    FROM base
    UNION ALL
    SELECT 
        'Pasto Cultivado' AS rubro,
        MAX(CASE WHEN received_loan THEN avg_pasture_cult END) AS financiadas,
        MAX(CASE WHEN NOT received_loan THEN avg_pasture_cult END) AS no_financiadas,
        4 AS orden
    FROM base
    UNION ALL
    SELECT 
        'Bosques y Tacotales' AS rubro,
        MAX(CASE WHEN received_loan THEN avg_forest END) AS financiadas,
        MAX(CASE WHEN NOT received_loan THEN avg_forest END) AS no_financiadas,
        5 AS orden
    FROM base
    ORDER BY orden ASC
) TO 'paper/data/fig6_vocacion.csv' (HEADER, DELIMITER ',');
