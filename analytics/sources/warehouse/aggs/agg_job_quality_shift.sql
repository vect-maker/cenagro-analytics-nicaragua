SELECT 
    c.received_loan,
    CAST(FLOOR(l.permanent_labor_ratio * 10) / 10.0 AS DECIMAL(10,1)) AS ratio_bin,
    COUNT(*) AS frequency
FROM warehouse.farm_labor l
JOIN warehouse.farm_credit_access c ON l.farm_uid = c.farm_uid
WHERE l.permanent_workers_total > 0 OR l.temporal_workers_total > 0
GROUP BY 1, 2
ORDER BY c.received_loan, ratio_bin;