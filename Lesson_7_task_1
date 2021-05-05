-- Домашнее задание к уроку №7
-- Студент: Максим Сапунов Jenny6199@yandex.ru

-- ЗАДАЧА №1. Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.

-- Исследую таблицы
SHOW TABLES;

DESC users;
SELECT * FROM users;

DESC orders;
SELECT * FROM orders;

DESC products; 
SELECT * FROM products;

DESC orders_products; 
SELECT * FROM orders_products;


-- Таблицы оказались пустыми, заполняю их по материалам урока
INSERT INTO orders (user_id)
	SELECT id FROM users WHERE name = 'Геннадий';

INSERT INTO orders_products (order_id, product_id, total)
	SELECT LAST_INSERT_ID(), id, 2 FROM products
	WHERE name = 'Intel Core i5-7400';

INSERT INTO orders(user_id)
	SELECT id FROM users WHERE name = 'Наталья';

INSERT INTO orders_products (order_id , product_id, total)
	SELECT LAST_INSERT_ID(), id, 1 FROM products
	WHERE name IN ('Intel Core i5-7400', 'Gigabyte H310M S2H');

INSERT INTO orders(user_id)
	SELECT id FROM users WHERE name = 'Иван';

INSERT INTO orders_products (order_id , product_id, total)
	SELECT LAST_INSERT_ID(), id, 1 FROM products
	WHERE name IN ('AMD FX-8320', 'ASUS ROG MAXIMUS X HERO');


-- Формируем запрос на получение списка пользователей осуществляющих заказы.
SELECT 
	users.id, 
	users.name
	FROM 
		users
		INNER JOIN 
		orders
		ON
		users.id = orders.user_id;
