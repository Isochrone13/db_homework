/*Задача 2_1
Определить, какие автомобили из каждого класса имеют наименьшую среднюю позицию в гонках, 
и вывести информацию о каждом таком автомобиле для данного класса, включая его класс, 
среднюю позицию и количество гонок, в которых он участвовал. 
Также отсортировать результаты по средней позиции.*/

WITH AvgPosition AS (
    SELECT 
        cars.class,
        results.car, 
        AVG(results.position) AS avg_position, 
        COUNT(results.race) AS race_count
    FROM Results
    JOIN Cars ON results.car = cars.name
    GROUP BY cars.class, results.car
), 
MinAvgPosition AS (
    SELECT 
        class, 
        MIN(avg_position) AS min_avg_position
    FROM AvgPosition
    GROUP BY class
)
SELECT 
    AvgPosition.car,
    AvgPosition.class, 
    AvgPosition.avg_position, 
    AvgPosition.race_count
FROM AvgPosition
JOIN MinAvgPosition ON AvgPosition.class = MinAvgPosition.class AND AvgPosition.avg_position = MinAvgPosition.min_avg_position
ORDER BY AvgPosition.avg_position;