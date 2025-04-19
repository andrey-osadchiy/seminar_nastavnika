-- Запросы по заданию 2

-- создание и заполнение таблиц данными
CREATE TABLE orders
(
    order_id UInt32, 
    user_id UInt32, 
    order_date DateTime, 
    total_amount Float32, 
    payment_status String
)
ENGINE = MergeTree()
ORDER BY (order_date, order_id);

INSERT INTO orders SELECT *
FROM url('https://storage.yandexcloud.net/hw1/orders.csv', 'CSVWithNames', 'order_id UInt32, user_id UInt32, order_date DateTime, total_amount Float32, payment_status String') ;

CREATE TABLE order_items
(
    item_id UInt32, 
    order_id UInt32, 
    product_name String, 
    product_price Float32, 
    quantity UInt32
)
ENGINE = MergeTree()
ORDER BY (order_id, item_id);

INSERT INTO order_items SELECT *
FROM url('https://storage.yandexcloud.net/hw1/order_items.txt', 'CSVWithNames', 'item_id UInt32, order_id UInt32, product_name String, product_price Float32, quantity UInt32') 
SETTINGS format_csv_delimiter = ';';


-- запросы
-- Группировка по payment_status: подсчитываем количество заказов, сумму (total_amount), среднюю стоимость заказа:
SELECT 
    payment_status, 
    COUNT() AS order_count, 
    SUM(total_amount) AS total_sum, 
    ROUND(AVG(total_amount), 2) AS avg_order_amount
FROM orders 
GROUP BY payment_status
ORDER BY total_sum DESC;

-- JOIN с order_items: подсчитать общее количество товаров, общую сумму, среднюю цену за продукт: 
SELECT 
    o.order_id, 
    COUNT(i.item_id) AS items_count, 
    SUM(i.product_price * i.quantity) AS items_total, 
    ROUND(SUM(i.product_price * i.quantity) / SUM(i.quantity), 2) AS avg_item_price
FROM orders AS o 
INNER JOIN order_items AS i ON o.order_id = i.order_id
GROUP BY o.order_id
ORDER BY items_total DESC;

-- Отдельно посмотреть статистику по датам (количество заказов и их суммарная стоимость за каждый день):
SELECT 
    toDate(order_date) AS day, 
    COUNT() AS orders_count, 
    SUM(total_amount) AS daily_total
FROM orders 
GROUP BY day
ORDER BY day ASC

--Выделить «самых активных» пользователей (по сумме заказов или по количеству заказов:
SELECT 
    user_id, 
    SUM(total_amount) AS total_spent, 
    COUNT() AS orders_count
FROM orders 
GROUP BY user_id
ORDER BY total_spent DESC
LIMIT 5
