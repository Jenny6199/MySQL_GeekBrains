-- ЗАДАЧА № 4 Подсчитать общее количество лайков, которые получили 10 самых молодых пользователей.
   
DESC likes;
DESC profiles;

-- Выбираем user_id самых молодых пользователей
SELECT 
	profiles.user_id 
	FROM profiles 
	ORDER BY birthday 
	DESC LIMIT 10;

-- Считаем количество лайков для конкретного пользователя
SELECT 
	COUNT(*) 
	FROM likes 
	WHERE 
		target_type = 'users' AND 
		target_id = 17;
	
-- Создаем вложенный запрос получаем столбец с самыми молодыми пользователями и количеством лайков.
SELECT 
	user_id, 
	(SELECT 
		COUNT(*) 
		FROM likes 
		WHERE 
			target_type = 'users' AND 
			target_id = profiles.user_id) AS count_of_likes
		FROM profiles
		ORDER BY profiles.birthday 
		DESC LIMIT 10;
	
-- Второй уровень вложенности для вычисления общей суммы лайков.
SELECT 
	SUM(count_of_likes)
	FROM 
		(SELECT 
			(SELECT 
				COUNT(*) 
				FROM likes 
				WHERE 
					target_type = 'users' AND 
					target_id = profiles.user_id) AS count_of_likes
				FROM profiles
				ORDER BY profiles.birthday 
				DESC LIMIT 100) AS likes_of_user;
