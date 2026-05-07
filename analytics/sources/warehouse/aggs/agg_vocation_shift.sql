SELECT 
    c.received_loan,
    AVG(f.mz_permanent_crops / f.total_area_mz) AS avg_ratio_permanent_crops,
    AVG(f.mz_natural_pasture / f.total_area_mz) AS avg_ratio_natural_pasture,
    AVG(f.pasture_to_crop_ratio) AS avg_pasture_to_crop_ratio
FROM warehouse.farms f
JOIN warehouse.farm_credit_access c ON f.farm_uid = c.farm_uid
WHERE f.total_area_mz > 0
GROUP BY 1;