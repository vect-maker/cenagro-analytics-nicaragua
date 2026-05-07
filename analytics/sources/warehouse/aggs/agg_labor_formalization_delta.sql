SELECT
    AVG(permanent_labor_ratio) FILTER (WHERE received_loan = true) AS avg_ratio_financed,
    AVG(permanent_labor_ratio) FILTER (WHERE received_loan = false) AS avg_ratio_non_financed,
    AVG(permanent_labor_ratio) FILTER (WHERE received_loan = true) - AVG(permanent_labor_ratio) FILTER (WHERE received_loan = false) AS formalization_absolute_delta
FROM farms
WHERE (permanent_workers_total > 0 OR temporal_workers_total > 0);