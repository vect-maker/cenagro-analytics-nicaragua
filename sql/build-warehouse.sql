BEGIN;
-- 1. Base Fact (Physicalized into DuckDB)
CREATE OR REPLACE TABLE farms AS SELECT * FROM read_parquet('data/farms.parquet');

-- 2. Dimensions (Physicalized into DuckDB)
CREATE OR REPLACE TABLE dim_producer_gender AS SELECT * FROM read_csv_auto('mappings/gender.csv');
CREATE OR REPLACE TABLE dim_operational_structure AS SELECT * FROM read_csv_auto('mappings/operational_structure.csv');
CREATE OR REPLACE TABLE dim_principal_activity AS SELECT * FROM read_csv_auto('mappings/principal_activity.csv');
CREATE OR REPLACE TABLE dim_municipality AS SELECT * FROM read_csv_auto('mappings/municipality.csv');
CREATE OR REPLACE TABLE dim_department AS SELECT * FROM read_csv_auto('mappings/department.csv');

-- 3. Vertical Partitions (Domain Marts)
CREATE OR REPLACE VIEW farm_credit_access AS
SELECT 
    farm_uid,
    farm_size_class,
    department,
    municipality,
    has_any_loan,
    requested_loan,
    received_loan,
    loan_banco, loan_banco_produzcamos, loan_ong, loan_cooperativa, 
    loan_gobierno, loan_comercial, loan_prestamista, loan_acopiador, loan_otro,
    req_crop, req_livestock, req_aquaculture, req_forestry,
    rec_crop, rec_livestock, rec_aquaculture, rec_forestry
FROM farms;

CREATE OR REPLACE VIEW farm_labor AS
SELECT 
    farm_uid,
    farm_size_class,
    department,
    municipality,
    hired_workers,
    permanent_workers_total,
    temporal_workers_total,
    labor_intensity,
    permanent_labor_ratio
FROM farms;

CREATE OR REPLACE VIEW farm_land_use AS
SELECT 
    farm_uid,
    farm_size_class,
    department,
    municipality,
    total_area_mz,
    total_parcels,
    mz_annual_crops,
    mz_permanent_crops,
    mz_cultivated_pasture,
    mz_natural_pasture,
    mz_fallow,
    mz_forest,
    mz_infrastructure,
    mz_unusable
FROM farms;

CREATE OR REPLACE VIEW farm_profiles AS
SELECT 
    farm_uid,
    farm_size_class,
    department,
    municipality,
    producer_gender,
    operational_structure,
    principal_activity,
    total_area_mz
FROM farms;

CREATE OR REPLACE VIEW farm_technology AS
SELECT 
    farm_uid,
    farm_size_class,
    department,
    municipality,
    has_irrigation_system,
    traction_animal,
    traction_tractor
FROM farms;

COMMIT;
