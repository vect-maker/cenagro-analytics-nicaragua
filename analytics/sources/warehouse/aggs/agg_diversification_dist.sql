SELECT 
    CAST(diversification_index AS INT) AS index_score,
    COUNT(*) AS total_farms
FROM farms
GROUP BY 1
ORDER BY 1;