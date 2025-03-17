/*Задача 2_3
Определить классы автомобилей, которые имеют наименьшую среднюю позицию
в гонках, и вывести информацию о каждом автомобиле из этих классов, включая 
его имя, среднюю позицию, количество гонок, в которых он участвовал, страну 
производства класса автомобиля, а также общее количество гонок, в которых участвовали 
автомобили этих классов. Если несколько классов имеют одинаковую среднюю позицию, 
выбрать все из них.*/

WITH AvgPerClass AS (
    -- Подсчет средней позиции для каждого класса и общего количества гонок в этом классе
    SELECT 
        cars.class,
        AVG(results.position) AS avg_class_position,
        COUNT(results.race) AS total_race_count
    FROM Results
    JOIN Cars ON results.car = cars.name
    GROUP BY cars.class
), 
MinAvgClass AS (
    -- Определение классов с минимальной средней позицией
    SELECT class
    FROM AvgPerClass
    WHERE avg_class_position = (SELECT MIN(avg_class_position) FROM AvgPerClass)
)
SELECT 
    cars.name, 
    cars.class, 
    AVG(results.position) AS avg_position, 
    COUNT(results.race) AS race_count, 
    classes.country, 
    AvgPerClass.total_race_count
FROM Results
JOIN Cars ON results.car = cars.name
JOIN Classes ON cars.class = classes.class
JOIN AvgPerClass ON cars.class = AvgPerClass.class
JOIN MinAvgClass ON cars.class = MinAvgClass.class
GROUP BY cars.name, cars.class, classes.country, AvgPerClass.total_race_count
ORDER BY avg_position;
