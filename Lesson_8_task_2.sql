-- Домашнее задание к уроку 8 MySQL
-- студент: Максим Сапунов Jenny6199@yandex.ru 06.05.2021

-- Задача №2. Подсчитать общее количество лайков десяти самым молодым пользователям 
-- (сколько лайков получили 10 самых молодых пользователей). Решение с помощью JOIN.

-- Исследую таблицы
DESC users; -- здесь нужно использовать id
DESC profiles; -- здесь нужно использовать birhday
DESC likes; -- здесь нужно использовать target_type

-- Формирую запрос получить строку содержащую id, фамилию, имя пользователя, день рождения, количество лайков
-- из результирующей таблицы полученной путем слияния таблиц users, profiles,  likes
-- с условием равенства в них users.id и target_type в таблице likes значению 'users' (лайк адресован пользователю)
-- далее группирую полученные данные по id пользователя, сортирую по дню рождения и указываю лимит 10 пользователей.
-- В итоге получаю требуемый результат.

SELECT 
	CONCAT(users.id, ' ', users.last_name, ' ', users.first_name) AS User_info,
	profiles.birthday,
 	COUNT(likes.created_at) AS Number_of_likes
 	FROM users
 		LEFT JOIN profiles
 			ON profiles.user_id = users.id
 		LEFT JOIN likes
 			ON likes.target_type = 'users' AND likes.target_id = users.id 
 	GROUP BY users.id
 	ORDER BY birthday DESC
 	LIMIT 10;
 
