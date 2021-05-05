-- ДОМАШНЕЕ ЗАДАНИЕ К 4-му УРОКУ MYSQL CRUD-операции:
-- АВТОР: Максим Сапунов
-- 21/04/2021

-- РЕЗЮМЭ: в данном уроке мы изучили новые команды для работы с таблицами в базах данных,
-- научились формировать запросы для создания, редактирования, удаления данных в таблицах.
-- ниже приведен код с помощью которого мы редактировали нашу тестовую базу данных.

-- ВЫБИРАЕМ БАЗУ ДАННЫХ И ПРОСМАТРИВАЕМ ТАБЛИЦЫ
USE vk;
SHOW TABLES;


-- РЕДАКТИРУЕМ ТАБЛИЦУ ПОЛЬЗОВАТЕЛЕЙ
SELECT * FROM users lIMIT 20;
UPDATE users SET updated_at = NOW() WHERE updated_at < created_at;


-- РЕДАКТИРУЕМ ТАБЛИЦУ ПРОФИЛЕЙ
DESC profiles;
SELECT * FROM profiles LIMIT 20;
UPDATE profiles SET updated_at = NOW() WHERE updated_at < created_at;
CREATE TEMPORARY TABLE gender_type (types VARCHAR(5));
INSERT INTO gender_type VALUES ("m"), ("f");
SELECT * FROM gender_type;
UPDATE profiles SET gender = (SELECT types FROM gender_type ORDER BY RAND() LIMIT 1);
-- 		изменяем тип столбца на тип ENUM
ALTER TABLE profiles MODIFY COLUMN gender ENUM("m", "f");


-- РЕДАКТИРУЕМ ТАБЛИЦУ СООБЩЕНИЙ
DESC messages;
SELECT * FROM messages LIMIT 10;
SELECT Floor(1+RAND()*100);
UPDATE messages SET
	from_user_id = FLOOR() (1+RAND()*100),
	to_user_id  = FLOOR(1+RAND()*100);


-- РЕДАКТИРУЕМ ТАБЛИЦУ ТИПОВ МЕДИАФАЙЛОВ
DESC media_types;
SELECT * FROM media_types LIMIT 10;
DELETE FROM media_types;
INSERT INTO media_types (name) VALUES
	('photo'),
	('video'),
	('audio');
-- 		сбросить счетчик инкремента
TRUNCATE media_types;


-- РЕДАКТИРУЕМ ТАБЛИЦУ МЕДИА
DESC media;
SELECT * FROM media LIMIT 10;
UPDATE media SET media_type_id  = FLOOR(1 + RAND()*3); 
-- 		редактируем данные в столбце метадата - создаем запрос на формирование строки
UPDATE media SET metadata = CONCAT(
	'{"owner":"',
	(SELECT CONCAT(first_name, ' ', last_name) FROM users WHERE id = user_id),
	'"}');
UPDATE media SET size = FLOOR(10000 + RAND() * 10000000) WHERE size < 10000;
SELECT name FROM media_types ORDER BY RAND() LIMIT 1;
-- 		создаем временную таблицу для хранения расширений
CREATE TEMPORARY TABLE extentions (name VARCHAR(10));
INSERT INTO extentions VALUES ('mp3'), ('mp4'), ('wma'), ('jpeg'), ('avi'), ('mpeg');
SELECT * FROM extentions;
-- 		редактируем данные в столбце имя файла - создаем запрос на формирование строки
UPDATE media SET filename = CONCAT( 
	'https://disk.yandex.ru/id678456/vk/',
	filename,
	'.',
	(SELECT name FROM extentions ORDER BY RAND() LIMIT 1));
-- 		редактируем данные в столбце user_id 
UPDATE media SET user_id = FLOOR(1+RAND()*100);
-- 		изменяем тип столбца
ALTER TABLE media MODIFY COLUMN metadata JSON;


-- РЕДАКТИРУЕМ ТАБЛИЦУ ДРУЖБЫ
DESC friendship;
SELECT * FROM friendship LIMIT 100;
-- 		удаляем столбец из таблицы по имени столбца
ALTER TABLE friendship DROP COLUMN requested_at;
UPDATE friendship SET
	friend_id = FLOOR(1 + RAND() * 100),
	user_id = FLOOR(1 + RAND() * 100);
UPDATE friendship SET
	friendship_status_id = FLOOR(1 + RAND() * 3); 


-- РЕДАКТИРУЕМ ТАБЛИЦУ СТАТУСОВ ДРУЖБЫ
DESC friendship_statuses;
SELECT * FROM friendship_statuses LIMIT 10;
TRUNCATE friendship_statuses;
INSERT INTO friendship_statuses (name) VALUES
	('Requested'),
	('Confirmed'),
	('Rejected');


-- РЕДАКТИРУЕМ ТАБЛИЦУ НАЗВАНИЙ СООБЩЕСТВ
DESC communities;
SELECT * FROM communities LIMIT 20;
 DELETE FROM communities WHERE id > 15; 
-- при генерации таблицы счетчик начинался с 201, пришлось переделывать "с нуля", создал группы "вручную"
TRUNCATE communities;
INSERT INTO communities (name) VALUES
	('Diving'),
	('Tennis'),
	('Moto'),
	('Auto'),
	('Hunter'),
	('Swimming'),
	('Bycicle'),
	('Disign'),
	('Bodybilding'),
	('Radio'),
	('Sailing'),
	('IT'),
	('Tourism'),
	('Bar_reviewers'),
	('Hotels');



-- РЕДАКТИРУЕМ ТАБЛИЦУ СООБЩЕСТВ ПОЛЬЗОВАТЕЛЕЙ
DESC communities_users;
SELECT * FROM communities_users;
TRUNCATE communities_users;
-- все заново пересоздал так как при геренации таблицы и требовались только уникальные значения.
ALTER TABLE communities_users DROP COLUMN community_id;
ALTER TABLE communities_users DROP COLUMN created_at;
ALTER TABLE communities_users DROP COLUMN user_id;

AlTER TABLE communities_users ADD COLUMN user_id INT;
AlTER TABLE communities_users ADD COLUMN community_id INT;
AlTER TABLE communities_users ADD COLUMN created_at DATETIME;

INSERT INTO communities_users 
	SELECT FLOOR(1 + RAND() * 15), FLOOR(1 + RAND() * 200), NOW()
		FROM messages;
	
  
  
-- ИЗУЧЕННЫЕ И ИСПОЛЬЗОВАННЫЕ НА УРОКЕ КОМАНДЫ И ВЫРАЖЕНИЯ:
	
-- USE
-- SHOW
-- DESC
-- SELECT
-- UPDATE 
-- TRUNCATE
-- ALTER TABLE
-- CREATE TEMPORARY TABLE
-- DROP COLLUMN
-- ADD COLLUMN
-- MODIFY COLLUMN
-- LIMIT
-- VALUES
-- FROM
-- SET
-- FLOOR
-- RAND
-- CONCAT 
