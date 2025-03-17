/*Задача 2_5
Определить, какие классы автомобилей имеют наибольшее количество автомобилей
с низкой средней позицией (больше 3.0) и вывести информацию о каждом автомобиле
из этих классов, включая его имя, класс, среднюю позицию, количество гонок, в
которых он участвовал, страну производства класса автомобиля, а также общее количество
гонок для каждого класса. Отсортировать результаты по количеству автомобилей с низкой 
средней позицией.*/

WITH AvgPerCar AS (
    -- Подсчёт средней позиции и количества уникальных гонок для каждого автомобиля
    SELECT 
        cars.class,
        results.car, 
        AVG(results.position) AS avg_position, 
        COUNT(results.race) AS race_count
    FROM Results
    JOIN Cars ON results.car = cars.name
    GROUP BY cars.class, results.car
), 
TotalRaces AS (
    -- Подсчёт общего количества уникальных гонок для каждого класса
    SELECT 
        cars.class, 
        COUNT(results.race) AS total_race_count
    FROM Results
    JOIN Cars ON results.car = cars.name
    GROUP BY cars.class
)
SELECT 
    AvgPerCar.car, 
    AvgPerCar.class, 
    AvgPerCar.avg_position, 
    AvgPerCar.race_count, 
    classes.country, 
    TotalRaces.total_race_count, 
    COUNT(*) OVER (PARTITION BY AvgPerCar.car) AS low_position_count
FROM AvgPerCar
JOIN TotalRaces ON AvgPerCar.class = TotalRaces.class
JOIN Classes ON AvgPerCar.class = classes.class
WHERE AvgPerCar.avg_position > 3
ORDER BY low_position_count DESC;




