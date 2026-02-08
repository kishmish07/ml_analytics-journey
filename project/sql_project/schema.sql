
---- Создаю таблицу для данных
CREATE TABLE IF NOT EXISTS online_retail (
    invoice_no   VARCHAR(20),
    stock_code   VARCHAR(20),
    description  TEXT,
    quantity     VARCHAR(50),
    invoice_date DATETIME,
    unit_price   DECIMAL(20,2),
    customer_id  VARCHAR(20),
    country      VARCHAR(50)
);
----- Создаю таблицу для очищенных данных с которой я после и буду работать
CREATE TABLE orders AS
SELECT
    invoice_no AS order_id,
    CAST(customer_id AS UNSIGNED) AS user_id,
    invoice_date AS order_date,
    quantity * unit_price AS amount,
    country
FROM online_retail
WHERE customer_id IS NOT NULL
  AND customer_id != ''
  AND quantity > 0
  AND unit_price > 0;