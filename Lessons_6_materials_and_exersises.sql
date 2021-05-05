-- Материалы урока:

DESC media;
-- Формируем запрос для получения пути к фотографии пользователя
SELECT filename FROM media
  WHERE user_id = 17
    AND media_type_id = (
      SELECT id FROM media_types WHERE name = 'photo'
      );
     
-- Формируем запрос для получения информационной строки с данными о добавлении фотографии пользователем.      
SELECT CONCAT(
  'Пользователь',
  (SELECT CONCAT(first_name, ' ', last_name, ' ') FROM users WHERE id = media.user_id),
  created_at,
  ' ',
  'добавил фото - ',
  filename) AS news
    FROM media
      WHERE user_id = 17 AND media_type_id = (
        SELECT id FROM media_types WHERE name = 'photo'
);

-- Формируем запрос на получение списка пользователей разместивших файлы наибольшего размера
SELECT 
  (SELECT first_name FROM users WHERE users.id = media.user_id) AS first_name,
  (SELECT last_name FROM users WHERE users.id = media.user_id) AS last_name,
  filename,
  size
    FROM media
    ORDER BY size DESC 
    LIMIT 10;

   
-- Формируем два запроса объединенных с помощью UNION
   
(SELECT friend_id FROM friendship WHERE user_id = 30)
UNION -- работает если одинаковый тип значений и одинаковое количество столбцов
(SELECT user_id FROM friendship WHERE friend_id = 30);

SELECT id FROM friendship_statuses WHERE name = 'Confirmed';


-- Усложняем запрос вкладывая в него запрос на получение только пользователей с подтвержденным значением дружбы
(SELECT 
	friend_id 
		FROM friendship 
			WHERE 
				user_id = 30 AND 
				friendship_status_id =(SELECT id FROM friendship_statuses WHERE name = 'Confirmed')        
)

UNION

(SELECT 
	user_id 
		FROM friendship 
			WHERE 
				friend_id = 30 AND 
				friendship_status_id =(SELECT id FROM friendship_statuses WHERE name = 'Confirmed')
);

-- Вариант решения с помощью функции IF

SELECT IF (user_id = 30, friend_id, user_id)
	FROM friendship
		WHERE user_id = 30 OR friend_id = 30;
 
-- Получение всех медиафайлов друзей пользователя.
SELECT 
	filename 
		FROM media 
		WHERE user_id IN (
			SELECT IF(user_id = 100, friend_id, user_id)
			FROM friendship
			WHERE user_id = 100 OR friend_id = 100
				AND friendship_status_id =
				(SELECT id FROM friendship_statuses WHERE name = 'Confirmed')
);
				

-- Получаем пользователей у которых медиа превышает 500 МБ использование HAVING
			
DESC media;
DESC users;
SELECT 
	user_id,
	(SELECT CONCAT(first_name, ' ', last_name) FROM users WHERE users.id = media.user_id) AS user,
	SUM(size) AS total
	FROM media
	GROUP BY user_id
	HAVING total > 500000000;
	

-- Использование IF
DESC messages;
SELECT 
	from_user_id, 
	to_user_id, 
	body, 
	IF(is_delivered, 'delivered', 'not delivered') AS status 
		FROM messages 
			WHERE (from_user_id = 7 OR to_user_id = 7)
		ORDER BY created_at DESC;

	
-- Используем LIKE
SELECT CONCAT(
	first_name,
	' ',
	last_name) AS fullname
	FROM users
	WHERE first_name LIKE 'M%';


-- Используем RLIKE
SELECT CONCAT (
	first_name, ' ', last_name) AS fullname
	FROM users u WHERE last_name RLIKE '^S.*r$';
