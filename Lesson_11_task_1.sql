- Практическое задание тема "Оптимизация запросов"
-- 1. Создайте таблицу logs типа Archive. Пусть при каждом создании записи в таблицах users,
-- catalogs и products в таблицу logs помещается время и дата создания записи, название
-- таблицы, идентификатор первичного ключа и содержимое поля name.


USE shop;
SHOW TABLES;

-- Создаем таблицу с указанием движка Archive.
CREATE TABLE logs (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата создания записи',
    table_name VARCHAR(255) NOT NULL COMMENT 'Указатель на таблицу в которую происходит вставка значения',
    add_id INT UNSIGNED NOT NULL COMMENT 'Указатель на id записи',
    add_name VARCHAR(255) COMMENT 'Значение записи'
) ENGINE=Archive AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Архивная таблица';

-- Последовательно создаем триггеры которые записывают данные 
-- в архивную таблицу при каждом обновлении целевых таблиц.

DELIMITER //

CREATE TRIGGER products_insert AFTER INSERT ON products
FOR EACH ROW
BEGIN
    INSERT INTO logs VALUES (NULL, DEFAULT, "products", NEW.id, NEW.name);
END//
   
CREATE TRIGGER users_insert AFTER INSERT ON users
FOR EACH ROW
BEGIN
    INSERT INTO Logs VALUES (NULL, DEFAULT, "users", NEW.id, NEW.name);
END//

CREATE TRIGGER catalogs_insert AFTER INSERT ON catalogs
FOR EACH ROW
BEGIN
    INSERT INTO Logs VALUES (NULL, DEFAULT, "catalogs", NEW.id, NEW.name);
END//

DELIMITER ;
