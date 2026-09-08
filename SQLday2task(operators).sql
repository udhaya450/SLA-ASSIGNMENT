
create database schooldb;
use schooldb;

-- 1. Create a table orders (id, product_name, quantity, price).
create table orders(id int,product_name varchar(50),quantity varchar(20),price int);

-- 2. Insert 5 orders with different values.
insert into orders values(1, 'SmartTV',1,50000),(2,'Book',4,400),(3,'Bike',2,600000),(4,'Watch',5,10000),(5,'Apples',20,800),(6,'Bag',3,3500);

-- 3. Select all orders where quantity > 2.
select * from orders where quantity > 2;

-- 4. Select orders where price is between 100 and 500.
select * from orders where price between 100 and 500 ;

-- 5. Fetch orders with product_name starting with 'A;
select * from orders where product_name like 'A%';












