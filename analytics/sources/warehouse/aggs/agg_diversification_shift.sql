SELECT 
    c.received_loan,
    CAST(f.diversification_index AS INT) AS index_score,
    COUNT(*) as total_farms
FROM warehouse.farms f
JOIN warehouse.farm_credit_access c ON f.farm_uid = c.farm_uid
GROUP BY 1, 2
ORDER BY c.received_loan, index_score;