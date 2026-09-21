use schemaa;

create table Customers (CustomerID INT PRIMARY KEY,FirstName VARCHAR(50),LastName VARCHAR(50),Email VARCHAR(100),Phone VARCHAR(15),Address VARCHAR(200),
    City VARCHAR(50),RegisteredDate DATE);
    
insert into Customers values
(1, 'Udhaya', 'U', 'udhaya@gmail.com', '9876543210', 'Main Road', 'Chennai', '2026-01-10'),
(2, 'Arun', 'Kumar', 'arun@gmail.com', '9876543211', 'Anna Nagar', 'Madurai', '2026-02-15'),
(3, 'Priya', 'Devi', 'devi@gmail.com', '9876543212', 'Gandhi Road', 'Chennai', '2026-03-20'),
(4, 'Kumar', 'Raj', 'kumar@gmail.com', '9876543213', 'Market Road', 'Coimbatore', '2026-04-05');

-- 1: Create a stored procedure to add a new customer.

DELIMITER //

CREATE PROCEDURE AddCustomer(
    IN p_CustomerID INT,
    IN p_FirstName VARCHAR(50),
    IN p_LastName VARCHAR(50),
    IN p_Email VARCHAR(100),
    IN p_Phone VARCHAR(15),
    IN p_Address VARCHAR(200),
    IN p_City VARCHAR(50),
    IN p_RegisteredDate DATE
)
BEGIN
    INSERT INTO Customer VALUES (
        p_CustomerID,
        p_FirstName,
        p_LastName,
        p_Email,
        p_Phone,
        p_Address,
        p_City,
        p_RegisteredDate
    );
END //

DELIMITER ;

CALL AddCustomer(
    5,
    'Ravi',
    'Kumar',
    'ravi@gmail.com',
    '9876543214',
    'Temple Road',
    'Chennai',
    '2026-09-21'
);

-- 2. Retrieve customer details by CustomerID

DELIMITER //

CREATE PROCEDURE GetCustomerByID(
    IN p_CustomerID INT
)
BEGIN
    SELECT *
    FROM Customers
    WHERE CustomerID = p_CustomerID;
END //

DELIMITER ;
CALL GetCustomerByID(1);

-- 3. Update customer's email and phone num

DELIMITER //

CREATE PROCEDURE UpdateCustomerContact(
    IN p_CustomerID INT,
    IN p_Email VARCHAR(100),
    IN p_Phone VARCHAR(15)
)
BEGIN
    UPDATE Customers
    SET Email = p_Email,
        Phone = p_Phone
    WHERE CustomerID = p_CustomerID;
END //

DELIMITER ;

CALL UpdateCustomerContact(
    1,
    'newemail@gmail.com',
    '9999999999'
);

-- 4. Get all customers from a specific city

DELIMITER //

CREATE PROCEDURE GetCustomersByCity(
    IN p_City VARCHAR(50)
)
BEGIN
    SELECT *
    FROM Customers
    WHERE City = p_City;
END //

DELIMITER ;

CALL GetCustomersByCity('Chennai');

-- 5. Delete a customer by CustomerID

DELIMITER //

CREATE PROCEDURE DeleteCustomer(
    IN p_CustomerID INT
)
BEGIN
    DELETE FROM Customers
    WHERE CustomerID = p_CustomerID;
END //

DELIMITER ;

CALL DeleteCustomer(5);

-- 6. Customers registered within a given date range

DELIMITER //

CREATE PROCEDURE GetCustomersByDateRange(
    IN p_StartDate DATE,
    IN p_EndDate DATE
)
BEGIN
    SELECT *
    FROM Customers
    WHERE RegisteredDate BETWEEN p_StartDate AND p_EndDate;
END //

DELIMITER ;

CALL GetCustomersByDateRange(
    '2026-01-01',
    '2026-03-31'
);

-- 7. Search customers by partial FirstName or LastName

DELIMITER //

CREATE PROCEDURE SearchCustomer(
    IN p_Name VARCHAR(50)
)
BEGIN
    SELECT *
    FROM Customers
    WHERE FirstName LIKE CONCAT('%', p_Name, '%')
       OR LastName LIKE CONCAT('%', p_Name, '%');
END //

DELIMITER ;

CALL SearchCustomer('Kum');

-- 8. Update customer's entire address

DELIMITER //

CREATE PROCEDURE UpdateCustomerAddress(
    IN p_CustomerID INT,
    IN p_Address VARCHAR(200),
    IN p_City VARCHAR(50)
)
BEGIN
    UPDATE Customers
    SET Address = p_Address,
        City = p_City
    WHERE CustomerID = p_CustomerID;
END //

DELIMITER ;

CALL UpdateCustomerAddress(
    1,
    'New Street',
    'Madurai'
);
-- 9. Return total number of customers

DELIMITER //

CREATE PROCEDURE GetTotalCustomers()
BEGIN
    SELECT COUNT(*) AS TotalCustomers
    FROM Customers;
END //

DELIMITER ;

CALL GetTotalCustomers();

-- 10. Customers who have not provided an email address

DELIMITER //

CREATE PROCEDURE GetCustomersWithoutEmail()
BEGIN
    SELECT *
    FROM Customers
    WHERE Email IS NULL;
END //

DELIMITER ;

CALL GetCustomersWithoutEmail();


