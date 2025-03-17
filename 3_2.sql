/*Задача 3_2
Необходимо провести анализ клиентов, которые сделали более двух бронирований в
разных отелях и потратили более 500 долларов на свои бронирования. Для этого:
- Определить клиентов, которые сделали более двух бронирований и забронировали 
номера в более чем одном отеле. Вывести для каждого такого клиента следующие данные: 
ID_customer, имя, общее количество бронирований, общее количество уникальных отелей, 
в которых они бронировали номера, и общую сумму, потраченную на бронирования.
- Также определить клиентов, которые потратили более 500 долларов на бронирования, 
и вывести для них ID_customer, имя, общую сумму, потраченную на бронирования, и общее 
количество бронирований.
- В результате объединить данные из первых двух пунктов, чтобы получить список клиентов, 
которые соответствуют условиям обоих запросов. Отобразить поля: ID_customer, имя, общее 
количество бронирований, общую сумму, потраченную на бронирования, и общее количество 
уникальных отелей.
- Результаты отсортировать по общей сумме, потраченной клиентами, в порядке возрастания.*/

WITH customer_stats AS (
  SELECT 
    customer.ID_customer,
    customer.name,
    COUNT(booking.ID_booking) AS total_bookings,
    COUNT(DISTINCT room.ID_hotel) AS unique_hotels,
    SUM(room.price) AS total_spent
  FROM Booking
  JOIN Customer ON booking.ID_customer = customer.ID_customer
  JOIN Room ON booking.ID_room = room.ID_room
  GROUP BY customer.ID_customer, customer.name
)
SELECT 
  ID_customer,
  name,
  total_bookings,
  total_spent,
  unique_hotels
FROM customer_stats
WHERE total_bookings > 2        -- более двух бронирований
  AND unique_hotels > 1         -- бронирование в более чем одном отеле
  AND total_spent > 500         -- потрачено более 500 долларов
ORDER BY total_spent ASC;





