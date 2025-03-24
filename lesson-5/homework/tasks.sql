--ddl

drop table if exists Employees;
CREATE TABLE Employees (
    EmployeeID INT IDENTITY(1,1) PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Department VARCHAR(50) NOT NULL,
    Salary DECIMAL(10,2) NOT NULL,
    HireDate DATE NOT NULL
);

INSERT INTO Employees (Name, Department, Salary, HireDate) VALUES
    ('Alice', 'HR', 50000, '2020-06-15'),
    ('Bob', 'HR', 60000, '2018-09-10'),
    ('Charlie', 'IT', 70000, '2019-03-05'),
    ('David', 'IT', 80000, '2021-07-22'),
    ('Eve', 'Finance', 90000, '2017-11-30'),
    ('Frank', 'Finance', 75000, '2019-12-25'),
    ('Grace', 'Marketing', 65000, '2016-05-14'),
    ('Hank', 'Marketing', 70000, '2019-10-08'),
    ('Ivy', 'IT', 67000, '2022-01-12'),
    ('Jack', 'HR', 50000, '2021-03-29');



--task1

select *,rank() over(order by salary desc) from employees as salary_rank;



--task2

select  name_agg from(
	select
	count(name) as salary_count,
	string_agg(name,'<->') as name_agg
		from(
			select DENSE_RANK() over(order by salary desc) as salary_rank,name 
			from employees
			) as my_table2
		group by salary_rank
) as my_table
where salary_count>1;


--task3

select * from (
	select 
		*,
		row_number() over(partition by department order by salary desc) as rnk
	from Employees
) mytable
where rnk = 2 or rnk=1
order by department, rnk;


--task4
select * from(
select *,row_number() over(partition by department order by salary) as rnk from employees
) as mytable
where rnk=1
order by department;


--task5
select sum(salary), department from employees
group by department;

--task6
select distinct department, salary_1 from  (select sum(salary) over(partition by department) as salary_1, department from employees) as mytable;


--task7
select distinct department, salary_1 from  (select avg(salary) over(partition by department) as salary_1, department from employees) as mytable;



--task8
select  department, salary_1-salary as diff_salary from  (select avg(salary) over(partition by department) as salary_1,salary, department from employees) as mytable;


--task9
select * from(
	select avg(salary) over( order by employeeid rows between 1 preceding and 1 following) as avg_moving from employees) as mytable


--task10
select sum(salary) from 
	(select * from(
		select 1 as common,salary , row_number() over(order by hiredate desc) as hire_order from employees) mytable
		where hire_order<=3
		) as mytable2
group by common;



--task11
select * from(
	select avg(salary) over( order by employeeid rows between unbounded preceding and current row) as avg_moving from employees) as mytable

--task12
select * from(
	select max(salary) over( order by employeeid rows between 2 preceding and 2 following) as avg_moving from employees) as mytable

--task13
select name, salary ,salary/total_dep_salary*100, department, total_dep_salary from(
	select sum(salary) over(partition by department) as total_dep_salary,* from employees) as mytable;