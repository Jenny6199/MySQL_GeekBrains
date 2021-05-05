- Домашнее задание к уроку №7
-- Студент: Максим Сапунов Jenny6199@yandex.ru
	
-- ЗАДАЧА №3. (по желанию) Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label, name). Поля from, to и label содержат английские названия городов, поле name — русское. Выведите список рейсов flights с русскими названиями городов.

-- Создаю таблицы
CREATE TABLE flights (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	city_from VARCHAR(255),
	city_to VARCHAR(255));
CREATE TABLE cities (
	label VARCHAR(255),
	name VARCHAR(255));
-- Заполняю таблицы значениями
INSERT INTO flights
	VALUES
	(1, 'moscow', 'omsk'),
	(2, 'novgorod', 'kazan'),
	(3, 'irkutsk', 'moscow'),
	(4, 'omsk', 'irkutsk'),
	(5, 'moscow', 'kazan');
INSERT INTO cities
	VALUES
	('moscow', 'Москва'),
	('irkutsk', 'Иркутск'),
	('novgorod', 'Новгород'),
	('kazan', 'Казань'),
	('omsk', 'Омск');
	
SELECT * FROM flights;

-- Формируем запрос с использованием JOIN
SELECT * FROM flights, cities;

SELECT 
	label, 
	name 
	FROM 
		flights 
		INNER JOIN 
		cities 
		ORDER BY name;
    
-- Вначале пошел по по ложному пути
SELECT 
	Join_table.label
	FROM flights, cities as Join_table
	WHERE Join_table.name = 'Москва'
	LIMIT 1;

-- После нескольких неудачных попыток, подглядывал решение в разборе ДЗ.
SELECT 
	flights.id, 
	cf.name AS 'Отправление',
	ct.name AS 'Прибытие'
	FROM 
		flights 
		JOIN
		cities as cf
			ON flights.city_from = cf.label
		JOIN
		cities AS ct
			ON flights.city_to = ct.label
		ORDER BY id;
-- Учебные выводы сделал, сохранил, запомнил.
