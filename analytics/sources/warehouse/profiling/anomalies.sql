SELECT 
    MIN(total_area_mz) AS min_area,
    MAX(total_area_mz) AS max_area,
    MIN(labor_intensity) AS min_intensity,
    MAX(labor_intensity) AS max_intensity,
    COUNT(*) FILTER (WHERE total_area_mz = 0 AND permanent_workers_total > 0) AS anomaly_workers_no_land
FROM farms;