/*Задача 2_4
Определить, какие автомобили имеют среднюю позицию лучше (меньше) средней
позиции всех автомобилей в своем классе (то есть автомобилей в классе должно
быть минимум два, чтобы выбрать один из них). Вывести информацию об этих автомобилях,
включая их имя, класс, среднюю позицию, количество гонок, в которых они участвовали,
и страну производства класса автомобиля. Также отсортировать результаты по классу и
затем по средней позиции в порядке возрастания.*/

WITH AvgPerCar AS (
    -- Подсчет средней позиции и количества гонок для каждого автомобиля
    SELECT 
        cars.class,
        results.car, 
        AVG(results.position) AS avg_position, 
        COUNT(results.race) AS race_count
    FROM Results
    JOIN Cars ON results.car = cars.name
    GROUP BY cars.class, results.car
), 
AvgPerClass AS (
    -- Подсчет средней позиции среди всех автомобилей каждого класса (в классе минимум 2 автомобиля)
    SELECT 
        cars.class,
        AVG(results.position) AS avg_class_position,
        COUNT(DISTINCT results.car) AS car_count
    FROM Results
    JOIN Cars ON results.car = cars.name
    GROUP BY cars.class
    HAVING COUNT(DISTINCT results.car) >= 2 -- оставляем только классы с минимум 2 автомобилями
)
SELECT 
    AvgPerCar.car, 
    AvgPerCar.class, 
    AvgPerCar.avg_position, 
    AvgPerCar.race_count, 
    classes.country
FROM AvgPerCar
JOIN AvgPerClass ON AvgPerCar.class = AvgPerClass.class
JOIN Classes ON AvgPerCar.class = classes.class
WHERE AvgPerCar.avg_position < AvgPerClass.avg_class_position -- автомобиль должен быть лучше средней позиции в классе
ORDER BY AvgPerCar.class, AvgPerCar.avg_position;
