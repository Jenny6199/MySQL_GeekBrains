-- ПРОЕКТ: Дайвинг-центр.
-- Максим Сапунов Jenny6199@yandex.ru
-- Файл №5
-- Создание хранимых процедур

DELIMITER //

-- ПРОЦЕДУРА №1. Персональный лог-бук. В качестве переменной используется id
-- члена клуба. 
CREATE PROCEDURE IF NOT EXISTS personal_log_book(IN m_id INT)
BEGIN
	SET @i = m_id;
	SELECT 
		(SELECT CONCAT(m.last_name, ' ', m.first_name) 
			FROM members AS m 
			WHERE m.id = log_book.user_id) AS Diver,
		(SELECT CONCAT(m.last_name, ' ', m.first_name) 
			FROM members AS m 
			WHERE m.id = log_book.partner_id) AS Buddy,
		site_id,
		DATE(dive_date) AS dive_date,
		dive_deep,
		dive_time
	FROM log_book
	WHERE user_id = @i OR partner_id = @i;
END//


-- ПРОЦЕДУРА №2. История поездок члена клуба.
CREATE PROCEDURE IF NOT EXISTS personal_travel_log (IN m_id INT)
BEGIN
	SET @i = m_id;
	SELECT 
		(SELECT CONCAT(m.last_name, ' ', m.first_name) 
			FROM members AS m WHERE tl.user_id = m.id) AS 'Member',
		travel_date,
		country
	FROM travel_log AS tl
	WHERE user_id = @i;
END//

DELIMITER ;
