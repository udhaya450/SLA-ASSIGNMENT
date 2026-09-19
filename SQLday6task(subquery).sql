show databases;
create database schemaa;
use schemaa;
SET SQL_SAFE_UPDATES = 0;

CREATE TABLE Departments (dept_id INT PRIMARY KEY,dept_name VARCHAR(50),location VARCHAR(50));

CREATE TABLE Employees (emp_id INT PRIMARY KEY,emp_name VARCHAR(50),job_title VARCHAR(50),manager_id INT,hire_date DATE,salary DECIMAL(10,2),
dept_id INT,FOREIGN KEY (dept_id) REFERENCES Departments(dept_id));

CREATE TABLE Projects (project_id INT PRIMARY KEY,project_name VARCHAR(50),budget DECIMAL(12,2),dept_id INT,FOREIGN KEY (dept_id) REFERENCES Departments(dept_id));

CREATE TABLE Employee_Projects (emp_id INT,project_id INT,hours_worked INT,PRIMARY KEY (emp_id, project_id),FOREIGN KEY (emp_id) REFERENCES Employees(emp_id),
FOREIGN KEY (project_id) REFERENCES Projects(project_id));

INSERT INTO Departments VALUES(10, '&#39;HR&#39;', '&#39;New York&#39;'),(20, '&#39;Engineering&#39;', '&#39;San Francisco&#39;'),(30, '&#39;Marketing&#39;', '&#39;London&#39;'),
(40, '&#39;Sales&#39;', '&#39;Chicago&#39;'),(50, '&#39;Legal&#39;', '&#39;Toronto&#39;');
select * from departments;

INSERT INTO Employees VALUES
(101, '&#39;Alice Smith&#39;', '&#39;HR Manager&#39;', NULL,'2020-01-15', 95000.00, 10),
(102, '&#39;Bob Jones&#39;', '&#39;Software Engineer&#39;', 105, '2021-03-22', 105000.00, 20),
(103, '&#39;Charlie Brown&#39;', '&#39;QA Engineer&#39;', 105, '2022-06-01', 70000.00, 20),
(104, '&#39;David Miller&#39;', '&#39;Marketing Specialist&#39;', 106, '2023-02-10', 65000.00,30),
(105, '&#39;Emma Davis&#39;', '&#39;Engineering Director&#39;', NULL,  '2019-05-12 ', 150000.00,20),
(106, '&#39;Frank Wilson&#39;', '&#39;Marketing Director&#39;', NULL, '2018-11-20 ', 140000.00,30),
(107, '&#39;Grace Lee&#39;', '&#39;Sales Rep&#39;', 108,' 2024-01-05 ', 55000.00, 40),
(108, '&#39;Henry Clark&#39;', '&#39;Sales Manager&#39;', NULL, '2017-03-15 ', 115000.00, 40),
(109, '&#39;Ivy Taylor&#39;', '&#39;Software Engineer&#39;', 105, '2025-08-19' , 98000.00, 20);
select * from Employees;

INSERT INTO Projects VALUES
(501, '&#39;Apollo Project&#39;', 250000.00, 20),
(502, '&#39;Zeus Initiative&#39;', 120000.00, 20),
(503,' &#39;Global Branding&#39;', 85000.00, 30),
(504, '&#39;CRM Migration&#39;', 150000.00, 40),
(505, '&#39;Talent Acquisition&#39;', 30000.00, 10);
select * from projects;

INSERT INTO Employee_Projects VALUES
(102, 501, 120),
(102, 502, 80),
(103, 501, 150),
(104, 503, 200),
(105, 501, 40),
(107, 504, 180),
(108, 504, 50),
(109, 502, 100);
select * from Employee_Projects;

-- Q26. Employees who earn more than the company average salary
SELECT emp_name, salary
FROM Employees
WHERE salary > (
    SELECT AVG(salary)
    FROM Employees
);

-- Q27. Employees working in Engineering department using subquery
SELECT emp_name, job_title
FROM Employees
WHERE dept_id = (
    SELECT dept_id
    FROM Departments
    WHERE dept_name = 'Engineering'
);

-- Q28. Employees working on at least one project
SELECT emp_name
FROM Employees
WHERE emp_id IN (
    SELECT emp_id
    FROM Employee_Projects
);

-- Q29. Employees NOT working on any project
SELECT emp_name
FROM Employees
WHERE emp_id NOT IN (
    SELECT emp_id
    FROM Employee_Projects
);

-- Q30. Project with the highest budget
SELECT project_name, budget
FROM Projects
WHERE budget = (
    SELECT MAX(budget)
    FROM Projects
);

-- Q31. Departments having higher-than-average project budget allocation
SELECT dept_name
FROM Departments
WHERE dept_id IN (
    SELECT dept_id
    FROM Projects
    WHERE budget > (
        SELECT AVG(budget)
        FROM Projects
    )
);
-- Q32. Employees earning more than the maximum salary of Marketing department
SELECT emp_name, salary
FROM Employees
WHERE salary > (
    SELECT MAX(salary)
    FROM Employees
    WHERE dept_id = (
        SELECT dept_id
        FROM Departments
        WHERE dept_name = 'Marketing'
    )
);

-- Q33. Employees earning more than the average salary of their own department
SELECT emp_name, salary, dept_id
FROM Employees e
WHERE salary > (
    SELECT AVG(salary)
    FROM Employees
    WHERE dept_id = e.dept_id
);

-- Q34. Departments that actually have employees using EXISTS
SELECT dept_name
FROM Departments d
WHERE EXISTS (
    SELECT 1
    FROM Employees e
    WHERE e.dept_id = d.dept_id
);
-- Q35. Departments that do not have any projects using NOT EXISTS
SELECT dept_name
FROM Departments d
WHERE NOT EXISTS (
    SELECT 1
    FROM Projects p
    WHERE p.dept_id = d.dept_id
);
-- Q36. Employee names alongside total company payroll
SELECT emp_name, salary,
       (
           SELECT SUM(salary)
           FROM Employees
       ) AS total_company_payroll
FROM Employees;

-- Q37. Oldest employee(s) based on hire date
SELECT emp_name, hire_date
FROM Employees
WHERE hire_date = (
    SELECT MIN(hire_date)
    FROM Employees
);

-- Q38. Second highest salary
SELECT MAX(salary) AS second_highest_salary
FROM Employees
WHERE salary < (
    SELECT MAX(salary)
    FROM Employees
);

-- Q39. Projects having budget greater than all projects managed by Sales department
SELECT project_name, budget
FROM Projects
WHERE budget > ALL (
    SELECT budget
    FROM Projects
    WHERE dept_id = (
        SELECT dept_id
        FROM Departments
        WHERE dept_name = 'Sales'
    )
);

-- Q40. Employees whose manager works in a different department
SELECT emp_name, dept_id, manager_id
FROM Employees e
WHERE manager_id IS NOT NULL
AND dept_id <> (
    SELECT dept_id
    FROM Employees m
    WHERE m.emp_id = e.manager_id
);

-- Q41. Department with the highest number of employees
SELECT dept_name
FROM Departments
WHERE dept_id = (
    SELECT dept_id
    FROM Employees
    GROUP BY dept_id
    ORDER BY COUNT(*) DESC
    LIMIT 1
);

-- Q42. Employees working on the project with the longest hours logged
SELECT emp_name
FROM Employees
WHERE emp_id IN (
    SELECT emp_id
    FROM Employee_Projects
    WHERE hours_worked = (
        SELECT MAX(hours_worked)
        FROM Employee_Projects
    )
);

-- Q43. Departments located in cities starting with 'New' or 'San' using a subquery
SELECT dept_name, location
FROM Departments
WHERE dept_id IN (
    SELECT dept_id
    FROM Departments
    WHERE location LIKE 'New%'
       OR location LIKE 'San%'
);

-- Q44. Employees whose salary is higher than the salary of any employee hired in 2024

SELECT emp_name, salary
FROM Employees
WHERE salary > ANY (
    SELECT salary
    FROM Employees
    WHERE YEAR(hire_date) = 2024
);

-- Q45. Managers who supervise at least 2 employees
SELECT emp_name
FROM Employees
WHERE emp_id IN (
    SELECT manager_id
    FROM Employees
    WHERE manager_id IS NOT NULL
    GROUP BY manager_id
    HAVING COUNT(*) >= 2
);

-- Q46. Projects whose budget is lower than the average project budget
SELECT project_name, budget
FROM Projects
WHERE budget < (
    SELECT AVG(budget)
    FROM Projects
);

-- Q47. Employees who are the only ones working on their specific project
SELECT emp_name
FROM Employees
WHERE emp_id IN (
    SELECT emp_id
    FROM Employee_Projects ep
    WHERE (
        SELECT COUNT(*)
        FROM Employee_Projects
        WHERE project_id = ep.project_id
    ) = 1
);

-- Q48. Employee name, salary, and difference from department average salary
SELECT emp_name,
       salary,
       salary - (
           SELECT AVG(e2.salary)
           FROM Employees e2
           WHERE e2.dept_id = e.dept_id
       ) AS salary_difference
FROM Employees e;

-- Q49. Department(s) with minimum total payroll
SELECT dept_name
FROM Departments
WHERE dept_id = (
    SELECT dept_id
    FROM Employees
    GROUP BY dept_id
    ORDER BY SUM(salary)
    LIMIT 1
);

-- Q50. Projects having at least one Engineering employee
SELECT project_name
FROM Projects
WHERE project_id IN (
    SELECT project_id
    FROM Employee_Projects
    WHERE emp_id IN (
        SELECT emp_id
        FROM Employees
        WHERE dept_id = (
            SELECT dept_id
            FROM Departments
            WHERE dept_name = 'Engineering'
        )
    )
);




