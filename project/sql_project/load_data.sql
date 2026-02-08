-------- Загружаю датасет в MySql

LOAD DATA INFILE
'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/online_retail.csv'
INTO TABLE online_retail
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


------ В таблицу которую создал в schema добавляю очищенные данные и создаю таблицу по прицнипу 1 строка - 1 заказ
INSERT INTO orders (order_id, user_id, order_date, amount, country)
SELECT
    invoice_no,
    customer_id,
    invoice_date,
    SUM(unit_price),
    country
FROM online_retail
WHERE customer_id IS NOT NULL
  AND customer_id <> ''
GROUP BY
    invoice_no,
    customer_id,
    invoice_date,
    country;