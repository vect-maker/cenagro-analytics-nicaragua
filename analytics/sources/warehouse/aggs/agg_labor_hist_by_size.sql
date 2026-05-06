WITH raw_data AS (
    SELECT 
        farm_size_class,
        LOG10(labor_intensity + 1) AS log_intensity
    FROM farms
    WHERE labor_intensity > 0.0
)

SELECT 
    farm_size_class,
    CAST(FLOOR(log_intensity * 20) / 20.0 AS DECIMAL(10,2)) AS bin_start,
    CAST((FLOOR(log_intensity * 20) / 20.0) + 0.05 AS DECIMAL(10,2)) AS bin_end,
    COUNT(*) AS frequency
FROM raw_data
GROUP BY 1, 2, 3
ORDER BY farm_size_class, bin_start;