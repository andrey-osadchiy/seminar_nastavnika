-- Запросы по заданию 1

-- создание и заполнение таблиц данными
CREATE EXTERNAL TABLE transactions_v2 (
transaction_id STRING,
user_id STRING,
transaction_date TIMESTAMP,
amount DECIMAL(10,2),
currency STRING,
is_fraud INT,
merchant_category STRING
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE
LOCATION 's3a://hw1/transactions/'; 

CREATE TABLE logs_v2 (
  log_id STRING,
  transaction_id STRING,
  log_time TIMESTAMP,
  action STRING,
  category STRING
);

-- запросы
-- Фильтрация «хороших» валют (USD, EUR, RUB), подсчёт суммарной суммы транзакций по каждой валюте:
SELECT currency, SUM(amount) as total_amount
FROM transactions_v2
WHERE currency IN ('USD', 'EUR', 'RUB')
GROUP BY currency;

-- Подсчёт количества мошеннических (is_fraud=1) и нормальных (is_fraud=0) транзакций, суммарной суммы и среднего чека:
SELECT is_fraud, COUNT(*) as count,
    SUM(amount) as total,
    AVG(amount) as avg_amount
FROM transactions_v2
GROUP BY is_fraud;

-- Группировка по датам с вычислением ежедневного количества транзакций, суммарного объёма и среднего amount: 
SELECT DATE(transaction_date) AS day,
COUNT(*) AS transactions_count,
SUM(amount) AS total_amount,
AVG(amount) AS avg_amount,
SUM(CASE WHEN is_fraud = 1 THEN 1 ELSE 0 END) AS fraud_count
FROM transactions_v2
GROUP BY DATE(transaction_date)
ORDER BY day;

-- Использование временных функций (например, извлечение дня/месяца из transaction_date) и анализ транзакций по временным интервалам:
 SELECT  MONTH(transaction_date) AS month, YEAR(transaction_date) AS year, COUNT(*) AS transactions_count
  FROM transactions_v2
  GROUP BY YEAR(transaction_date), MONTH(transaction_date)
  ORDER BY year, month;

--JOIN с таблицей logs_v2 по transaction_id, чтобы посчитать количество логов на одну транзакцию, выделить самые частые категории category:
--1
SELECT t.transaction_id, COUNT(l.log_id) AS logs_count
FROM transactions_v2 t
LEFT JOIN logs_v2 l ON t.transaction_id = l.transaction_id
GROUP BY t.transaction_id
ORDER BY logs_count DESC;
--2
SELECT 
  t.transaction_id,
  t.amount,
  t.currency,
  COUNT(l.log_id) AS logs_count,
  COLLECT_SET(l.category) AS categories
FROM transactions_v2 t
LEFT JOIN logs_v2 l ON t.transaction_id = l.transaction_id
GROUP BY t.transaction_id, t.amount, t.currency
ORDER BY logs_count DESC;
