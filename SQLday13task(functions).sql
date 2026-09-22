use joins;
CREATE TABLE employee (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(100),
    salary DECIMAL(10,2)
);

INSERT INTO employees (emp_id, emp_name, salary)
VALUES
(1, 'Udhaya', 25000),
(2, 'Arun', 30000),
(3, 'Karthik', 40000);
-- 1. Calculate Employee Annual Salary Create a function get_annual_salary() that accepts an employee's monthly salary and returns the annual salary. employees : emp_id ,emp_name ,salary * Create the function get_annual_salary(monthly_salary) * Calculate monthly_salary * 12 * Display employee name, monthly salary, and annual salary.
DELIMITER //

CREATE FUNCTION get_annual_salary(monthly_salary DECIMAL(10,2))
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    RETURN monthly_salary * 12;
END //

DELIMITER ;

SELECT 
    emp_name,
    salary AS monthly_salary,
    get_annual_salary(salary) AS annual_salary
FROM employees;

-- 2.Find Employee Experience Create a function calculate_experience() that accepts the employee's joining year and returns the number of years of experience. employees : emp_id ,emp_name joining_year * Create a function that accepts joining_year. * Calculate experience using the current year. * Display employee name, joining year, and experience.

CREATE TABLE employees_experience (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(100),
    joining_year INT
);

INSERT INTO employees_experience VALUES
(1, 'udhaya', 2022),
(2, 'Arun', 2020),
(3, 'Karthik', 2018);

DELIMITER //

CREATE FUNCTION calculate_experience(joining_year INT)
RETURNS INT
DETERMINISTIC
BEGIN
    RETURN YEAR(CURDATE()) - joining_year;
END //

DELIMITER ;

SELECT
    emp_name,
    joining_year,
    calculate_experience(joining_year) AS experience
FROM employees_experience;

-- 3.Calculate Student Grade Create a function get_grade() that accepts a student's mark and returns the grade. Use the following rules: 90 - 100 → A , 75 - 89 → B , 60 - 74 → C , 50 - 59 → D , Below 50 → F students: student_id , student_name , mark Create the function and execute: sql SELECT student_name, mark, get_grade(mark) AS grade FROM students;

CREATE TABLE students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(100),
    mark INT
);

INSERT INTO students VALUES
(1, 'Udhaya', 95),
(2, 'Arun', 82),
(3, 'Karthik', 68),
(4, 'Vijay', 55),
(5, 'Ajay', 40);

DELIMITER //

CREATE FUNCTION get_grade(mark INT)
RETURNS CHAR(1)
DETERMINISTIC
BEGIN
    DECLARE grade CHAR(1);

    IF mark >= 90 AND mark <= 100 THEN
        SET grade = 'A';
    ELSEIF mark >= 75 THEN
        SET grade = 'B';
    ELSEIF mark >= 60 THEN
        SET grade = 'C';
    ELSEIF mark >= 50 THEN
        SET grade = 'D';
    ELSE
        SET grade = 'F';
    END IF;

    RETURN grade;
END //

DELIMITER ;

SELECT 
    student_name,
    mark,
    get_grade(mark) AS grade
FROM students;

-- 4.Create a function calculate_discount() that accepts **product price** and **discount percentage**, then returns the discount amount.

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    price DECIMAL(10,2)
);

INSERT INTO products VALUES
(1, 'Laptop', 60000),
(2, 'Mobile', 30000),
(3, 'Tablet', 20000);

DELIMITER //

CREATE FUNCTION calculate_discount(
    product_price DECIMAL(10,2),
    discount_percentage DECIMAL(5,2)
)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    RETURN product_price * discount_percentage / 100;
END //

DELIMITER ;

SELECT
    product_name,
    price,
    calculate_discount(price, 10) AS discount_amount
FROM products;