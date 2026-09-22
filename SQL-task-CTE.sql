create database CTE;
use CTE;
-- 1. Find Employees with Salary Greater Than Average Table: employees : emp_id , emp_name , department , salary Create a CTE named avg_salary that calculates the average salary of all employees. Then display employees whose salary is greater than the average salary.
CREATE TABLE department(
    dept_id INT,
    dept_name VARCHAR(50)
);

INSERT INTO department (dept_id, dept_name)
VALUES
(1, 'IT'),
(2, 'HR'),
(3, 'Finance'),
(4, 'Sales');

 CREATE TABLE employees (emp_id INT,emp_name VARCHAR(50),dept_id INT,manager_id INT,salary INT);
 

SELECT * FROM employees;
WITH avg_salary AS (
    SELECT AVG(salary) AS average_salary
    FROM employees
)
SELECT
    e.emp_id,
    e.emp_name,
    d.dept_name AS department,
    e.salary
FROM employees e
JOIN departments d
    ON e.dept_id = d.dept_id
WHERE e.salary > (
    SELECT average_salary
    FROM avg_salary
);

-- 2.Calculate Department-Wise Average Salary Using the employees table above Create a CTE named dept_salary that calculates the average salary for each department.Display:department,average_salary

WITH dept_salary AS (
    SELECT
        d.dept_name AS department,
        AVG(e.salary) AS average_salary
    FROM employees e
    JOIN departments d
        ON e.dept_id = d.dept_id
    GROUP BY d.dept_name
)
SELECT
    department,
    average_salary
FROM dept_salary;

-- 3.Find Students Who Scored Above Average Table: students:student_id , student_name , course , mark Create a CTE named average_mark to calculate the average mark. Then display students whose marks are greater than the average mark. Expected columns:student_name,course,markCREATE TABLE students (
   create table students (student_id INT,
    student_name VARCHAR(50),
    course VARCHAR(50),
    mark INT
);



INSERT INTO students
(student_id, student_name, course, mark)
VALUES
(1, 'Udhaya', 'Java', 85),
(2, 'Arun', 'Python', 90),
(3, 'Karthik', 'Java', 65),
(4, 'Vijay', 'Python', 55),
(5, 'Ajay', 'Java', 75),
(6, 'Ravi', 'Python', 40);

SELECT * FROM students;



WITH average_mark AS (
    SELECT AVG(mark) AS avg_mark
    FROM students
)
SELECT
    student_name,
    course,
    mark
FROM students
WHERE mark > (
    SELECT avg_mark
    FROM average_mark
);


-- 4. Find High-Priced Products Table: products:product_id , product_name , category , price Create a CTE named product_data. Inside the CTE, calculate: product_name,category,price Then display products whose price is greater than ₹20,000.

CREATE TABLE products (
    product_id INT,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price INT
);

INSERT INTO products
(product_id, product_name, category, price)
VALUES
(1, 'Laptop', 'Electronics', 60000),
(2, 'Mobile', 'Electronics', 30000),
(3, 'Tablet', 'Electronics', 20000),
(4, 'Keyboard', 'Accessories', 1500),
(5, 'Monitor', 'Electronics', 25000),
(6, 'Printer', 'Office', 18000);


SELECT * FROM products;
WITH product_data AS (
    SELECT
        product_name,
        category,
        price
    FROM products
)
SELECT
    product_name,
    category,
    price
FROM product_data
WHERE price > 20000;

-- 5. Calculate Employee Bonus Using the employees table: Create a CTE named employee_bonus. Calculate a 10% bonus for every employee. The CTE should contain:emp_id,emp_name,salary,bonus Then display the employee name, salary, bonus, and total salary.
SELECT * FROM employees;

WITH employee_bonus AS (
    SELECT
        emp_id,
        emp_name,
        salary,
        salary * 0.10 AS bonus
    FROM employees
)
SELECT
    emp_name,
    salary,
    bonus,
    salary + bonus AS total_salary
FROM employee_bonus;