drop table if exists Employees

CREATE TABLE Employees
(
	EmployeeID  INTEGER PRIMARY KEY,
	ManagerID   INTEGER NULL,
	JobTitle    VARCHAR(100) NOT NULL
);
INSERT INTO Employees (EmployeeID, ManagerID, JobTitle) 
VALUES
	(1001, NULL, 'President'),
	(2002, 1001, 'Director'),
	(3003, 1001, 'Office Manager'),
	(4004, 2002, 'Engineer'),
	(5005, 2002, 'Engineer'),
	(6006, 2002, 'Engineer');


with m_level as (
	
	select employeeid,managerid,jobtitle,0 as manager_level
	from Employees as e
	where JobTitle='President'

	union all

	select employees.employeeid,employees.managerid,Employees.JobTitle, m_level.manager_level+1 as manager_level from employees
	inner join m_level on m_level.employeeid=employees.managerid
)
select * from m_level;




	
