-- ЗАДАЧА № 2. Создать все необходимые внешние ключи и диаграмму отношений.

-- Создаем внешние ключи для таблицы ПРОФИЛЕЙ
ALTER TABLE profiles
  ADD CONSTRAINT profiles_user_id_fk
    FOREIGN KEY (user_id) REFERENCES users(id)
      ON DELETE CASCADE;
     
 -- Создаю внешний ключ для таблицы ДРУЖБЫ
ALTER TABLE friendship 
  ADD CONSTRAINT friendship_user_id_fk
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (friend_id) REFERENCES users(id)
      ON DELETE CASCADE;

 ALTER TABLE friendship 
  ADD CONSTRAINT friendship_user_id_fk_2
    FOREIGN KEY (friend_id) REFERENCES users(id)
      ON DELETE CASCADE;
     
 ALTER TABLE friendship 
  ADD CONSTRAINT friendship_user_id_fk_3
    FOREIGN KEY (friendship_status_id) REFERENCES friendship_statuses(id)
      ON DELETE CASCADE;
     
-- Создаю внешний ключ для таблицы СООБЩЕНИЙ
 ALTER TABLE messages
  ADD CONSTRAINT messages_from_user_id_fk 
    FOREIGN KEY (from_user_id) REFERENCES users(id),
  ADD CONSTRAINT messages_to_user_id_fk 
    FOREIGN KEY (to_user_id) REFERENCES users(id);

-- Создаю внешний ключ для таблицы СООБЩЕСТВ
ALTER TABLE communities_users MODIFY COLUMN user_id INT UNSIGNED;

ALTER TABLE communities_users 
  ADD CONSTRAINT communities_community_id_fk
    FOREIGN KEY (community_id) REFERENCES communities(id)
      ON DELETE CASCADE;

ALTER TABLE communities_users 
  ADD CONSTRAINT communities_user_id_fk
    FOREIGN KEY (user_id) REFERENCES users(id)
      ON DELETE CASCADE;
   
-- Создаю внешний ключ для таблицы ЛАЙКОВ
ALTER TABLE likes
  ADD CONSTRAINT likes_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id);
   
-- Создаю внешний ключ для таблицы ПОСТОВ
ALTER TABLE posts 
  ADD CONSTRAINT posts_user_id_fk
    FOREIGN KEY (user_id) REFERENCES users(id)
      ON DELETE CASCADE;

ALTER TABLE posts 
  ADD CONSTRAINT posts_user_id_fk_2
    FOREIGN KEY (community_id) REFERENCES communities(id)
      ON DELETE CASCADE;

 -- Создаю внешний ключ для таблицы МЕДИА
ALTER TABLE media 
  ADD CONSTRAINT media_user_id
    FOREIGN KEY (user_id) REFERENCES users(id)
      ON DELETE CASCADE;
     
-- Cоздаю внешний ключ для таблицы ТИПОВ_МЕДИА
ALTER TABLE media
  ADD CONSTRAINT media_type_id_fk
    FOREIGN KEY (media_type_id) REFERENCES media_types(id)
      ON DELETE CASCADE;
     
-- Создаю внешний ключ для таблицы СТАТУСОВ_ДРУЖБЫ
DESC friendship_statuses;
SELECT * FROM friendship;

