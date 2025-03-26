drop table if exists customers;
drop table if exists orders;
drop table if exists orderdetails;
drop table if exists products;
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT foreign key references customers(customerid),
    OrderDate DATE
);

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50)
);

CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT FOREIGN KEY REFERENCES Orders(OrderID),
    ProductID INT foreign key references products(productid),
    Quantity INT,
    Price DECIMAL(10,2)
);


select * from customers;
select * from Orders;
select * from OrderDetails;
select * from Products;

INSERT INTO Customers VALUES 
(1, 'Alice'), (2, 'Bob'), (3, 'Charlie');

INSERT INTO Orders VALUES 
(101, 1, '2024-01-01'), (102, 1, '2024-02-15'),
(103, 2, '2024-03-10'), (104, 2, '2024-04-20');

INSERT INTO OrderDetails VALUES 
(1, 101, 1, 2, 10.00), (2, 101, 2, 1, 20.00),
(3, 102, 1, 3, 10.00), (4, 103, 3, 5, 15.00),
(5, 104, 1, 1, 10.00), (6, 104, 2, 2, 20.00);

INSERT INTO Products VALUES 
(1, 'Laptop', 'Electronics'), 
(2, 'Mouse', 'Electronics'),
(3, 'Book', 'Stationery');

INSERT INTO Customers VALUES 
(4, 'David'), 
(5, 'Emma'), 
(6, 'Frank');


INSERT INTO Orders VALUES 
(105, 3, '2024-05-05'), 
(106, 4, '2024-06-10'), 
(107, 5, '2024-07-15'), 
(108, 6, '2024-08-20');

INSERT INTO OrderDetails VALUES 
(7, 105, 4, 1, 50.00), 
(8, 105, 6, 3, 5.00), 
(9, 106, 5, 2, 80.00), 
(10, 107, 7, 1, 500.00), 
(11, 108, 8, 2, 100.00), 
(12, 108, 9, 3, 15.00);


INSERT INTO Products VALUES 
(4, 'Keyboard', 'Electronics'), 
(5, 'Desk Chair', 'Furniture'), 
(6, 'Notebook', 'Stationery'), 
(7, 'Smartphone', 'Electronics'), 
(8, 'Headphones', 'Electronics'), 
(9, 'Water Bottle', 'Accessories'), 
(10, 'Backpack', 'Accessories');
