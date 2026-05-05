SELECT 
    farm_uid,
    department,
    municipality,
    has_any_loan,
    requested_loan,
    received_loan,
    -- Sources
    loan_banco, loan_banco_produzcamos, loan_ong, loan_cooperativa, 
    loan_gobierno, loan_comercial, loan_prestamista, loan_acopiador, loan_otro,
    -- Requests vs Receipts
    req_crop, req_livestock, req_aquaculture, req_forestry,
    rec_crop, rec_livestock, rec_aquaculture, rec_forestry
FROM farms;