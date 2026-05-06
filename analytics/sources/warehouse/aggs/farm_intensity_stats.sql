SELECT 
   farm_size_class,
    AVG(labor_intensity) AS avg_intensity,
    MEDIAN(labor_intensity) AS median_intensity,
    MAX(labor_intensity) AS max_intensity,
    COUNT(*) AS farm_count
FROM farms
GROUP BY 1;