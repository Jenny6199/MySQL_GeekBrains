-- ДОМАШНЕЕ ЗАДАНИЕ К УРОКУ №5 MySQL.
-- Студент: Максим Сапунов Jenny6199@yandex.ru 26.04.2021

-- ЗАДАНИЕ № 1
-- Пусть в таблице users поля created_at и updated_at оказались незаполненными.
-- Заполните их текущими датой и временем.

CREATE DATABASE IF NOT EXISTS lesson_5;
USE lesson_5;

DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at DATETIME,
  updated_at DATETIME
) COMMENT = 'Покупатели';

INSERT INTO
  users (name, birthday_at, created_at, updated_at)
VALUES
  ('Геннадий', '1990-10-05', NULL, NULL),
  ('Наталья', '1984-11-12', NULL, NULL),
  ('Александр', '1985-05-20', NULL, NULL),
  ('Сергей', '1988-02-14', NULL, NULL),
  ('Иван', '1998-01-12', NULL, NULL),
  ('Мария', '2006-08-29', NULL, NULL);
 
-- РЕШЕНИЕ--------------------------------------------------
 
DESC users;
SELECT * FROM users;
-- Устанавливаем значение текущего времени, там где будут обнаружены нули
UPDATE users SET created_at = NOW() WHERE created_at = NULL; 
UPDATE users SET updated_at = NOW() WHERE updated_at = NULL;

-- Изменяем параметры столбцов created_at и updated_at
ALTER TABLE users MODIFY COLUMN created_at DATETIME NOT NULL;
ALTER TABLE users MODIFY COLUMN updated_at DATETIME NOT NULL;

-- ----------------------------------------------------------------------------------- 

-- ЗАДАНИЕ № 2
-- Таблица users была неудачно спроектирована.
-- Записи created_at и updated_at были заданы типом VARCHAR и в них долгое время помещались
-- значения в формате "20.10.2017 8:10".
-- Необходимо преобразовать поля к типу DATETIME, сохранив введеные ранее значения.

DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at VARCHAR(255),
  updated_at VARCHAR(255)
) COMMENT = 'Покупатели';

INSERT INTO
  users (name, birthday_at, created_at, updated_at)
VALUES
  ('Геннадий', '1990-10-05', '07.01.2016 12:05', '07.01.2016 12:05'),
  ('Наталья', '1984-11-12', '20.05.2016 16:32', '20.05.2016 16:32'),
  ('Александр', '1985-05-20', '14.08.2016 20:10', '14.08.2016 20:10'),
  ('Сергей', '1988-02-14', '21.10.2016 9:14', '21.10.2016 9:14'),
  ('Иван', '1998-01-12', '15.12.2016 12:45', '15.12.2016 12:45'),
  ('Мария', '2006-08-29', '12.01.2017 8:56', '12.01.2017 8:56');
 
 -- РЕШЕНИЕ--------------------------------------------------
 
DESC users;
SELECT * FROM users;
-- создаем временные столбцы с правильными параметрами
ALTER TABLE users ADD COLUMN temp_copy_of_created_at DATETIME;
ALTER TABLE users ADD COLUMN temp_copy_of_updated_at DATETIME;

-- копируем занчения в данныe столбцы из таблицы created_at
UPDATE users SET 
temp_copy_of_created_at = STR_TO_DATE(created_at, '%d.%m.%Y %H:%i'),
temp_copy_of_updated_at = STR_TO_DATE(created_at, '%d.%m.%Y %H:%i');

-- удаляем столбцы с created_at и  updated_at
ALTER TABLE users DROP COLUMN created_at;
ALTER TABLE users DROP COLUMN updated_at;

-- переименовываем временные столбцы
ALTER TABLE users CHANGE temp_copy_of_created_at created_at DATETIME;
ALTER TABLE users CHANGE temp_copy_of_updated_at updated_at DATETIME;

-- ----------------------------------------------------------------------------------- 


-- ЗАДАНИЕ № 3
-- В таблице складских запасов storehouses_products в поле value могут встречаться самые
-- разные цифры: 0, если товар закончился и выше нуля, если на складе имеются запасы.
-- Необходимо отсортировать записи таким образом, чтобы они выводились в порядке увеличения
-- значения value. Однако, нулевые запасы должны выводиться в конце, после всех записей.
USE lesson_5;
DROP TABLE IF EXISTS storehouses_products;
CREATE TABLE storehouses_products (
  id SERIAL PRIMARY KEY,
  storehouse_id INT UNSIGNED,
  product_id INT UNSIGNED,
  value INT UNSIGNED COMMENT 'Запас товарной позиции на складе',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Запасы на складе';

INSERT INTO
  storehouses_products (storehouse_id, product_id, value)
VALUES
  (1, 543, 0),
  (1, 789, 2500),
  (1, 3432, 0),
  (1, 826, 30),
  (1, 719, 500),
  (1, 638, 1);
 
 
-- РЕШЕНИЕ--------------------------------------------------

DESC storehouses_products;
-- 1 Сортировка по убыванию.
SELECT * FROM storehouses_products ORDER BY value DESC;
-- 2 Сортировка с условием
SELECT * FROM storehouses_products ORDER BY value=0, value;
SELECT * FROM storehouses_products ORDER BY IF(value > 0, 0, 1), value;

-- ----------------------------------------------------------------------------------- 


-- ЗАДАНИЕ № 4
-- (по желанию) Из таблицы users необходимо извлечь пользователей, родившихся в
-- августе и мае. Месяцы заданы в виде списка английских названий ('may', 'august')

-- Таблица users создана для задания 2 темы Операции

-- РЕШЕНИЕ 1 --(решал не изучив функцию DATE_FORMAT)------------------------------------------------
USE lesson_5;
DESC users;
-- Создаю временную таблицу для интерпретации месяца в строковом представлении
CREATE TEMPORARY TABLE mounth_interpreter (
id INT,
mounth VARCHAR(10)
);
-- ... заполняю ее значениями,
INSERT INTO mounth_interpreter
VALUES
(01, 'janvary'),
(02, 'febrary'),
(03, 'march'),
(04, 'april'),
(05, 'may'),
(06, 'june'),
(07, 'jule'),
(08, 'august'),
(09, 'september'),
(10, 'october'),
(11, 'november'),
(12, 'december');
-- В таблице users создаю дополнительный столбец...
ALTER TABLE users ADD COLUMN birthday_mounth VARCHAR(10);
-- ... который заполняю данными из временной таблицы соотнося их со столбцом birthday_at
UPDATE users SET birthday_mounth = (SELECT mounth FROM mounth_interpreter WHERE id = MONTH(users.birthday_at));
-- с помощью регулярного выражения выбираю пользователей родившихся в мае и августе
SELECT name, birthday_at, birthday_mounth FROM users WHERE birthday_at RLIKE '-0[5,8]-';


-- РЕШЕНИЕ 2 --------------------------------------------------
SELECT * FROM users WHERE DATE_FORMAT(birthday_at, '%M') IN ('may', 'august'); 
-- ----------------------------------------------------------------------------------- 


-- ЗАДАНИЕ № 5
-- (по желанию) Из таблицы catalogs извлекаются записи при помощи запроса.
-- SELECT * FROM catalogs WHERE id IN (5, 1, 2);
-- Отсортируйте записи в порядке, заданном в списке IN.

DROP TABLE IF EXISTS catalogs;
CREATE TABLE catalogs (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100) NOT NULL
) COMMENT = 'Каталог';

INSERT INTO catalogs VALUES
  (NULL, 'Процессоры'),
  (NULL, 'Материнские платы'),
  (NULL, 'Видеокарты'),
  (NULL, 'Жесткие диски'),
  (NULL, 'Оперативная память');
 
 -- РЕШЕНИЕ--------------------------------------------------
SELECT * FROM catalogs;
SELECT * FROM catalogs WHERE id IN (5, 1, 2) ORDER BY FIELD(id, 5, 1, 2);



-- Тема Агрегация, ЗАДАНИЕ № 1
-- Подсчитайте средний возраст пользователей в таблице users
-- Таблица users создана для задания 2 темы Операции

 -- РЕШЕНИЕ --------------------------------------------------
USE lesson_5;
DESC users;
SELECT * FROM users;
ALTER TABLE users ADD COLUMN age INT;
UPDATE users SET age = TIMESTAMPDIFF(YEAR, birthday_at, NOW());
SELECT AVG(age) FROM users;
	  

-- Тема Агрегация, ЗАДАНИЕ № 2
-- Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели.
-- Следует учесть, что необходимы дни недели текущего года, а не года рождения.

-- Таблица users создана для задания 2 темы Операции

SELECT
	DATE_FORMAT(DATE(CONCAT_WS('-', YEAR(NOW()), MONTH(birthday_at), DAY(birthday_at))), '%W') AS day,
	COUNT(*) AS total
	FROM 
		users
	GROUP BY
		day
	ORDER BY 
		total DESC;



-- Тема Агрегация, задание 3
-- (по желанию) Подсчитайте произведение чисел в столбце таблицы

-- Используйте таблицу catalogs, созданную для задания 5 темы Операции

SELECT * FROM catalogs;
SELECT count(id) from catalogs;

SELECT ROUND(EXP(SUM(LN(id)))) FROM catalogs;

SELECT ln(id) from catalogs;


-- ПРОРАБОТКА ИЗУЧЕННЫХ НА УРОКЕ ФУНКЦИЙ И КОММАНД

-- Агрегатные функции SQL
	SELECT SUM(id) FROM catalogs; 				-- возвращает сумму значений столбца таблицы базы данных.
	SELECT MIN(id) FROM catalogs; 				-- возвращает минимальное среди всех значений столбца.
	SELECT MAX(id) FROM catalogs; 				-- возвращает максимальное значение среди всех значений столбца.
	SELECT AVG(id) FROM catalogs; 				-- возвращает среднее значение среди всех значений столбца.
	COUNT						  				-- возвращает количество записей таблицы базы данных.
	GROUP BY					  				-- служит для группировки результирующих значений по столбцам таблицы базы данных.

-- Операторы сравнения MySQL
	-- =, <=>, <>, !=, >, >=, <, <= возвращают FALSE 0 или TRUE 1.
	
-- Также использованы функции
	DISTINCT 					  				-- используется для удаления дубликатов из набора результатов.
	
	TIMESTAMPDIFF(arg, startdate, enddate) 		-- вычисляет интервал времени между датами.
												-- (аргументы arg: yy, yyyy, qq, q, mm, m, dy, d, wr, ww, hh, mi, n, ss, s, ms).
	
	DATE_FORMAT(date, arg)  					-- преобразует дату в текстовый формат.
												-- (аргументы arg: %Y (%y), %M (%m - номер), %W, %D (%d - номер), %H - 24 (%I -12), %S вместе или по отдельности).
	FIELD										-- возвращает позицию значения в списке значений.
	CHANGE
	
	LIKE 										-- сопоставляет данные с шаблоном.
	RLIKE  										-- то же, но позволяет использовать регулярные выражения.
	BETWEEN  									-- используется для получения значений в пределах диапазона.
	IN 											-- определяет, соответствует ли значение или список значений выражению в указанном наборе.
	
	SELECT SUBSTR(name, 3, 10) FROM catalogs;	-- позволяет извлекать подстроку из строки синт.(строка, начало, длина).

	SELECT LOG(5); 								-- возвращает натуральный логарифм выражения, результат имеет тип float.
	SELECT LN(5);								-- возвращает натуральный логарифм числа.
	SELECT EXP(5);								-- экспонента - возвращает число e в степени заданным выражением.
	SELECT ROUND(5,23);							-- округление до целого числа.
