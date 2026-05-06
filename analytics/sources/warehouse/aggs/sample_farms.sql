SELECT 
    department, 
    municipality, 
    operational_structure,
    principal_activity, 
    total_area_mz, 
    received_loan 
FROM warehouse.farms
ORDER BY census_segment_id ASC, farm_id ASC
LIMIT 10;