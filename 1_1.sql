/* Задача 1_1
 Найдите производителей (maker) и модели всех мотоциклов, которые 
 имеют мощность более 150 лошадиных сил, 
 стоят менее 20 тысяч долларов и 
 являются спортивными (тип Sport). 
 Также отсортируйте результаты по мощности в порядке убывания.*/

SELECT vehicle.maker, motorcycle.model
FROM motorcycle
JOIN vehicle ON motorcycle.model = vehicle.model
WHERE motorcycle.horsepower > 150 
AND motorcycle.price < 20000 
AND motorcycle.type = 'Sport'
ORDER BY motorcycle.horsepower DESC