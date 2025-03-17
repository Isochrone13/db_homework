/*Задача 1_2
Найти информацию о производителях и моделях различных типов транспортных средств 
(автомобили, мотоциклы и велосипеды), которые соответствуют заданным критериям.
Автомобили:
Извлечь данные о всех автомобилях, которые имеют:
Мощность двигателя более 150 лошадиных сил.
Объем двигателя менее 3 литров.
Цену менее 35 тысяч долларов.
В выводе должны быть указаны производитель (maker), номер модели (model), мощность (horsepower), 
объем двигателя (engine_capacity) и тип транспортного средства, который будет обозначен как Car.
Мотоциклы:
Извлечь данные о всех мотоциклах, которые имеют:
Мощность двигателя более 150 лошадиных сил.
Объем двигателя менее 1,5 литров.
Цену менее 20 тысяч долларов.
В выводе должны быть указаны производитель (maker), номер модели (model), мощность (horsepower), 
объем двигателя (engine_capacity) и тип транспортного средства, который будет обозначен как Motorcycle.
Велосипеды:
Извлечь данные обо всех велосипедах, которые имеют:
Количество передач больше 18.
Цену менее 4 тысяч долларов.
В выводе должны быть указаны производитель (maker), номер модели (model), а также NULL 
для мощности и объема двигателя, так как эти характеристики не применимы для велосипедов. 
Тип транспортного средства будет обозначен как Bicycle.
Сортировка:
Результаты должны быть объединены в один набор данных и отсортированы по мощности в
порядке убывания. Для велосипедов, у которых нет значения мощности, они будут располагаться внизу списка.*/

SELECT 
    vehicle.maker, 
    car.model, 
    car.horsepower, 
    car.engine_capacity, 
    vehicle.type as vehicle_type
FROM car
JOIN vehicle ON car.model = vehicle.model
WHERE car.horsepower > 150 AND car.engine_capacity < 3 AND car.price < 35000
UNION ALL
SELECT 
    vehicle.maker, 
    motorcycle.model, 
    motorcycle.horsepower, 
    motorcycle.engine_capacity, 
    vehicle.type as vehicle_type
FROM motorcycle
JOIN vehicle ON motorcycle.model = vehicle.model
WHERE motorcycle.horsepower > 150 AND motorcycle.engine_capacity < 1.5 AND motorcycle.price < 20000
UNION ALL
SELECT 
    vehicle.maker, 
    bicycle.model, 
    NULL AS horsepower, 
    NULL AS engine_capacity, 
    vehicle.type as vehicle_type
FROM bicycle
JOIN vehicle ON bicycle.model = vehicle.model
WHERE bicycle.gear_count > 18 AND bicycle.price < 4000
ORDER BY 
    horsepower DESC NULLS LAST

