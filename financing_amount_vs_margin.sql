WITH 
t_margin_defaulted AS (
    SELECT 
        sku_type
        , financing_amount
        , COUNT(loan_id) AS count_defaulted
        , SUM(CAST(REPLACE(margin, '.', '') AS INTEGER)) AS defaulted_margin
    FROM financing_loan
    WHERE repayment_status = 'defaulted'
    GROUP BY 1,2
),
t_margin_repaid AS (
    SELECT
        sku_type
        , financing_amount
        , COUNT(loan_id) AS count_repaid
        , SUM(CAST(REPLACE(margin, '.', '') AS INTEGER)) AS repaid_margin
    FROM financing_loan
    WHERE repayment_status = 'repaid'
    GROUP BY 1,2
),
t_sum_margin AS (
    SELECT 
        sku_type
        , financing_amount
        , COUNT(loan_id) AS total_count_financing
        , SUM(CAST(REPLACE(margin, '.', '') AS INTEGER)) AS total_margin
    FROM financing_loan
    GROUP BY 1,2
)

SELECT 
    a.sku_type, 
    a.financing_amount,
    COALESCE(b.count_defaulted, 0) AS count_defaulted,
    COALESCE(b.defaulted_margin, 0) AS defaulted_margin,
    COALESCE(c.count_repaid, 0) AS count_repaid,
    COALESCE(c.repaid_margin, 0) AS repaid_margin,
    a.total_count_financing,
    a.total_margin
--    RANK() OVER (ORDER BY a.total_margin DESC) AS margin_rank
FROM t_sum_margin AS a
LEFT JOIN t_margin_defaulted AS b 
    ON a.sku_type = b.sku_type AND a.financing_amount = b.financing_amount
LEFT JOIN t_margin_repaid AS c 
    ON a.sku_type = c.sku_type AND a.financing_amount = c.financing_amount
GROUP BY 1,2,7,8,3,4,5,6
ORDER BY 2 