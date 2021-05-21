-- ПРОЕКТ: Дайвинг-центр.
-- Максим Сапунов Jenny6199@yandex.ru
-- Файл №6
-- ЧАСТО ИСПОЛЬЗУЕМЫЕ ЗАПРОСЫ

-- Запрос №1: получить контактные данные члена клуба по id.
-- Используется представление.
SELECT 
	mci.diver, mci.adress, mci.email, mci.phone 
FROM members_contact_info AS mci WHERE id = 201;


-- Запрос №2: просмотр личного журнала погружений члена клуба
-- Используется встроенная процедура
CALL personal_log_book(2); 


-- Запрос №3: распределение членов клуба по уровням квалификации.
-- Используется оконная функция.
SELECT DISTINCT
	qom.step_of_qualification AS 'Уровень квалификации',
	COUNT(user_id) OVER(PARTITION BY step_of_qualification) AS 'Количество членов клуба'
FROM qualification_of_members AS qom
ORDER BY step_of_qualification;


-- Запрос №4: получить распределение минимальной стоимости активных клубных поездок,
-- в зависимости от специализации.
-- Используется представление и оконная функция.
SELECT DISTINCT 
	act.specification AS 'Специализация', 
	MIN(act.cost) OVER(PARTITION BY act.specification ORDER BY act.cost) AS 'Наименьшая стоимость'
FROM active_club_travels AS act;



-- Запрос №5. получить список направлений заказов авиабилетов
-- для клубных поездок (идентификатор члена клуба, страна отрпавления,
-- страна прибытия).
-- Используется объединение таблиц с вложенными запросами в FROM и в JOIN.
SELECT 
	tl.user_id, 
	tl.country AS Departure,
	fly_to.country AS Arrival 
FROM (SELECT travel_log.user_id, travel_log.country FROM travel_log) AS tl
LEFT JOIN
(SELECT user_id,country FROM adress_of_members) AS fly_to
ON tl.user_id = fly_to.user_id;
