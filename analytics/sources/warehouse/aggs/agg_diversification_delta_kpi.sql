SELECT
    quantile_cont(diversification_index, 0.50) FILTER (WHERE received_loan = true) AS median_div_financed,
    quantile_cont(diversification_index, 0.50) FILTER (WHERE received_loan = false) AS median_div_non_financed,
    AVG(diversification_index) FILTER (WHERE received_loan = true) - AVG(diversification_index) FILTER (WHERE received_loan = false) AS absolute_mean_shift
FROM farms;