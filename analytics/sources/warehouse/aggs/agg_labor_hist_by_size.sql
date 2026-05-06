WITH raw_data AS (
    SELECT 
        farm_size_class,
        LOG10(labor_intensity + 1) AS log_intensity
    FROM farms
    WHERE labor_intensity > 0.0
)

SELECT 
    farm_size_class,
    ROUND(log_intensity, 1) AS bin_start,
    COUNT(*) AS frequency
FROM raw_data
GROUP BY 1, 2
ORDER BY farm_size_class, bin_start;