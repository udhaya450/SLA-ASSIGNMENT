create database schooldb;
use schooldb;

SET SQL_SAFE_UPDATES=0;

-- SQL Constraints Task PK & UK



-- 1. Create a Student table with:

-- StudentID,StudentName,Email,Age,Address

-- Make StudentID the Primary Key & ake Email a Unique Key.

create table  student (studentID int,studentName varchar(50),Email varchar(30),Age int,Address varchar(100)); 
alter table student add primary key(studentID);
alter table student add unique key(Email);

-- insert into student values(1,'jim','jim@gmail.com',26,'park avenue road');
-- insert into student values(1,'jam','jam@gmail.com',25,'100 feet road');
-- insert into student values(2,'jum','jim@gmail.com',null,'2nd feet road');
-- insert into student values(3,'sam','sam@gmail.com',22,'factory road');
-- select * from student;




-- 2. Create an Employee table with:

-- EmployeeID,EmployeeName,Desg,Salary,Email,Phone

-- Set EmployeeID as the Primary Key.

-- Set both Email and Phone as Unique Keys.

create table Employee(EmployeeID int primary key,EmployeeName varchar(30),Desg varchar(10),Salary int,Email varchar(30),phone int);
alter table Employee add unique key(Email , phone);



 


-- 3. Create a Product table with:

-- ProductID,ProductName,ProductCode,ProdDescription,Price

-- Make ProductID the Primary Key & Make ProductCode a Unique Key.

-- Insert 5 products and try inserting a duplicate ProductCode.

create table product(productID int primary Key,productName varchar(30),productCode varchar(20) unique key ,prodDescription varchar(50),price int);
insert into product values(1,'fruits','#130','Apples',300);
insert into product values(2,'vegitables','#131','Carrots',50);
insert into product values(1,'flowers','#132','Rose',30);
insert into product values(4,'Grains','#131','wheat',300);
insert into product values(5,'Nuts','#135','Almond',800);
select * from product;


-- 4. Create a Course table with:

-- CourseID,CourseName,CourseCode,Duration,CourseFee

-- Set CourseID as the Primary Key & Set CourseCode as a Unique Key.

-- Try inserting two courses with the same CourseCode.

create table course(courseID int,courseName varchar(30),courseCode int,Duration varchar(20),courseFees int, constraint pk_course primary key(courseID), constraint uk_course unique key(courseCode));
insert into course values(81,'JAVA full Stack',51,'6 Months',45000);
insert into course values(82,'Python full Stack',51,'4 Months',30000);



-- 5. Create a Users table with:

-- UserID,Username,Email,Password

-- Make UserID the Primary Key & Make both Username and Email Unique Keys.

-- Insert sample users and test duplicate Username and Email values.

create table Users(UserID INT primary key,Username varchar(20),Email varchar(30),password varchar(30), constraint uk_Users unique key(Email , password));
insert into users values(11,'Jhansi','jhansi@gmail.com','#123');
insert into users values(12,'sushant','sushant@gmail.com','#124');
insert into users values(12,'james','james@gmail.com','#124');
insert into users values(15,'charles','james@gmail.com','#124');



 