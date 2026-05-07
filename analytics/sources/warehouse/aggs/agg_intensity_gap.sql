SELECT 
    l.farm_size_class,
    c.received_loan,
    AVG(l.labor_intensity) AS avg_intensity,
    quantile_cont(l.labor_intensity, 0.50) AS median_intensity
FROM warehouse.farm_labor l
JOIN warehouse.farm_credit_access c ON l.farm_uid = c.farm_uid
WHERE l.labor_intensity > 0.0
GROUP BY 1, 2
ORDER BY 
    CASE l.farm_size_class 
        WHEN 'Micro' THEN 1 
        WHEN 'Small' THEN 2 
        WHEN 'Medium/Large' THEN 3 
    END, 
    c.received_loan;