drop table if exists employees;
drop table if exists departments;
drop table if exists projects;

-- Create Employees table
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    DepartmentID INT,       -- Can be NULL if not assigned
    Salary INT NOT NULL
);

-- Create Departments table
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50) NOT NULL
);

-- Create Projects table
CREATE TABLE Projects (
    ProjectID INT PRIMARY KEY,
    ProjectName VARCHAR(50) NOT NULL,
    EmployeeID INT         -- Can be NULL if not assigned to an employee
);

-- Insert data into Employees
INSERT INTO Employees (EmployeeID, Name, DepartmentID, Salary) VALUES
(1, 'Alice', 101, 60000),
(2, 'Bob', 102, 70000),
(3, 'Charlie', 101, 65000),
(4, 'David', 103, 72000),
(5, 'Eva', NULL, 68000);

-- Insert data into Departments
INSERT INTO Departments (DepartmentID, DepartmentName) VALUES
(101, 'IT'),
(102, 'HR'),
(103, 'Finance'),
(104, 'Marketing');

-- Insert data into Projects
INSERT INTO Projects (ProjectID, ProjectName, EmployeeID) VALUES
(1, 'Alpha', 1),
(2, 'Beta', 2),
(3, 'Gamma', 1),
(4, 'Delta', 4),
(5, 'Omega', NULL);


--task1

select e.name, e.departmentid, d.departmentname from employees as e
inner join departments as d
on e.departmentid=d.departmentid;

--task2
select e.name, e.departmentid, d.departmentname from employees as e
left outer join departments as d
on e.departmentid=d.departmentid;

--task3
select e.name, e.departmentid, d.departmentname from employees as e
right outer join departments as d
on e.departmentid=d.departmentid;


--task4
select e.name, e.departmentid, d.departmentname from employees as e
full outer join departments as d
on e.departmentid=d.departmentid;


--task5
select sum(e.salary), d.departmentname from employees as e
inner join departments as d
on e.departmentid=d.departmentid
group by d.DepartmentName;


--task6
select p.*,d.* from projects as p
cross join departments as d
--on e.departmentid=d.departmentid;

---task7

select e.name,d.departmentname,p.projectname 
from
departments as d,
employees as e left outer join projects as p 
on p.employeeid=e.employeeid
where d.departmentid=e.departmentid;