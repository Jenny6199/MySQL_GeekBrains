-- Домашнее задание к уроку №8 MySQL
-- студент: Максим Сапунов jenny6199@yandex.ru 06.05.2021

-- Задача № 3. Найти 10 пользователей, которые проявляют наименьшую активность в использовании социальной сети
-- Необходимо использовать решение с использованием JOIN.

-- Исследую таблицы
DESC users; -- здесь буду использовать столбец id для группировки данных, last_name, first_name для визуального оформления результатов вывода.
DESC likes; -- здесь буду подсчитывать количестов лайков которые поставил пользователь по столбцу user_id
DESC messages; -- здесь буду подсчитывать количество сообщений которые послал пользователь по столбцу from_user_id

-- Формирую запрос
SELECT
	CONCAT(users.id, ' ', users.last_name, ' ', users.first_name) AS user_info,
	COUNT(likes.created_at) AS Number_of_likes,
	COUNT(messages.created_at) AS Number_of_messages
	FROM users 
		LEFT JOIN likes 
			ON likes.user_id = users.id
		LEFT JOIN messages 
			ON messages.from_user_id = users.id 
	GROUP BY users.id
	ORDER BY Number_of_likes DESC;
-- Получил данные в которых полностью совпадают значения количества лайков и количества сообщений

-- Ищу ошибку, тестирую таблицы более простыми запросами
SELECT 
	from_user_id, 
	COUNT(messages.created_at) AS Number_of_messages 
	FROM messages 
	GROUP BY from_user_id 
	ORDER BY Number_of_messages DESC;

SELECT COUNT(from_user_id) AS Number_of_messages FROM messages WHERE from_user_id = 40;
-- результат 4.

SELECT 
	likes.user_id, 
	COUNT(likes.created_at) AS Number_of_likes
	FROM likes 
	GROUP BY likes.user_id 
	ORDER BY Number_of_likes DESC;
	
SELECT COUNT(user_id) AS Number_of_likes FROM likes WHERE user_id = 40;
-- результат 2.

-- Исследую результат объединения таблиц применительно к конкретному пользователю.
SELECT
	*
	FROM users 
		LEFT JOIN likes 
			ON likes.user_id = users.id
		LEFT JOIN messages 
			ON messages.from_user_id = users.id
	WHERE users.id = 40;
-- результат 8 строк (4*2)	

-- Изменил запрос на формирование результирующего столбца total в котором вычисляю сумму лайков и сообщейний,
-- изменил параметры сортировки на сортировку по столбцу total
-- получил искомый результат, при использовании DESC в сортировке можно получить пользователей с максимальной активностью.
SELECT
	CONCAT(users.id, ' ', users.last_name, ' ', users.first_name) AS user_info,
	(COUNT(likes.created_at) + COUNT(messages.created_at)) AS total
	FROM users 
		LEFT JOIN likes 
			ON likes.user_id = users.id
		LEFT JOIN messages 
			ON messages.from_user_id = users.id 
	GROUP BY users.id
	ORDER BY total
	LIMIT 10;

					 
