-- ЗАДАЧА №3 Определить кто больше поставил лайков (всего) - мужчины или женщины?
 
-- Для решения задачи, разделил ее на подзадачи:
-- 1. Формирую запрос: Сколько мужчин в списке?
SELECT 
  COUNT(user_id)
    FROM profiles
      WHERE gender = 'm';
     
-- 2. Формирую запрос: Cколько лайков поставили мужчины? 
SELECT 
	COUNT(user_id) AS man
	FROM likes 
		WHERE -- если помещаем условие сортирвки здесь получаем ограниченный вывод
		user_id IN ((SELECT user_id FROM profiles WHERE gender = 'm'));
         
-- 3. Rомбинирую эти запросы и получаю запрос возвращающий количество мужчин, количество их лайков 
--    и по аналогии количество женщин и количество их лайков.
SELECT 
  (SELECT 
    COUNT(user_id)
      FROM profiles
        WHERE gender = 'm') AS count_of_man,
  (SELECT 
    COUNT(user_id)
      FROM likes 
        WHERE user_id IN ((SELECT user_id FROM profiles WHERE gender = 'm'))) AS count_of_likes_by_man,
  (SELECT 
    COUNT(user_id)
      FROM profiles
        WHERE gender = 'f') AS count_of_woman,
  (SELECT 
    COUNT(user_id)
      FROM likes 
        WHERE user_id IN ((SELECT user_id FROM profiles WHERE gender = 'f'))) AS count_of_likes_by_woman   
  FROM likes LIMIT 1;
 
  -- Формально задача решена, но получилось нагромождение запросов, но работает, подумаю как можно оптимизировать.
