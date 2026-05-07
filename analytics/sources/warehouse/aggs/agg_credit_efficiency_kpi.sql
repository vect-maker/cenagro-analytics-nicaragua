SELECT
    SUM(CAST(received_loan AS INT)) AS total_received,
    SUM(CAST(requested_loan AS INT)) AS total_requested,
    SUM(CAST(received_loan AS INT)) * 1.0 / NULLIF(SUM(CAST(requested_loan AS INT)), 0) AS approval_efficiency
FROM farms;



