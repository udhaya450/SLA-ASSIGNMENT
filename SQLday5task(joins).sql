create database joins;
use  joins;
CREATE TABLE departments (dept_id INT,dept_name VARCHAR(50));
CREATE TABLE employees (emp_id INT,emp_name VARCHAR(50),dept_id INT,manager_id INT,salary INT);
CREATE TABLE projects (project_id INT,project_name VARCHAR(50),dept_id INT);
CREATE TABLE emp_projects (emp_id INT,project_id INT); 
CREATE TABLE locations (location_id INT,dept_id INT,city VARCHAR(50));
INSERT INTO departments VALUES(1, 'IT'),(2, 'HR'),(3, 'Finance'),(4, 'Sales');
INSERT INTO employees VALUES(1, 'Alice', 1, NULL, 80000),(2, 'Bob', 1, 1, 60000),(3, 'Charlie', 2, 1, 50000),(4, 'David', 3, 2, 70000),(5, 'Eva', NULL, 2, 45000); 
INSERT INTO projects VALUES(101, 'Website', 1),(102, 'Payroll', 3),(103, 'Recruitment', 2); 
INSERT INTO emp_projects VALUES(1, 101),(2, 101),(3, 103),(4, 102);
INSERT INTO locations VALUES(1, 1, 'New York'),(2, 2, 'London'),(3, 3, 'Tokyo');

select * from departments;
select * from employees;
select * from projects;
select * from emp_projects;
select * from locations;


-- 1.Get employee names with their department names.
 select emp_name,dept_name from employees
 inner join departments where employees.dept_id=departments.dept_id;
 
 -- 2.Get all employees including those without departments.
 select e.emp_name,d.dept_name from employees e left join departments d on d.dept_id =e.dept_id;
 
 -- 3.Get all departments even if no employees exist.
   SELECT d.dept_name, e.emp_name FROM departments d LEFT JOIN employees e ON d.dept_id = e.dept_id;
   
-- 4.Find employees working on projects.
	SELECT e.emp_name, p.project_name FROM employees e INNER JOIN emp_projects ep ON e.emp_id = ep.emp_id
	INNER JOIN projects p ON ep.project_id = p.project_id;
    
-- 5.Find employees NOT assigned to any project.
	SELECT e.emp_name FROM employees e LEFT JOIN emp_projects ep ON e.emp_id = ep.emp_id WHERE ep.project_id IS NULL;

-- 6.List projects with department name.
	SELECT p.project_name, d.dept_name FROM projects p INNER JOIN departments d ON p.dept_id = d.dept_id;

-- 7.Get employee names with department and city.
 SELECT e.emp_name, d.dept_name, l.city FROM employees e INNER JOIN departments d
 ON e.dept_id = d.dept_id INNER JOIN locations l ON d.dept_id = l.dept_id;

-- 8.Get employees and their manager names (SELF JOIN).

SELECT e.emp_name AS employee, m.emp_name AS manager FROM employees e LEFT JOIN employees m ON e.manager_id = m.emp_id;

-- 9.Find departments with no projects.
SELECT d.dept_name FROM departments d LEFT JOIN projects p ON d.dept_id = p.dept_id WHERE p.project_id IS NULL;

-- 10.Get employees earning more than their manager.

SELECT e.emp_name AS employee,
e.salary AS employee_salary,
m.emp_name AS manager,
m.salary AS manager_salary FROM employees e JOIN employees m ON e.manager_id = m.emp_id WHERE e.salary > m.salary;
       
-- 11.Show department-wise employee count.
SELECT d.dept_name,
       COUNT(e.emp_id) AS employee_count FROM departments d LEFT JOIN employees e ON d.dept_id = e.dept_id GROUP BY d.dept_id, d.dept_name;

-- 12.List employees with no department.
SELECT e.emp_name FROM employees e LEFT JOIN departments d ON e.dept_id = d.dept_id WHERE d.dept_id IS NULL;

-- 13.Get project count per department.

SELECT d.dept_name,
COUNT(p.project_id) AS project_count FROM departments d LEFT JOIN projects p ON d.dept_id = p.dept_id GROUP BY d.dept_id, d.dept_name;

-- 14.Find employees working in IT department.

SELECT e.emp_name FROM employees e INNER JOIN departments d ON e.dept_id = d.dept_id WHERE d.dept_name = 'IT';

-- 15.Get employees with their project names (if any).

SELECT e.emp_name, p.project_name FROM employees e LEFT JOIN emp_projects ep
ON e.emp_id = ep.emp_id LEFT JOIN projects p ON ep.project_id = p.project_id;

-- 16.Get departments and their locations.
SELECT d.dept_name, l.city FROM departments d LEFT JOIN locations l ON d.dept_id = l.dept_id;

-- 17.Find employees working in Tokyo.
SELECT e.emp_name
FROM employees e JOIN departments d ON e.dept_id = d.dept_id
JOIN locations l ON d.dept_id = l.dept_id WHERE l.city = 'Tokyo'; 

-- 18.Show project name with employee count.

SELECT p.project_name, COUNT(ep.emp_id) AS employee_count FROM projects p
LEFT JOIN emp_projects ep ON p.project_id = ep.project_id GROUP BY p.project_id, p.project_name;

-- 19.Find departments having more than 1 employee.

SELECT d.dept_name, COUNT(e.emp_id) AS employee_count
FROM departments d JOIN employees e
ON d.dept_id = e.dept_id GROUP BY d.dept_id, d.dept_name HAVING COUNT(e.emp_id) > 1;

-- 20.Get employees and their department & project.

SELECT e.emp_name, d.dept_name,p.project_name FROM employees e LEFT JOIN departments d
ON e.dept_id = d.dept_id LEFT JOIN emp_projects ep
ON e.emp_id = ep.emp_id LEFT JOIN projects p ON ep.project_id = p.project_id;

-- 21.Find employees without managers.

SELECT e.emp_name
FROM employees e LEFT JOIN employees m ON e.manager_id = m.emp_id WHERE e.manager_id IS NULL;

-- 22.Get all possible employee–project combinations (CROSS JOIN).

SELECT e.emp_name, p.project_name
FROM employees e
CROSS JOIN projects p;

-- 23.Find employees who work in same department as Alice.

SELECT e.emp_name FROM employees e JOIN departments d
ON e.dept_id = d.dept_id WHERE d.dept_id = (
    SELECT dept_id FROM employees WHERE emp_name = 'Alice'
);

-- 24.FULL OUTER JOIN (Departments & Employees) – MySQL way.

SELECT d.dept_name, e.emp_name
FROM departments d LEFT JOIN employees e ON d.dept_id = e.dept_id
UNION
SELECT d.dept_name, e.emp_name FROM departments d RIGHT JOIN employees e ON d.dept_id = e.dept_id;

-- 25.Find departments with employees but no location.

SELECT DISTINCT d.dept_name FROM departments d JOIN employees e
ON d.dept_id = e.dept_id LEFT JOIN locations l ON d.dept_id = l.dept_id WHERE l.location_id IS NULL;

