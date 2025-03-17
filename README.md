# Описание проекта

Данный проект представляет собой практическое задание по работе с базами данных на языке SQL. Основной целью проекта является освоение основ  манипуляции данными в различных базах данных, что позволяет закрепить навыки работы с SQL.

## Цели и задачи проекта

- **Цель проекта:**  
  Научиться работать с SQL для извлечения, модификации и управления данными, а также понимать принципы транзакций и их применение в реальных проектах.

- **Задачи проекта:**  
  - Создать базы данных для четырёх тематических областей:
    - Транспортные средства
    - Автомобильные гонки
    - Бронирование отелей
    - Структура организации
  - Наполнить таблицы тестовыми данными.
  - Решить 13 задач, направленных на практическое применение SQL-запросов для выборки и анализа данных.
  - Подготовить проект для сдачи с логичной структурой репозитория и подробной документацией.

## Структура базы данных и реализованные функции

Проект включает в себя четыре отдельных базы данных, каждая из которых имеет свою схему:

1. **Транспортные средства**
   - **Таблица `Vehicle`** – хранит информацию о производителях, моделях и типах транспортных средств (Car, Motorcycle, Bicycle).
   - **Таблицы `Car`, `Motorcycle`, `Bicycle`** – содержат детализированную информацию по каждому виду транспорта.

2. **Автомобильные гонки**
   - **Таблица `Classes`** – описывает классы автомобилей, участвующих в гонках.
   - **Таблица `Cars`** – содержит данные об автомобилях, привязанных к определённым классам.
   - **Таблицы `Races` и `Results`** – хранят информацию о гонках и результаты участия автомобилей в соревнованиях.

3. **Бронирование отелей**
   - **Таблица `Hotel`** – содержит данные об отелях.
   - **Таблица `Room`** – описывает номера отелей с привязкой к отелям.
   - **Таблица `Customer`** – хранит информацию о клиентах.
   - **Таблица `Booking`** – связывает клиентов с забронированными номерами, включая даты заезда и выезда.

4. **Структура организации**
   - **Таблицы `Departments` и `Roles`** – содержат данные об отделах и ролях сотрудников.
   - **Таблица `Employees`** – хранит сведения о сотрудниках, включая их должности, руководителей, отделы и роли.
   - **Таблицы `Projects` и `Tasks`** – описывают проекты и задачи, назначенные сотрудникам.

### Чтобы проверить решение, необходимо:
1. Запустить скрипты создания таблиц (PostgreSQL);
2. Запустить скрипты наполнения таблиц данными;
3. После того как база данных будет готова, можно выполнить SQL запросы из файлов 1_1 - 4_3 для каждой задачи.
Каждая задача расположена в отдельном файле, где в названии первая цифра означает порядковый номер таблицы из задания, а вторая цифра означает номер задачи (например 2_4 означает, что это SQL запрос к заданию для таблицы Автомобильные гонки (2), а выполненная задача - 4). В каждом файле добавлено условие задачи для удобства.
В запросах намеренно не используются псевдонимы таблиц (alias), для упрощения проверки.

## База данных 1. Транспортные средства
### Скрипт создания базы данных PostgreSQL
```sql
-- Создание таблицы Vehicle
 
CREATE TABLE Vehicle (
	maker VARCHAR(100) NOT NULL,
	model VARCHAR(100) NOT NULL,
	type VARCHAR(20) NOT NULL CHECK (type IN ('Car', 'Motorcycle', 'Bicycle')),
	PRIMARY KEY (model)
);
 
-- Создание таблицы Car
 
CREATE TABLE Car (
	vin VARCHAR(17) NOT NULL,
	model VARCHAR(100) NOT NULL,
	engine_capacity DECIMAL(4, 2) NOT NULL, -- объем двигателя в литрах
	horsepower INT NOT NULL,             	-- мощность в лошадиных силах
	price DECIMAL(10, 2) NOT NULL,       	-- цена в долларах
	transmission VARCHAR(20) NOT NULL CHECK (transmission IN ('Automatic', 'Manual')), -- тип трансмиссии
	PRIMARY KEY (vin),
	FOREIGN KEY (model) REFERENCES Vehicle(model)
);
 
-- Создание таблицы Motorcycle
 
CREATE TABLE Motorcycle (
	vin VARCHAR(17) NOT NULL,
	model VARCHAR(100) NOT NULL,
	engine_capacity DECIMAL(4, 2) NOT NULL, -- объем двигателя в литрах
	horsepower INT NOT NULL,             	-- мощность в лошадиных силах
	price DECIMAL(10, 2) NOT NULL,       	-- цена в долларах
	type VARCHAR(20) NOT NULL CHECK (type IN ('Sport', 'Cruiser', 'Touring')), -- тип мотоцикла
	PRIMARY KEY (vin),
	FOREIGN KEY (model) REFERENCES Vehicle(model)
);
 
-- Создание таблицы Bicycle
 
CREATE TABLE Bicycle (
	serial_number VARCHAR(20) NOT NULL,
	model VARCHAR(100) NOT NULL,
	gear_count INT NOT NULL,             	-- количество передач
	price DECIMAL(10, 2) NOT NULL,       	-- цена в долларах
	type VARCHAR(20) NOT NULL CHECK (type IN ('Mountain', 'Road', 'Hybrid')), -- тип велосипеда
	PRIMARY KEY (serial_number),
	FOREIGN KEY (model) REFERENCES Vehicle(model)
);
```
### Скрипт наполнения базы данными
```sql
-- Вставка данных в таблицу Vehicle
INSERT INTO Vehicle (maker, model, type) VALUES
('Toyota', 'Camry', 'Car'),
('Honda', 'Civic', 'Car'),
('Ford', 'Mustang', 'Car'),
('Yamaha', 'YZF-R1', 'Motorcycle'),
('Harley-Davidson', 'Sportster', 'Motorcycle'),
('Kawasaki', 'Ninja', 'Motorcycle'),
('Trek', 'Domane', 'Bicycle'),
('Giant', 'Defy', 'Bicycle'),
('Specialized', 'Stumpjumper', 'Bicycle');
-- Вставка данных в таблицу Car
INSERT INTO Car (vin, model, engine_capacity, horsepower, price, transmission) VALUES
('1HGCM82633A123456', 'Camry', 2.5, 203, 24000.00, 'Automatic'),
('2HGFG3B53GH123456', 'Civic', 2.0, 158, 22000.00, 'Manual'),
('1FA6P8CF0J1234567', 'Mustang', 5.0, 450, 55000.00, 'Automatic');
-- Вставка данных в таблицу Motorcycle
INSERT INTO Motorcycle (vin, model, engine_capacity, horsepower, price, type) VALUES
('JYARN28E9FA123456', 'YZF-R1', 1.0, 200, 17000.00, 'Sport'),
('1HD1ZK3158K123456', 'Sportster', 1.2, 70, 12000.00, 'Cruiser'),
('JKBVNAF156A123456', 'Ninja', 0.9, 150, 14000.00, 'Sport');
-- Вставка данных в таблицу Bicycle
INSERT INTO Bicycle (serial_number, model, gear_count, price, type) VALUES
('SN123456789', 'Domane', 22, 3500.00, 'Road'),
('SN987654321', 'Defy', 20, 3000.00, 'Road'),
('SN456789123', 'Stumpjumper', 30, 4000.00, 'Mountain');
```
   
## Заключение
Выполненные задачи подтверждают, что цель проекта достигнута.
