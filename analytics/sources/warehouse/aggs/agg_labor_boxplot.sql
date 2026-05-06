SELECT 
    farm_size_class,
    MIN(LOG10(labor_intensity + 1)) AS log_min,
    quantile_cont(LOG10(labor_intensity + 1), 0.25) AS log_q1,
    quantile_cont(LOG10(labor_intensity + 1), 0.50) AS log_median,
    quantile_cont(LOG10(labor_intensity + 1), 0.75) AS log_q3,
    MAX(LOG10(labor_intensity + 1)) AS log_max
FROM farm_labor
WHERE labor_intensity > 0.0
GROUP BY 1
ORDER BY 
    CASE farm_size_class 
        WHEN 'Micro' THEN 1 
        WHEN 'Small' THEN 2 
        WHEN 'Medium/Large' THEN 3 
    END;
