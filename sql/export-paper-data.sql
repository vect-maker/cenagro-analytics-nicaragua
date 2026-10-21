-- Export queries for paper figures into paper/data/

-- Fig 1: Credit Funnel
COPY (
    SELECT '1. Universo Total' AS stage, COUNT(*) AS farms FROM farm_credit_access
    UNION ALL
    SELECT '2. Solicitaron Crédito' AS stage, COUNT(*) FROM farm_credit_access WHERE requested_loan = true
    UNION ALL
    SELECT '3. Recibieron Crédito' AS stage, COUNT(*) FROM farm_credit_access WHERE received_loan = true
    ORDER BY stage ASC
) TO 'paper/data/fig1_funnel.csv' (HEADER, DELIMITER ',');

-- Fig 2: Sources of Financing
COPY (
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
    ORDER BY farms ASC
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

-- Fig 4: Labor Stability Distribution
COPY (
    WITH counts AS (
        SELECT 
            c.received_loan,
            CAST(FLOOR(l.permanent_labor_ratio * 10) / 10.0 AS DECIMAL(10,1)) AS ratio_bin,
            COUNT(*) AS frequency
        FROM farm_labor l
        JOIN farm_credit_access c ON l.farm_uid = c.farm_uid
        WHERE l.permanent_workers_total > 0 OR l.temporal_workers_total > 0
        GROUP BY 1, 2
    ),
    totals AS (
        SELECT received_loan, SUM(frequency) AS total
        FROM counts
        GROUP BY 1
    ),
    rel AS (
        SELECT 
            c.ratio_bin,
            c.received_loan,
            ROUND(c.frequency * 100.0 / t.total, 2) AS pct
        FROM counts c
        JOIN totals t ON c.received_loan = t.received_loan
    )
    SELECT 
        CAST(ratio_bin AS VARCHAR) AS ratio_bin,
        MAX(CASE WHEN received_loan THEN pct END) AS financiadas,
        MAX(CASE WHEN NOT received_loan THEN pct END) AS no_financiadas
    FROM rel
    GROUP BY ratio_bin
    ORDER BY CAST(ratio_bin AS FLOAT) ASC
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

-- Fig 6: Vocation Transition (Land Use Proportions)
COPY (
    WITH base AS (
        SELECT 
            c.received_loan,
            ROUND(AVG(f.mz_permanent_crops / f.total_area_mz) * 100.0, 2) AS avg_ratio_permanent_crops,
            ROUND(AVG(f.mz_natural_pasture / f.total_area_mz) * 100.0, 2) AS avg_ratio_natural_pasture
        FROM farms f
        JOIN farm_credit_access c ON f.farm_uid = c.farm_uid
        WHERE f.total_area_mz > 0
        GROUP BY 1
    )
    SELECT 
        'Cultivos Permanentes' AS rubro,
        MAX(CASE WHEN received_loan THEN avg_ratio_permanent_crops END) AS financiadas,
        MAX(CASE WHEN NOT received_loan THEN avg_ratio_permanent_crops END) AS no_financiadas
    FROM base
    UNION ALL
    SELECT 
        'Pasto Natural' AS rubro,
        MAX(CASE WHEN received_loan THEN avg_ratio_natural_pasture END) AS financiadas,
        MAX(CASE WHEN NOT received_loan THEN avg_ratio_natural_pasture END) AS no_financiadas
    FROM base
) TO 'paper/data/fig6_vocacion.csv' (HEADER, DELIMITER ',');
