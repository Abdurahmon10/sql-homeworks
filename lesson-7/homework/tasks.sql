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
INSERT INTO Customers VALUES 
(7, 'Grace'), 
(8, 'Henry'), 
(9, 'Isabella'), 
(10, 'Jack');


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



--task-1
select * from customers as c left join
orders as o on c.customerid=o.CustomerID;

--task-2

select * from customers as c left join
	orders as o on c.customerid =o.CustomerID
	where
	o.orderid is null;

--task-3
select o.OrderID, p.productname from orders as o inner join orderdetails as od
on o.OrderID=od.OrderID, products as p
where p.ProductID=od.ProductID;



--task-4
select * from(	select c.CustomerName as cname ,count(o.orderid) coid from customers as c inner join
	orders as o on c.customerid=o.CustomerID
	group by c.CustomerName) as mytable
	
where coid>1;


--task-5
select * from(
	select o.OrderID as oid, p.productname as pname, ROW_NUMBER() over(partition by o.orderid order by od.price) as price from orders as o inner join orderdetails as od
	on o.OrderID=od.OrderID, products as p
	where p.ProductID=od.ProductID) as mytable
	where price=1;


--task-6

select * from(
	select c.CustomerName, 
    o.OrderID, 
    o.OrderDate, 
    p.ProductName, 
    od.Quantity, 
    od.Price,row_number() over(partition by c.customername order by o.orderdate desc) as date_rank from orders as o 
	inner join orderdetails as od on o.OrderID=od.OrderID
	inner join products as p on p.ProductID=od.ProductID
	inner join customers as c on c.CustomerID=o.CustomerID
	) as mytable
	where date_rank=1;

--task-7

select cname,category from(
select cname,string_agg(category,',') as category from(
	select distinct p.category as category, 
    --o.OrderID, 
    --o.OrderDate, 
    --p.ProductName, 
	c.CustomerName as cname
    --od.Quantity, 
    --od.Price 
	from orders as o 
	inner join orderdetails as od on o.OrderID=od.OrderID
	inner join products as p on p.ProductID=od.ProductID
	inner join customers as c on c.CustomerID=o.CustomerID
	) as mytable
	group by 
	cname) as mytable2
	where category='electronics'
	;


--task-8
select cname,category from(
select cname,string_agg(category,',') as category from(
	select distinct p.category as category, 
    --o.OrderID, 
    --o.OrderDate, 
    --p.ProductName, 
	c.CustomerName as cname
    --od.Quantity, 
    --od.Price 
	from orders as o 
	inner join orderdetails as od on o.OrderID=od.OrderID
	inner join products as p on p.ProductID=od.ProductID
	inner join customers as c on c.CustomerID=o.CustomerID
	) as mytable
	group by 
	cname) as mytable2
where category LIKE '%Stationery%';


--task-9

select c.customername, sum(od.price*od.quantity)  as total_spent from orders as o 
	inner join orderdetails as od on o.OrderID=od.OrderID
	inner join customers as c on c.CustomerID=o.CustomerID
group by c.CustomerName;