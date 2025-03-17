/*Задача 2_2
Определить автомобиль, который имеет наименьшую среднюю позицию в гонках среди 
всех автомобилей, и вывести информацию об этом автомобиле, включая его класс, 
среднюю позицию, количество гонок, в которых он участвовал, и страну производства 
класса автомобиля. Если несколько автомобилей имеют одинаковую наименьшую среднюю позицию, 
выбрать один из них по алфавиту (по имени автомобиля).*/

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
        MIN(avg_position) AS min_avg_position
    FROM AvgPosition
)
SELECT 
    AvgPosition.car, 
    AvgPosition.class, 
    AvgPosition.avg_position, 
    AvgPosition.race_count, 
    classes.country
FROM AvgPosition
JOIN MinAvgPosition ON AvgPosition.avg_position = MinAvgPosition.min_avg_position
JOIN Classes ON AvgPosition.class = classes.class
ORDER BY AvgPosition.car
LIMIT 1