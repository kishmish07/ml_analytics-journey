WITH features AS (
    SELECT
        customer_id,
        COUNT(DISTINCT invoice_no) AS number_of_orders,
        SUM(quantity * unit_price) AS revenue,
        SUM(quantity * unit_price) / COUNT(DISTINCT invoice_no) AS mean_check,
        DATEDIFF('2011-11-01', MAX(invoice_date)) AS days_from_purchase
    FROM online_retail
    WHERE invoice_date < '2011-11-01'
      AND customer_id IS NOT NULL
      AND quantity > 0
    GROUP BY customer_id
),

returned_customers AS (
    SELECT DISTINCT
        customer_id
    FROM online_retail
    WHERE invoice_date >= '2011-11-01'
      AND invoice_date < '2011-12-01'
      AND customer_id IS NOT NULL
)

SELECT
    f.customer_id,
    f.number_of_orders,
    f.revenue,
    f.mean_check,
    f.days_from_purchase,
    CASE
        WHEN r.customer_id IS NOT NULL THEN 1
        ELSE 0
    END AS target
FROM features f
LEFT JOIN returned_customers r
    ON f.customer_id = r.customer_id;
    

