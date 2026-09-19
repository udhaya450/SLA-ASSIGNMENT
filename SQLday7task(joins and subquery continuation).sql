-- -----------SQL JOIN Tasks —-----------

-- Task 1 – College Student Management
-- Use these 5 tables:
-- Students(StudentID, StudentName, CourseID, DepartmentID)
-- Courses(CourseID, CourseName, Duration)
-- Departments(DepartmentID, DepartmentName)
-- Marks(MarkID, StudentID, SubjectID, Marks)
-- Subjects(SubjectID, SubjectName)
-- Question:
-- Write a SQL query using appropriate JOINs to display:
-- StudentName, CourseName, DepartmentName, SubjectName, Marks
-- Display details of all students along with their course, department, subject, and marks.

use schemaa;
CREATE TABLE Departments (DepartmentID INT PRIMARY KEY,DepartmentName VARCHAR(50));

CREATE TABLE Courses (CourseID INT PRIMARY KEY,CourseName VARCHAR(50),Duration INT);

CREATE TABLE Students (StudentID INT PRIMARY KEY,StudentName VARCHAR(50),CourseID INT,DepartmentID INT,
FOREIGN KEY (CourseID) REFERENCES Courses(CourseID),FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID));

CREATE TABLE Subjects (SubjectID INT PRIMARY KEY,SubjectName VARCHAR(50));

CREATE TABLE Marks (MarkID INT PRIMARY KEY,StudentID INT,SubjectID INT,Marks INT,FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
FOREIGN KEY (SubjectID) REFERENCES Subjects(SubjectID));

INSERT INTO Departments VALUES(1, 'Computer Science'),(2, 'Information Technology'),(3, 'Electronics');
INSERT INTO Courses VALUES(101, 'B.Sc Computer Science', 3),(102, 'B.Tech IT', 4),(103, 'B.E ECE', 4);
INSERT INTO Students VALUES(1001, 'Udhaya', 102, 2),(1002, 'Arun', 101, 1),(1003, 'Kumar', 103, 3);
INSERT INTO Subjects VALUES(201, 'Java'),(202, 'SQL'),(203, 'Python');
INSERT INTO Marks VALUES(1, 1001, 201, 85),(2, 1001, 202, 90),(3, 1002, 201, 75),(4, 1003, 203, 80);

SELECT s.StudentName,c.CourseName,d.DepartmentName,sub.SubjectName,m.Marks
FROM Students s
INNER JOIN Courses c
ON s.CourseID = c.CourseID
INNER JOIN Departments d
ON s.DepartmentID = d.DepartmentID
INNER JOIN Marks m
ON s.StudentID = m.StudentID
INNER JOIN Subjects sub
ON m.SubjectID = sub.SubjectID;

---

-- Task 2 – Employee Payroll System
-- Use these 5 tables:
-- Employees(EmployeeID, EmployeeName, DepartmentID, DesignationID)
-- Departments(DepartmentID, DepartmentName)
-- Designations(DesignationID, DesignationName)
-- Salaries(SalaryID, EmployeeID, BasicSalary, Bonus)
-- Locations(LocationID, DepartmentID, City)

-- Question:
-- Write a query using JOINs to display:
-- EmployeeName, DepartmentName, DesignationName, BasicSalary, Bonus, CityDisplay employees along with their department, designation, salary, and department location.

CREATE TABLE Departments (DepartmentID INT PRIMARY KEY,DepartmentName VARCHAR(50));

CREATE TABLE Designations (DesignationID INT PRIMARY KEY,DesignationName VARCHAR(50));

CREATE TABLE Employees (EmployeeID INT PRIMARY KEY,EmployeeName VARCHAR(50),DepartmentID INT,DesignationID INT,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID),FOREIGN KEY (DesignationID) REFERENCES Designations(DesignationID));

CREATE TABLE Salaries (SalaryID INT PRIMARY KEY,EmployeeID INT,BasicSalary DECIMAL(10,2),Bonus DECIMAL(10,2),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID));

CREATE TABLE Locations (LocationID INT PRIMARY KEY,DepartmentID INT,City VARCHAR(50),FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID));

INSERT INTO Departments VALUES(1, 'HR'),(2, 'IT'),(3, 'Sales');
INSERT INTO Designations VALUES(101, 'Manager'),(102, 'Developer'),(103, 'Sales Executive');
INSERT INTO Employees VALUES(1001, 'Udhaya', 2, 102),(1002, 'Arun', 1, 101),(1003, 'Kumar', 3, 103);
INSERT INTO Salaries VALUES(1, 1001, 50000, 5000),(2, 1002, 45000, 4000),(3, 1003, 40000, 3000);
INSERT INTO Locations VALUES(1, 1, 'Chennai'),(2, 2, 'Bangalore'),(3, 3, 'Mumbai');

SELECT e.EmployeeName,d.DepartmentName,des.DesignationName,s.BasicSalary,s.Bonus,l.City
FROM Employees e
INNER JOIN Departments d
ON e.DepartmentID = d.DepartmentID
INNER JOIN Designations des
ON e.DesignationID = des.DesignationID
INNER JOIN Salaries s
ON e.EmployeeID = s.EmployeeID
INNER JOIN Locations l
ON d.DepartmentID = l.DepartmentID;
-- -----


-- Task 3 – Online Shopping System
-- Use these 5 tables:
-- Customers(CustomerID, CustomerName, City)
-- Orders(OrderID, CustomerID, OrderDate)
-- OrderDetails(OrderDetailID, OrderID, ProductID, Quantity)
-- Products(ProductID, ProductName, CategoryID, Price)
-- Categories(CategoryID, CategoryName)

-- Question:
-- Write a SQL query using multiple JOINs to display:
-- CustomerName, OrderDate, ProductName, CategoryName, Quantity, Price
-- Display all products purchased by each customer.

CREATE TABLE Customers (CustomerID INT PRIMARY KEY,CustomerName VARCHAR(50),City VARCHAR(50));

CREATE TABLE Orders (OrderID INT PRIMARY KEY,CustomerID INT,OrderDate DATE,
     FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID));

CREATE TABLE Categories (CategoryID INT PRIMARY KEY,CategoryName VARCHAR(50));

CREATE TABLE Products (ProductID INT PRIMARY KEY,ProductName VARCHAR(50),CategoryID INT,Price DECIMAL(10,2),
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID));

CREATE TABLE OrderDetails (OrderDetailID INT PRIMARY KEY,OrderID INT,ProductID INT,Quantity INT,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),FOREIGN KEY (ProductID) REFERENCES Products(ProductID));
    
INSERT INTO Customers VALUES(1, 'Udhaya', 'Chennai'),(2, 'Arun', 'Madurai'),(3, 'Kumar', 'Coimbatore');
INSERT INTO Orders VALUES(101, 1, '2026-09-10'),(102, 2, '2026-09-11'),(103, 1, '2026-09-12');
INSERT INTO Categories VALUES(10, 'Electronics'),(20, 'Books');
INSERT INTO Products VALUES(1001, 'Laptop', 10, 50000),(1002, 'Keyboard', 10, 1500),(1003, 'SQL Book', 20, 500);
INSERT INTO OrderDetails VALUES(1, 101, 1001, 1),(2, 101, 1002, 2),(3, 102, 1003, 1),(4, 103, 1003, 2);

SELECT c.CustomerName,o.OrderDate,p.ProductName,cat.CategoryName,od.Quantity,p.Price
FROM Customers c
INNER JOIN Orders o
ON c.CustomerID = o.CustomerID
INNER JOIN OrderDetails od
ON o.OrderID = od.OrderID
INNER JOIN Products p
ON od.ProductID = p.ProductID
INNER JOIN Categories cat
ON p.CategoryID = cat.CategoryID;

---

-- Task 4 – Hospital Management System
-- Use these 5 tables:
-- Patients(PatientID, PatientName, Gender, DoctorID)
-- Doctors(DoctorID, DoctorName, DepartmentID)
-- Departments(DepartmentID, DepartmentName)
-- Appointments(AppointmentID, PatientID, DoctorID, AppointmentDate)
-- Prescriptions(PrescriptionID, AppointmentID, MedicineID, Dosage)
-- Medicines(MedicineID, MedicineName)

-- Question:
-- Write a query using JOINs to display:
-- PatientName, DoctorName, DepartmentName, AppointmentDate, MedicineName, Dosage
-- Display patient appointment and prescription details.


CREATE TABLE Departments (DepartmentID INT PRIMARY KEY,DepartmentName VARCHAR(50));

CREATE TABLE Doctors (DoctorID INT PRIMARY KEY,DoctorName VARCHAR(50),DepartmentID INT,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID));

CREATE TABLE Patients (PatientID INT PRIMARY KEY,PatientName VARCHAR(50),Gender VARCHAR(10),DoctorID INT,
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID));

CREATE TABLE Appointments (AppointmentID INT PRIMARY KEY,PatientID INT,DoctorID INT,AppointmentDate DATE,
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID));

CREATE TABLE Medicines (MedicineID INT PRIMARY KEY,MedicineName VARCHAR(50));

CREATE TABLE Prescriptions (PrescriptionID INT PRIMARY KEY,AppointmentID INT,MedicineID INT,Dosage VARCHAR(50),
    FOREIGN KEY (AppointmentID) REFERENCES Appointments(AppointmentID),
    FOREIGN KEY (MedicineID) REFERENCES Medicines(MedicineID));
    
INSERT INTO Departments VALUES(1, 'Cardiology'),(2, 'Neurology'),(3, 'General Medicine');
INSERT INTO Doctors VALUES(101, 'Dr. Ravi', 1),(102, 'Dr. Kumar', 2),(103, 'Dr. Priya', 3);
INSERT INTO Patients VALUES(1001, 'Udhaya', 'Male', 101),(1002, 'Arun', 'Male', 102),(1003, 'Divya', 'Female', 103);
INSERT INTO Appointments VALUES(501, 1001, 101, '2026-09-10'),(502, 1002, 102, '2026-09-11'),(503, 1003, 103, '2026-09-12');
INSERT INTO Medicines VALUES(201, 'Paracetamol'),(202, 'Vitamin Tablet'),(203, 'Antibiotic');
INSERT INTO Prescriptions VALUES(1, 501, 201, '1 tablet'),(2, 502, 202, '2 tablets'),(3, 503, 203, '1 tablet');

SELECT p.PatientName,d.DoctorName,dept.DepartmentName,a.AppointmentDate,m.MedicineName,pr.Dosage
FROM Patients p
INNER JOIN Appointments a
ON p.PatientID = a.PatientID
INNER JOIN Doctors d
ON a.DoctorID = d.DoctorID
INNER JOIN Departments dept
ON d.DepartmentID = dept.DepartmentID
INNER JOIN Prescriptions pr
ON a.AppointmentID = pr.AppointmentID
INNER JOIN Medicines m
ON pr.MedicineID = m.MedicineID;

---

-- Task 5 – Company Project Management
-- Use these 5 tables:
-- Employees(EmployeeID, EmployeeName, DepartmentID)
-- Departments(DepartmentID, DepartmentName)
-- Projects(ProjectID, ProjectName, DepartmentID)
-- EmployeeProjects(EmployeeID, ProjectID, AssignedDate)
-- Managers(ManagerID, ManagerName, DepartmentID)

-- Question:
-- Write a SQL query using multiple JOINs to display:
-- EmployeeName, DepartmentName, ProjectName, AssignedDate, ManagerName
-- Display employees, their departments, projects, assignment dates, and department managers.

CREATE TABLE Departments (DepartmentID INT PRIMARY KEY,DepartmentName VARCHAR(50));

CREATE TABLE Employees (EmployeeID INT PRIMARY KEY,EmployeeName VARCHAR(50),DepartmentID INT,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID));

CREATE TABLE Projects (ProjectID INT PRIMARY KEY,ProjectName VARCHAR(50),DepartmentID INT,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID));

CREATE TABLE EmployeeProjects (EmployeeID INT,ProjectID INT,AssignedDate DATE,
    PRIMARY KEY (EmployeeID, ProjectID),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID),
    FOREIGN KEY (ProjectID) REFERENCES Projects(ProjectID));

CREATE TABLE Managers (ManagerID INT PRIMARY KEY,ManagerName VARCHAR(50),DepartmentID INT,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID));
    
INSERT INTO Departments VALUES(1, 'HR'),(2, 'IT'),(3, 'Sales');
INSERT INTO Employees VALUES(101, 'Udhaya', 2),(102, 'Arun', 1),(103, 'Kumar', 3);
INSERT INTO Projects VALUES(201, 'Website Development', 2),(202, 'Recruitment System', 1),(203, 'Sales App', 3);
INSERT INTO EmployeeProjects VALUES(101, 201, '2026-09-01'),(102, 202, '2026-09-02'),(103, 203, '2026-09-03');
INSERT INTO Managers VALUES(301, 'Ravi', 1),(302, 'Priya', 2),(303, 'Suresh', 3);

SELECT e.EmployeeName,
       d.DepartmentName,
       p.ProjectName,
       ep.AssignedDate,
       m.ManagerName
FROM Employees e
INNER JOIN Departments d
ON e.DepartmentID = d.DepartmentID
INNER JOIN EmployeeProjects ep
ON e.EmployeeID = ep.EmployeeID
INNER JOIN Projects p
ON ep.ProjectID = p.ProjectID
INNER JOIN Managers m
ON d.DepartmentID = m.DepartmentID;

---

-- ----------------SQL SUBQUERY Tasks------------------

-- Task 1 – Students and Marks
-- Use these tables:
-- Students(StudentID, StudentName, CourseID)
-- Courses(CourseID, CourseName)
-- Subjects(SubjectID, SubjectName)
-- Marks(MarkID, StudentID, SubjectID, Marks)

-- Question:
-- Write a query using a subquery to find students who scored more than the average marks of all students.
-- Display:StudentName, Marks

CREATE TABLE Courses (CourseID INT PRIMARY KEY,CourseName VARCHAR(50));

CREATE TABLE Students (StudentID INT PRIMARY KEY,StudentName VARCHAR(50),CourseID INT,
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID));

CREATE TABLE Subjects (SubjectID INT PRIMARY KEY,SubjectName VARCHAR(50));

CREATE TABLE Marks (MarkID INT PRIMARY KEY,StudentID INT,SubjectID INT,Marks INT,
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (SubjectID) REFERENCES Subjects(SubjectID));
    
INSERT INTO Courses VALUES(1, 'B.Tech IT'),(2, 'B.Sc CS');
INSERT INTO Students VALUES(101, 'Udhaya', 1),(102, 'Arun', 1),(103, 'Kumar', 2),(104, 'Priya', 2);
INSERT INTO Subjects VALUES(201, 'SQL'),(202, 'Java');
INSERT INTO Marks VALUES(1, 101, 201, 90),(2, 102, 201, 60),(3, 103, 201, 75),(4, 104, 201, 85);

SELECT s.StudentName, m.Marks
FROM Students s
INNER JOIN Marks m
ON s.StudentID = m.StudentID
WHERE m.Marks > (
    SELECT AVG(Marks)
    FROM Marks);

---

-- Task 2 – Employee Salary
-- Use these 5 tables:
-- Employees(EmployeeID, EmployeeName, DepartmentID)
-- Departments(DepartmentID, DepartmentName)
-- Salaries(SalaryID, EmployeeID, BasicSalary)
-- Designations(DesignationID, DesignationName)
-- EmployeeDesignations(EmployeeID, DesignationID)

-- Question:
-- Write a query using a subquery to find employees whose salary is greater than the average salary of all employees.
-- Display:EmployeeName, BasicSalary

CREATE TABLE Departments (DepartmentID INT PRIMARY KEY,DepartmentName VARCHAR(50));

CREATE TABLE Employees (EmployeeID INT PRIMARY KEY,EmployeeName VARCHAR(50),DepartmentID INT,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID));

CREATE TABLE Salaries (SalaryID INT PRIMARY KEY,EmployeeID INT,BasicSalary DECIMAL(10,2),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID));

CREATE TABLE Designations (DesignationID INT PRIMARY KEY,DesignationName VARCHAR(50));

CREATE TABLE EmployeeDesignations (EmployeeID INT,DesignationID INT,
    PRIMARY KEY (EmployeeID, DesignationID),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID),
    FOREIGN KEY (DesignationID) REFERENCES Designations(DesignationID)
);

INSERT INTO Departments VALUES(1, 'IT'),(2, 'HR'),(3, 'Sales');

INSERT INTO Employees VALUE(101, 'Udhaya', 1),(102, 'Arun', 1),(103, 'Kumar', 2),(104, 'Priya', 3);

INSERT INTO Salaries VALUES(1, 101, 60000),(2, 102, 45000),(3, 103, 50000),(4, 104, 40000);

INSERT INTO Designations VALUES(201, 'Developer'),(202, 'Manager'),(203, 'HR Executive');

INSERT INTO EmployeeDesignations VALUES(101, 201),(102, 201),(103, 202),(104, 203);

SELECT e.EmployeeName, s.BasicSalary
FROM Employees e
INNER JOIN Salaries s
ON e.EmployeeID = s.EmployeeID
WHERE s.BasicSalary > (
    SELECT AVG(BasicSalary)
    FROM Salaries
);
---

-- Task 3 – Product and Category
-- Use these 5 tables:
-- Products(ProductID, ProductName, CategoryID, Price)
-- Categories(CategoryID, CategoryName)
-- Customers(CustomerID, CustomerName)
-- Orders(OrderID, CustomerID)
-- OrderDetails(OrderDetailID, OrderID, ProductID, Quantity)

-- Question:
-- Write a query using a subquery to find products whose price is greater than the average price of products in the same category.
-- Display:ProductName, Price, CategoryID

CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(50)
);

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(50),
    CategoryID INT,
    Price DECIMAL(10,2),
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(50)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

INSERT INTO Categories VALUES(1, 'Electronics'),(2, 'Books'),(3, 'Clothing');
INSERT INTO Products VALUES(101, 'Laptop', 1, 50000),(102, 'Keyboard', 1, 1500),(103, 'Mouse', 1, 2500),(104, 'SQL Book', 2, 500),(105, 'Java Book', 2, 800),(106, 'T-Shirt', 3, 1000);
INSERT INTO Customers VALUES(201, 'Udhaya'),(202, 'Arun');
INSERT INTO Orders VALUES(301, 201),(302, 202);
INSERT INTO OrderDetails VALUES(1, 301, 101, 1),(2, 301, 102, 2),(3, 302, 104, 1);

SELECT ProductName, Price, CategoryID
FROM Products p
WHERE Price > (
    SELECT AVG(Price)
    FROM Products
    WHERE CategoryID = p.CategoryID
);

---

-- Task 4 – Department and Employees
-- Use these 4 tables:
-- Employees(EmployeeID, EmployeeName, DepartmentID, Salary)
-- Departments(DepartmentID, DepartmentName)
-- Projects(ProjectID, ProjectName, DepartmentID)
-- EmployeeProjects(EmployeeID, ProjectID)

-- Question:
-- Write a query using a subquery to find employees who earn more than the average salary of their own department.
-- isplay:EmployeeName, Salary, DepartmentID

CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50)
);

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    EmployeeName VARCHAR(50),
    DepartmentID INT,
    Salary DECIMAL(10,2),
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

CREATE TABLE Projects (
    ProjectID INT PRIMARY KEY,
    ProjectName VARCHAR(50),
    DepartmentID INT,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

CREATE TABLE EmployeeProjects (
    EmployeeID INT,
    ProjectID INT,
    PRIMARY KEY (EmployeeID, ProjectID),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID),
    FOREIGN KEY (ProjectID) REFERENCES Projects(ProjectID)
);

INSERT INTO Departments VALUES(1, 'IT'),(2, 'HR'),(3, 'Sales');
INSERT INTO Employees VALUES(101, 'Udhaya', 1, 60000),(102, 'Arun', 1, 45000),(103, 'Kumar', 2, 50000),(104, 'Priya', 2, 40000),(105, 'Ravi', 3, 55000);
INSERT INTO Projects VALUES(201, 'Website', 1),(202, 'Recruitment', 2),(203, 'Sales App', 3);
INSERT INTO EmployeeProjects VALUES(101, 201),(102, 201),(103, 202),(104, 202),(105, 203);

SELECT EmployeeName, Salary, DepartmentID
FROM Employees e
WHERE Salary > (
    SELECT AVG(Salary)
    FROM Employees
    WHERE DepartmentID = e.DepartmentID
);

---

-- Task 5 – Customers and Orders

-- Use these 5 tables:
-- Customers(CustomerID, CustomerName, City)
-- Orders(OrderID, CustomerID, OrderDate)
-- OrderDetails(OrderDetailID, OrderID, ProductID, Quantity)
-- Products(ProductID, ProductName, Price)
-- Categories(CategoryID, CategoryName)

-- Question:
-- Write a query using a subquery to find customers who have placed more orders than the average number of orders placed by customers.
-- Display:CustomerID, CustomerName, TotalOrders

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(50),
    City VARCHAR(50)
);

CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(50)
);

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(50),
    Price DECIMAL(10,2),
    CategoryID INT,
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

INSERT INTO Customers VALUES(1, 'Udhaya', 'Chennai'),(2, 'Arun', 'Madurai'),(3, 'Kumar', 'Coimbatore');
INSERT INTO Categories VALUES(10, 'Electronics'),(20, 'Books');
INSERT INTO Products VALUES(101, 'Laptop', 50000, 10),(102, 'SQL Book', 500, 20);
INSERT INTO Orders VALUES(201, 1, '2026-09-01'),(202, 1, '2026-09-05'),(203, 1, '2026-09-10'),(204, 2, '2026-09-03'),(205, 3, '2026-09-07');
INSERT INTO OrderDetails VALUES(1, 201, 101, 1),(2, 202, 102, 2),(3, 203, 101, 1),(4, 204, 102, 1),(5, 205, 101, 1);

SELECT CustomerID,
       CustomerName,
       COUNT(OrderID) AS TotalOrders
FROM Customers c
INNER JOIN Orders o
ON c.CustomerID = o.CustomerID
GROUP BY CustomerID, CustomerName
HAVING COUNT(OrderID) > (
    SELECT AVG(order_count)
    FROM (
        SELECT COUNT(OrderID) AS order_count
        FROM Orders
        GROUP BY CustomerID
    ) 
);

