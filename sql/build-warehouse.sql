BEGIN;

CREATE OR REPLACE TABLE farms AS SELECT * FROM read_parquet('data/farms.parquet');
CREATE OR REPLACE TABLE dim_producer_gender AS SELECT * FROM read_csv_auto('mappings/gender.csv');
CREATE OR REPLACE TABLE dim_operational_structure AS SELECT * FROM read_csv_auto('mappings/operational_structure.csv');
CREATE OR REPLACE TABLE dim_principal_activity AS SELECT * FROM read_csv_auto('mappings/principal_activity.csv');
CREATE OR REPLACE TABLE dim_municipality AS SELECT * FROM read_csv_auto('mappings/municipality.csv');
CREATE OR REPLACE TABLE dim_department AS SELECT * FROM read_csv_auto('mappings/department.csv');

COMMIT;
