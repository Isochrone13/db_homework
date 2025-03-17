/*Задача 4_1
Найти всех сотрудников, подчиняющихся Ивану Иванову (с EmployeeID = 1), 
включая их подчиненных и подчиненных подчиненных. Для каждого сотрудника 
вывести следующую информацию:
1. EmployeeID: идентификатор сотрудника.
2. Имя сотрудника.
3. ManagerID: Идентификатор менеджера.
4. Название отдела, к которому он принадлежит.
5. Название роли, которую он занимает.
6. Название проектов, к которым он относится (если есть, конкатенированные в одном столбце через запятую).
7. Название задач, назначенных этому сотруднику (если есть, конкатенированные в одном столбце через запятую).
8. Если у сотрудника нет назначенных проектов или задач, отобразить NULL.
Требования:
Рекурсивно извлечь всех подчиненных сотрудников Ивана Иванова и их подчиненных.
Для каждого сотрудника отобразить информацию из всех таблиц.
Результаты должны быть отсортированы по имени сотрудника.
Решение задачи должно представлять из себя один sql-запрос и задействовать 
ключевое слово RECURSIVE.*/

WITH RECURSIVE subordinates AS (
    -- Начинаем с прямых подчинённых Ивану Иванову
    SELECT 
        EmployeeID, 
        Name, 
        ManagerID, 
        DepartmentID, 
        RoleID
    FROM Employees
    WHERE EmployeeID = 1
    UNION ALL
    -- Рекурсивно выбираем подчинённых найденных сотрудников
    SELECT 
        employees.EmployeeID, 
        employees.Name, 
        employees.ManagerID, 
        employees.DepartmentID, 
        employees.RoleID
    FROM Employees
    INNER JOIN subordinates ON employees.ManagerID = subordinates.EmployeeID
)
SELECT 
    subordinates.EmployeeID,
    subordinates.Name,
    subordinates.ManagerID,
    departments.DepartmentName,
    roles.RoleName,
    result.projects,
    result.tasks
FROM subordinates
LEFT JOIN Departments ON subordinates.DepartmentID = departments.DepartmentID
LEFT JOIN Roles ON subordinates.RoleID = roles.RoleID
LEFT JOIN (
    -- Агрегируем проекты и задачи для сотрудника.
    SELECT 
        tasks.AssignedTo, 
        string_agg(DISTINCT projects.ProjectName, ', ') AS projects,
        string_agg(tasks.TaskName, ', ') AS tasks
    FROM Tasks
    LEFT JOIN Projects ON tasks.ProjectID = projects.ProjectID
    GROUP BY tasks.AssignedTo
) result ON subordinates.EmployeeID = result.AssignedTo
ORDER BY subordinates.Name;