use schooldb;

-- 6. Create Customer and Orders table

-- Customer Table :CustomerID(pk),CustomerName,Phone

-- Orders Table :OrderID(pk),CustomerID(fk),OrderDate,Amount,OrderStatus

-- Add CustomerID as a Foreign Key in Orders,Add a CHECK constraint to ensure Amount > 0.

-- Set the default OrderStatus as 'Pending'.

create table customer( CustomerID int primary key, CustomerName varchar(20), phone Int);

create table orders(OrderID int primary key,CustomerID int,OrderDate varchar(15),Amount int ,Orderstatus varchar(20) default 'pending', 
FOREIGN KEY (CustomerID) REFERENCES customer(CustomerID));

drop table orders;
drop table customer;

-- 7. Hospital and Doctor

-- Doctor Table : DoctorID(pk),DoctorName,Specialization

-- Patient Table:PatientID(pk),PatientName,Age,DoctorID(fk),Status

-- Add DoctorID as a Foreign Key in Patient.Add a CHECK constraint to ensure Age > 0.

-- Set the default Status as 'Active'.

create table Doctor ( DoctorID int primary key, DoctorName varchar(30),Specialization varchar(50) );

create table Patient ( patientID int primary key, PatientName varchar(50), Age int, DoctorID int, status varchar(30) default 'Active' ,
foreign key (DoctorID) references Doctor(DoctorID),
check (Age > 0) );

insert into Doctor values(1,'Arun','Orthologist');
insert into Doctor values(2,'Varun','Orthologist');

insert into Patient values( 11,'Arumugam',52,1,default);
insert into Patient values( 12,'Mayilvaaganam',0,1,default);
insert into Patient values( 12,'Mayilvaaganam',40,1,default);
insert into Patient values( 13,'lingam',50,11,default);
insert into Patient values( 14,'Parvathy',35,4,default);

select * from Doctor;
select * from Patient;

-- 8. Bank and Account

-- Customer Table:CustomerID,CustomerName,Phone

-- Account Table :AccountID,CustomerID,AccountType,Balance,AccountStatus

-- Add CustomerID as a Foreign Key in Account.& Add a CHECK constraint to ensure Balance >= 0.

-- Set the default AccountStatus as 'Active'.

create table customer (Customerid int primary key,customername varchar(40),phone int);

create table accounts (accountid int,customerid int,accountype varchar(30),Balance int, accountstatus varchar(30) default "Active");  

ALTER TABLE accounts ADD CONSTRAINT fk_acc foreign key (customerid) REFERENCES customer(customerid) ;

-- 9. Library and Books

-- Publisher Table:PublisherID,PublisherName,City

-- Book Table: BookID,BookName,PublisherID,Price,AvailableCopies

-- Add PublisherID as a Foreign Key in Book & Add a CHECK constraint to ensure Price > 0.

-- Set the default AvailableCopies to 1.

create table Library(PublisherID int primary key, PublisherName varchar(20),city varchar(10));
create table Books(BookId int primary key, publisherID int,BookName varchar(20),price int,availableCopies int Default 1, foreign key(PublisherID) references Library(publisherID), check(price>0));

-- 10. Teacher and Subject

-- Teacher Table:TeacherID,TeacherName,Experience

-- Subject Table:SubjectID,SubjectName,TeacherID,SubjectStatus

-- Add TeacherID as a Foreign Key in Subject & Add a CHECK constraint to ensure Experience >= 0.

-- Set the default SubjectStatus as 'Available'.

create table Teacher(TeacherID int primary key,TeacherName varchar(70),Experience int,check (Experience >=0));
create table Subjects(SubjectID int primary key, SubjectName varchar(80), TeacherID int, SubjectStatus varchar(20) default 'available', foreign key(TeacherID) references Teacher(TeacherID));