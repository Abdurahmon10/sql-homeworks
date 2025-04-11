DROP TABLE IF EXISTS employees;

CREATE TABLE employees (
	employeeid INT IDENTITY(1,1) PRIMARY KEY,
	name VARCHAR(50),
	department VARCHAR(10),
	salary INT
);

INSERT INTO employees (name, department, salary)
VALUES
	('Alice',   'HR',    5000),
	('Bob',     'IT',    7000),
	('Charlie', 'Sales', 6000),
	('David',   'HR',    5500),
	('Emma',    'IT',    7200);



CREATE TABLE #EmployeeTransfers (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(100),
    Department VARCHAR(50),
	Salary int
);

select * from employees

insert into #EmployeeTransfers
select employeeid,name,
case 
	when department='HR' then 'IT'
	when department='IT' then 'Sales'
	else 'HR'
end as department, salary from employees

select * from #EmployeeTransfers
