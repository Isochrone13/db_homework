/*Задача 3_3
Вам необходимо провести анализ данных о бронированиях в отелях и определить 
предпочтения клиентов по типу отелей. Для этого выполните следующие шаги:
-- 1. Категоризация отелей.
Определите категорию каждого отеля на основе средней стоимости номера:
«Дешевый»: средняя стоимость менее 175 долларов.
«Средний»: средняя стоимость от 175 до 300 долларов.
«Дорогой»: средняя стоимость более 300 долларов.
-- 2. Анализ предпочтений клиентов.
Для каждого клиента определите предпочитаемый тип отеля на основании условия ниже:
Если у клиента есть хотя бы один «дорогой» отель, присвойте ему категорию «дорогой».
Если у клиента нет «дорогих» отелей, но есть хотя бы один «средний», присвойте 
ему категорию «средний».
Если у клиента нет «дорогих» и «средних» отелей, но есть «дешевые», присвойте 
ему категорию предпочитаемых отелей «дешевый».
-- 3. Вывод информации.
Выведите для каждого клиента следующую информацию:
ID_customer: уникальный идентификатор клиента.
name: имя клиента.
preferred_hotel_type: предпочитаемый тип отеля.
visited_hotels: список уникальных отелей, которые посетил клиент.
Сортировка результатов.
Отсортируйте клиентов так, чтобы сначала шли клиенты с «дешевыми» отелями, 
затем со «средними» и в конце — с «дорогими».*/

WITH HotelCategory AS (
    SELECT
        hotel.ID_hotel,
        hotel.name AS hotel_name,
        CASE 
            WHEN AVG(room.price) < 175 THEN 'Дешевый'
            WHEN AVG(room.price) BETWEEN 175 AND 300 THEN 'Средний'
            ELSE 'Дорогой'
        END AS hotel_category
    FROM Room
    JOIN Hotel ON room.ID_hotel = hotel.ID_hotel
    GROUP BY hotel.ID_hotel, hotel.name
),
CustomerPreferences AS (
    SELECT
        booking.ID_customer,
        customer.name AS customer_name,
        STRING_AGG(DISTINCT HotelCategory.hotel_name, ', ') AS visited_hotels,
        CASE 
            WHEN COUNT(DISTINCT CASE WHEN HotelCategory.hotel_category = 'Дорогой' THEN HotelCategory.ID_hotel END) > 0 THEN 'Дорогой'
            WHEN COUNT(DISTINCT CASE WHEN HotelCategory.hotel_category = 'Средний' THEN HotelCategory.ID_hotel END) > 0 THEN 'Средний'
            ELSE 'Дешевый'
        END AS preferred_hotel_type
    FROM Booking
    JOIN Room ON booking.ID_room = room.ID_room
    JOIN HotelCategory ON room.ID_hotel = HotelCategory.ID_hotel
    JOIN Customer ON booking.ID_customer = customer.ID_customer
    GROUP BY booking.ID_customer, customer.name
)
SELECT 
    ID_customer,
    customer_name AS name,
    preferred_hotel_type,
    visited_hotels
FROM CustomerPreferences
ORDER BY 
    CASE preferred_hotel_type
        WHEN 'Дешевый' THEN 1
        WHEN 'Средний' THEN 2
        WHEN 'Дорогой' THEN 3
    END,
	ID_customer;





