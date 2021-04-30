-- ЗАДЧАЧА № 4 Подсчитать количество лайков которые получили 10 самых молодых пользователей.
 
DESC users;
DESC profiles;
DESC likes;
-- Найдем 10 самых молодых пользователей.
SELECT 
	user_id 
		FROM profiles 
		ORDER BY profiles.birthday 
		DESC
		LIMIT 10;

-- Посчитаем количство лайков для конкретного id
SELECT 
	*
	FROM likes
	WHERE user_id = 15;

-- Скомпонуем запросы


	

