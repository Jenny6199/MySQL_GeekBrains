USE vk;
SELECT * FROM media LIMIT 10;

SELECT DISTINCT 
	users.id,
	CONCAT (users.last_name, ' ', users.first_name) AS user,
	media.filename AS file_path,
	media_types.name,
	media.user_id 
		FROM
			media JOIN users JOIN media_types
		ON media_types.name = 'photo' AND media.user_id = users.id AND users.id = media.user_id
		ORDER BY users.id;
    
-- тест	
SELECT * FROM media WHERE user_id = 100;
SELECT * FROM users WHERE users.id = 100;
SELECT * FROM friendship WHERE user_id = 100;

-- Посчитаем количество друзей у каждого пользователя.
SELECT 
	users.id ,
	first_name,
	last_name,
	COUNT(friendship.created_at) AS total_friends
	FROM users
		LEFT JOIN friendship
		ON users.id = friendship.user_id 
			OR users.id = friendship.friend_id 
	GROUP BY users.id 
	ORDER BY total_friends DESC;
	
-- Выведем список медиафайлов конкретного пользователя с количеством лайков для каждого файла.
SELECT 
	media.id,
	media.filename,
	COUNT(DISTINCT(likes.id)) AS total_likes,
	CONCAT(last_name, ' ', first_name) AS owner
	FROM media
		LEFT JOIN likes
			ON media.id = likes.target_id
				AND target_type = 'media'
		INNER JOIN users
			ON users.id = media.user_id
	WHERE media.user_id = users.id 
	GROUP BY media.id
	ORDER BY total_likes DESC
	LIMIT 10;

-- тест
SELECT * FROM media WHERE user_id = 92;
SELECT first_name, last_name FROM users WHERE id = 92;

-- 10 пользователей с наибольшим количеством лайков за медиафайл.
SELECT 
	users.id,
	CONCAT(last_name, ' ', first_name) AS name,
	COUNT(likes.id) AS total_likes
	FROM 
		users 
		LEFT JOIN media 
			ON users.id = media.user_id 
		LEFT JOIN likes
			ON media.id = likes.target_id 
				AND likes.target_type = 'media'
	GROUP BY users.id 
	ORDER BY total_likes DESC
	LIMIT 10;
  
-- тест
SELECT likes.id from likes;
SELECT * fROM media;
SELECT * FROM likes;
