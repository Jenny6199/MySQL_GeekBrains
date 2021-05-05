-- ЗАДАЧА № 5. Найти 10 пользователей, которые проявляют наименьшую активность в использовании социальной сети.     
			
-- Критерий активности: последний вход в систему.
SELECT 
	*
	FROM profiles
	ORDER BY last_login;
  
-- Критерий активности: количество лайков
SELECT 
	COUNT(*) FROM likes WHERE likes.user_id = 17;

-- Формирую вложенный многотабличный запрос - имя и фамилия пользователя, количество лайков, последняя активность.
SELECT 
	CONCAT(first_name, ' ', last_name) AS user_name,
	(SELECT COUNT(*) FROM likes WHERE likes.user_id = users.id) AS count_of_likes,
	(SELECT last_login FROM profiles WHERE profiles.user_id = users.id) AS last_activity
	FROM users
	ORDER BY last_activity
	LIMIT 10;
