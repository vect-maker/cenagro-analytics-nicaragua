SELECT 
    CASE 
        WHEN mz_annual_crops = 0 AND mz_permanent_crops = 0 AND (mz_cultivated_pasture > 0 OR mz_natural_pasture > 0) THEN 'Pure Livestock'
        WHEN (mz_cultivated_pasture = 0 AND mz_natural_pasture = 0) AND (mz_annual_crops > 0 OR mz_permanent_crops > 0) THEN 'Pure Agriculture'
        WHEN pasture_to_crop_ratio > 1 THEN 'Mixed - Livestock Dominant'
        WHEN pasture_to_crop_ratio < 1 THEN 'Mixed - Agriculture Dominant'
        ELSE 'Balanced / Other'
    END AS economic_vocation,
    COUNT(*) AS total_farms
FROM farms
GROUP BY 1;