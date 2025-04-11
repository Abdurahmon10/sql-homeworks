-- Drop the tables if they already exist
DROP TABLE IF EXISTS Orders_DB1;
DROP TABLE IF EXISTS Orders_DB2;

-- Create Table 1: Orders_DB1 (Main System)
CREATE TABLE Orders_DB1 (
	OrderID INT PRIMARY KEY,
	CustomerName VARCHAR(50),
	Product VARCHAR(50),
	Quantity INT
);

-- Insert data into Orders_DB1
INSERT INTO Orders_DB1 (OrderID, CustomerName, Product, Quantity)
VALUES
	(101, 'Alice', 'Laptop', 1),
	(102, 'Bob', 'Phone', 2),
	(103, 'Charlie', 'Tablet', 1),
	(104, 'David', 'Monitor', 1);

-- Create Table 2: Orders_DB2 (Backup System)
CREATE TABLE Orders_DB2 (
	OrderID INT PRIMARY KEY,
	CustomerName VARCHAR(50),
	Product VARCHAR(50),
	Quantity INT
);

-- Insert data into Orders_DB2
INSERT INTO Orders_DB2 (OrderID, CustomerName, Product, Quantity)
VALUES
	(101, 'Alice', 'Laptop', 1),
	(103, 'Charlie', 'Tablet', 1);

declare @missingordesr table(
	OrderID INT PRIMARY KEY,
	CustomerName VARCHAR(50),
	Product VARCHAR(50),
	Quantity INT
)

insert into @missingordesr
select distinct db1.OrderID,db1.CustomerName, db1.Product, db1.Quantity from Orders_DB1 as db1
left join Orders_DB2 as db2 on db1.OrderID=db2.OrderID
where db2.OrderID is null

select * from @missingordesr

