SELECT 
    farm_size_class,
    COUNT(*) as total_farms,
    AVG(labor_intensity) AS avg_intensity,
    STDDEV(labor_intensity) AS std_dev,
    quantile_cont(labor_intensity, 0.25) AS p25,
    quantile_cont(labor_intensity, 0.50) AS median_intensity,
    quantile_cont(labor_intensity, 0.75) AS p75,
    MAX(labor_intensity) AS max_intensity,
    skewness(labor_intensity) AS asimetria
FROM farm_labor
WHERE labor_intensity > 0.0
GROUP BY 1
ORDER BY 
    CASE farm_size_class 
        WHEN 'Micro' THEN 1 
        WHEN 'Small' THEN 2 
        WHEN 'Medium/Large' THEN 3 
    END;