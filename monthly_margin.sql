SELECT 
    sku_type,
    financing_amount,
    SUM(CASE WHEN transaction_month::DATE = '2024-01-01' THEN CAST(REPLACE(margin, '.', '') AS INTEGER) ELSE 0 END) AS total_margin_jan,
    SUM(CASE WHEN transaction_month::DATE = '2024-02-01' THEN CAST(REPLACE(margin, '.', '') AS INTEGER) ELSE 0 END) AS total_margin_feb,
    SUM(CASE WHEN transaction_month::DATE = '2024-03-01' THEN CAST(REPLACE(margin, '.', '') AS INTEGER) ELSE 0 END) AS total_margin_mar,
    SUM(CASE WHEN transaction_month::DATE = '2024-04-01' THEN CAST(REPLACE(margin, '.', '') AS INTEGER) ELSE 0 END) AS total_margin_apr,
    SUM(CASE WHEN transaction_month::DATE = '2024-05-01' THEN CAST(REPLACE(margin, '.', '') AS INTEGER) ELSE 0 END) AS total_margin_may,
    SUM(CASE WHEN transaction_month::DATE = '2024-06-01' THEN CAST(REPLACE(margin, '.', '') AS INTEGER) ELSE 0 END) AS total_margin_jun,
    SUM(
        CASE 
            WHEN transaction_month::DATE IN ('2024-01-01', '2024-02-01', '2024-03-01', '2024-04-01', '2024-05-01', '2024-06-01') 
            THEN CAST(REPLACE(margin, '.', '') AS INTEGER) 
            ELSE 0 
        END
    ) AS grand_total_margin
FROM 
    newtable
WHERE 
    transaction_month::DATE IN ('2024-01-01', '2024-02-01', '2024-03-01', '2024-04-01', '2024-05-01', '2024-06-01')
GROUP BY 
    1,2
ORDER by 1 
