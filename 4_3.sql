/*Задача 4_3
Найти всех сотрудников, которые занимают роль менеджера и имеют подчиненных 
(то есть число подчиненных больше 0). Для каждого такого сотрудника вывести 
следующую информацию:
1. EmployeeID: идентификатор сотрудника.
2. Имя сотрудника.
3. Идентификатор менеджера.
4. Название отдела, к которому он принадлежит.
5. Название роли, которую он занимает.
6. Название проектов, к которым он относится (если есть, конкатенированные в одном столбце).
7. Название задач, назначенных этому сотруднику (если есть, конкатенированные в одном столбце).
8. Общее количество подчиненных у каждого сотрудника (включая их подчиненных).
9. Если у сотрудника нет назначенных проектов или задач, отобразить NULL.
Решение задачи должно представлять из себя один sql-запрос и задействовать ключевое слово 
RECURSIVE.*/

WITH RECURSIVE managers AS (
  -- Отбираем менеджеров
  SELECT 
    employees.EmployeeID AS manager_id,
    employees.EmployeeID AS subordinate_id
  FROM Employees
  JOIN Roles ON employees.RoleID = roles.RoleID
  WHERE roles.RoleName = 'Менеджер'
  UNION ALL
  -- Рекурсивно выбираем подчинённых найденных сотрудников
  SELECT 
    managers.manager_id,
    employees.EmployeeID
  FROM managers
  JOIN Employees ON employees.ManagerID = managers.subordinate_id
),
all_subordinates AS (
  -- Подсчитываем всех подчинённых для каждого менеджера (исключая самого менеджера)
  SELECT 
    manager_id, 
    COUNT(*) - 1 AS total_subordinates
  FROM managers
  GROUP BY manager_id
  HAVING COUNT(*) - 1 > 0
),
all_projects AS (
  -- Агрегируем проекты (по задачам) для каждого сотрудника
  SELECT 
    tasks.AssignedTo, 
    string_agg(DISTINCT projects.ProjectName, ', ') AS projects
  FROM Tasks
  LEFT JOIN Projects ON tasks.ProjectID = projects.ProjectID
  GROUP BY tasks.AssignedTo
),
all_tasks AS (
  -- Агрегируем задачи для каждого сотрудника
  SELECT 
    AssignedTo, 
    string_agg(TaskName, ', ') AS tasks
  FROM Tasks
  GROUP BY AssignedTo
)
SELECT 
  employees.EmployeeID,
  employees.Name,
  employees.ManagerID,
  departments.DepartmentName,
  roles.RoleName,
  all_projects.projects,
  all_tasks.tasks,
  all_subordinates.total_subordinates
FROM Employees
JOIN all_subordinates ON employees.EmployeeID = all_subordinates.manager_id
JOIN Departments ON employees.DepartmentID = departments.DepartmentID
JOIN Roles ON employees.RoleID = roles.RoleID
LEFT JOIN all_projects ON employees.EmployeeID = all_projects.AssignedTo
LEFT JOIN all_tasks ON employees.EmployeeID = all_tasks.AssignedTo
ORDER BY employees.EmployeeID;

