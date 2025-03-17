/*Задача 3_1
Определить, какие клиенты сделали более двух бронирований в разных отелях,
и вывести информацию о каждом таком клиенте, включая его имя, электронную почту, 
телефон, общее количество бронирований, а также список отелей, в которых они 
бронировали номера (объединенные в одно поле через запятую с помощью CONCAT). 
Также подсчитать среднюю длительность их пребывания (в днях) по всем бронированиям. 
Отсортировать результаты по количеству бронирований в порядке убывания.*/

SELECT 
    booking.ID_customer,
    customer.name,
    customer.email,
    customer.phone,
    COUNT(booking.ID_booking) AS total_bookings,
    STRING_AGG(DISTINCT hotel.name, ', ') AS hotel_list,
    AVG(booking.check_out_date - booking.check_in_date) AS avg_stay_duration
FROM Booking
JOIN Room ON booking.ID_room = room.ID_room
JOIN Hotel ON room.ID_hotel = hotel.ID_hotel
JOIN Customer ON booking.ID_customer = customer.ID_customer
GROUP BY booking.ID_customer, customer.name, customer.email, customer.phone
HAVING COUNT(DISTINCT hotel.ID_hotel) > 1 AND COUNT(booking.ID_booking) > 2
ORDER BY total_bookings DESC;




