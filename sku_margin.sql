WITH 
t_loan AS (
    SELECT 
        sku_type,
        financing_amount,
        COUNT(loan_id) AS total_loans,
        SUM(cast(replace(margin, '.', '') as integer)) AS total_margin,
        AVG(cast(replace(margin, '.', '') as integer)) AS avg_margin
    FROM financing_loan
    GROUP BY 1,2
)
SELECT 
    sku_type, 
    financing_amount, 
    total_loans, 
    total_margin, 
    avg_margin
FROM t_loan
WHERE (sku_type, total_margin) IN (
    SELECT sku_type, MAX(total_margin)
    FROM t_loan
    GROUP BY 1
)
ORDER BY 1