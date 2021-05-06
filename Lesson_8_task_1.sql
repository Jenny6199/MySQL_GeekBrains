-- Задача №1 Определить кто поставил больше лайков мужчины или женщины
--     задача должна быть решена с использованием JOIN.

-- Исследую таблицы
DESC profiles;
DESC likes;
DESC users;

-- Формирую запрос на получение пола пользователя и подсчет лайков из результирующей таблицы 
-- полученной при слиянии трех таблиц  users, profiles, likes с условиями равенства id пользователя в каждой из них,
-- затем группирую полученные данные по полу и получаю требуемый результат.
SELECT
	profiles.gender,
	COUNT(likes.created_at) AS number_of_likes
	FROM users 
	LEFT JOIN profiles
		ON profiles.user_id = users.id
	LEFT JOIN likes
		ON likes.user_id = users.id
	GROUP BY profiles.gender;

-- end
