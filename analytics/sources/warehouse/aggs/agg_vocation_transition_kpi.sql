SELECT
    AVG(pasture_to_crop_ratio) FILTER (WHERE received_loan = true) AS avg_pasture_ratio_financed,
    AVG(pasture_to_crop_ratio) FILTER (WHERE received_loan = false) AS avg_pasture_ratio_non_financed,
    AVG(pasture_to_crop_ratio) FILTER (WHERE received_loan = true) - AVG(pasture_to_crop_ratio) FILTER (WHERE received_loan = false) AS vocation_shift_delta
FROM farms
WHERE total_area_mz > 0;