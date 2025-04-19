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



