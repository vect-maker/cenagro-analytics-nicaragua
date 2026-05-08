

SELECT 
    CASE WHEN received_loan THEN 'Financed' ELSE 'Non-Financed' END AS cohort,
    COUNT(*) AS total_farms
FROM warehouse.farm_credit_access
GROUP BY 1
ORDER BY cohort;