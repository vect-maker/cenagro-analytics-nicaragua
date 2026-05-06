SELECT 
    farm_size_class,
    CAST(FLOOR(permanent_labor_ratio * 10) / 10.0 AS DECIMAL(10,1)) AS bin_start,
    CAST((FLOOR(permanent_labor_ratio * 10) / 10.0) + 0.1 AS DECIMAL(10,1)) AS bin_end,
    COUNT(*) AS frequency
FROM farm_labor
WHERE permanent_workers_total > 0 OR temporal_workers_total > 0
GROUP BY 1, 2, 3
ORDER BY 1, 2;