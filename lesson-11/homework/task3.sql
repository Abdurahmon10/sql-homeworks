-- Drop the table if it already exists
DROP TABLE IF EXISTS EmployeeWorkLog;

-- Create the EmployeeWorkLog table
CREATE TABLE EmployeeWorkLog (
    EmployeeID INT,
    EmployeeName VARCHAR(50),
    Department VARCHAR(20),
    WorkDate DATE,
    HoursWorked INT
);

-- Insert data into EmployeeWorkLog
INSERT INTO EmployeeWorkLog (EmployeeID, EmployeeName, Department, WorkDate, HoursWorked)
VALUES
    (1, 'Alice', 'HR', '2024-03-01', 8),
    (2, 'Bob', 'IT', '2024-03-01', 9),
    (3, 'Charlie', 'Sales', '2024-03-02', 7),
    (1, 'Alice', 'HR', '2024-03-03', 6),
    (2, 'Bob', 'IT', '2024-03-03', 8),
    (3, 'Charlie', 'Sales', '2024-03-04', 9);


drop view if exists vw_MonthlyWorkSummary

create view vw_MonthlyWorkSummary as
select distinct EmployeeID,
	EmployeeName,
	Department,
	avg(HoursWorked) over(partition by department order by employeeid) as avg_dep,
	sum(HoursWorked) over(partition by department order by employeeid) as sum_dep,
	sum(HoursWorked) over(partition by employeeid order by employeeid) as TotalHoursWorked
from EmployeeWorkLog

select * from vw_MonthlyWorkSummary
