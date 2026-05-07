SELECT
    farm_size_class,
    quantile_cont(labor_intensity, 0.50) FILTER (WHERE received_loan = true) AS median_financed,
    quantile_cont(labor_intensity, 0.50) FILTER (WHERE received_loan = false) AS median_non_financed,
    (quantile_cont(labor_intensity, 0.50) FILTER (WHERE received_loan = true) - quantile_cont(labor_intensity, 0.50) FILTER (WHERE received_loan = false)) / NULLIF(quantile_cont(labor_intensity, 0.50) FILTER (WHERE received_loan = false), 0) AS relative_gap_pct
FROM farms
WHERE labor_intensity > 0.0
GROUP BY farm_size_class;