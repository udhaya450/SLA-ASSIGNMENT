
-- 1. Create a new database named schoolDB.
create database schoolDb;
use schoolDb;

-- 2.Create a students , customer, staff, Product ,user table do all ddl & dml opearation (each table min 5 columns)
create table students(std_id int,std_Name varchar(50),standard varchar(20),std_Section varchar(20),parent_number int);
drop table students;

create table customer(cust_id int,cust_Name varchar(50),cust_location varchar(20),customer_address varchar(30),customer_no int);
drop table customer;

create table product(product_id int,product_Name varchar(50),product_price varchar(20),product_quantity int,Available_stocks int);
drop table product;

-- 3. Insert at least 5 records into students.
insert into students values(1,'john', 'II','A',9876),(2,'sam','III','B',98765),(3,'Tom','IV','C',43210),(4,'Jerry','V','D',669),(4,'Steve','VII','E',9876543210);

-- 4. Run SELECT * FROM students; and view the data.
select * from students;

-- 5. Drop the schoolDB database (to practice database removal).
drop database schoolDB;








