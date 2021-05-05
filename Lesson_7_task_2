-- Домашнее задание к уроку №7
-- Студент: Максим Сапунов Jenny6199@yandex.ru

-- ЗАДАЧА №2. Выведите список товаров products и разделов catalogs, который соответствует товару.

-- Исследую таблицы
DESC products;
DESC catalogs;
SELECT * FROM products;
SELECT * FROM catalogs;
-- В обеих таблицах искомые стобцы имеют одинаковое наименование name, использую allias и объединение таблиц
-- с последующей сортировкой по id; RIGHT JOIN - выдает строки с записями NULL.
SELECT 
	c.name AS 'Тип товара', 
	p.name AS 'Наименование',
	p.price AS 'Цена'
	FROM 
		products AS p 
		LEFT JOIN
		catalogs AS c
		ON p.catalog_id = c.id
		ORDER BY 'Тип товара';
