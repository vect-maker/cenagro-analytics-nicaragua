SELECT 
    COUNT(*) AS total_rows,
    COUNT(DISTINCT farm_uid) AS unique_farms,
    COUNT(*) - COUNT(DISTINCT farm_uid) AS potential_duplicates
FROM farms;