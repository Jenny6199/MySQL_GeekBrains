-- ПРОЕКТ: Дайвинг-центр
-- Максим Сапунов Jenny6199@yandex.ru
-- Файл №3
-- Описание таблиц.


-- ТАБЛИЦА №1. Таблица членов клуба. members.
-- 7 столбцов. 200 строк.
-- Содержит данные индивидуального идентификатора, имени, фамилии членов клуба их 
-- контактные данные (телефон, е-mail), данные о создании учетной записи и ее обновлении.
-- основная таблица, идентификатор записи связывает таблицу с 6 основными информационными
-- таблицами adress_of_members, qualification_of_members, log_book, messages, travel_log
-- и  travel_requests.

-- ТАБЛИЦА №2. Таблица адресов членов клуба. adress_of_members.
-- 8 столбцов. 200 строк.
-- Cодержит данные индивидуального идентификатора пользователя для связи таблиц, адрес
-- развернутый в 6 столбцов (страна, город, улица, номер дома, номер квартиры, почтовый
-- индекс), а так же столбец с временем обновления записи. Связана внешним ключом с таблицей
-- members.


-- ТАБЛИЦА №3. Квалификация членов клуба. qualification_of_members.
-- 6 столбцов. 200 строк.
-- Содержит данные о идентификаторе уровня квалификации членов клуба, идентификаторе
-- инструктора на курсе, идентификаторе места сертификации и дате создания записи.
-- Связана внешними ключами с таблицами members, levels_of_qualification и dive_sites. 


-- ТАБЛИЦА №4. Уровни квалификации. levels_of_qualification.
-- 5 столбцов 45 строк.
-- Содержит данные об основных уровнях квлификации дайверов, предлагаемой
-- Professional Association of Diving Instructors (PADI)
-- идентификатор уровня квалификации, тип направления, название уровня, уровень в подгруппе,
-- количество необходимых зарегистрированных погружений для достижения уровня.
-- Связана внешним ключом с таблицей qulification_of_members.


-- ТАБЛИЦА №5. Лог-бук погружений. log_book.
-- 8 столбцов 1000 строк.
-- Содержит данные о погружениях осущественных в клубных поездках.
-- Идентификатор записи, идентификатор члена клуба и его напарника осуществивших погружение,
-- идентификатор дайв-сайта, дата погружения, глубина и продолжительность погружения, а также
-- время создания записи.
-- Связана внешними ключом с таблицами dive_sites и members.


-- ТАБЛИЦА №6. Участие в клубных поездках. travel_log.
-- 5 столбцов. 100 строк.
-- Содержит данные об участии членов клуба в клубных поездках.
-- Идентификатор записи, идентификатор пользователя, дата поездки, страна
-- и дата создания записи.
-- Связана внешними ключами с таблицами members и messages (отзывы о поездке).


-- ТАБЛИЦА №7. Отзывы членов клуба. messages.
-- 5 столбцов. 400 строк.
-- Содержит отзывы пользователей о клубных поездках.
-- Идентификатор записи, идентификатор пользователя, идентификатор клубной поездки,
-- текст сообщения, дата создания записи.
-- Связана внешними ключами с таблицами members и travel_log.


-- ТАБЛИЦА №8. Клубные поездки. club_travels_list
-- 7 столбцов. 100 строк.
-- Cодержит информацию о клубных поездках.
-- Дата начала, продолжительность в днях, спецификации поездки, стоимости,
-- статусе поездки и дате обновления записи.
-- Связана внешними ключами с таблицами status_of_travel и travel_requests.


-- ТАБЛИЦА №9. Таблица статусов клубных поездок. status_of_travel.
-- 2 столбца. 4 строки
-- Вспомогательная таблица, содержит текстовое представление статусов клубных поездок
-- "завершено", "ожидается", "проводится", "отменено".
-- Связана внешним ключом с таблицей club_travels_list.


-- ТАБЛИЦА №10. Заявки пользователей на участие в поездках. travel_requests.
-- 5 столбцов. 400 строк.
-- Содержит информацию о заявках членов клуба на участие в клубных поездках.
-- Идентификатор записи, идентификаторр пользователя, идентификатор поездки, статус
-- оплаты и время создания заявки.
-- Связана внешними ключами с таблицами club_travels_list и members.
