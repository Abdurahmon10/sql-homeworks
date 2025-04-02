
DROP TABLE IF EXISTS [dbo].[EMPLOYEES_N];

CREATE TABLE [dbo].[EMPLOYEES_N]
(
    [EMPLOYEE_ID] [int] NOT NULL,
    [FIRST_NAME] [varchar](20) NULL,
    [HIRE_DATE] [date] NOT NULL
)
 
INSERT INTO [dbo].[EMPLOYEES_N]
VALUES
	(1001,'Pawan','1975-02-21'),
	(1002,'Ramesh','1976-02-21'),
	(1003,'Avtaar','1977-02-21'),
	(1004,'Marank','1979-02-21'),
	(1008,'Ganesh','1979-02-21'),
	(1007,'Prem','1980-02-21'),
	(1016,'Qaue','1975-02-21'),
	(1155,'Rahil','1975-02-21'),
	(1102,'Suresh','1975-02-21'),
	(1103,'Tisha','1975-02-21'),
	(1104,'Umesh','1972-02-21'),
	(1024,'Veeru','1975-02-21'),
	(1207,'Wahim','1974-02-21'),
	(1046,'Xhera','1980-02-21'),
	(1025,'Wasil','1975-02-21'),
	(1052,'Xerra','1982-02-21'),
	(1073,'Yash','1983-02-21'),
	(1084,'Zahar','1984-02-21'),
	(1094,'Queen','1985-02-21'),
	(1027,'Ernst','1980-02-21'),
	(1116,'Ashish','1990-02-21'),
	(1225,'Bushan','1997-02-21');


select *,year(Hire_date) as hire_year from [dbo].[EMPLOYEES_N];

with years as (
	select 1975 as yearr
	union all
	select yearr+1 
	from years
	where yearr<year(getdate())
	)
select cast(min(yearr) as varchar(10))+'-'+cast(max(yearr) as varchar(10)) as yearss from
(select *,sum(beginn) over(order by yearr) as groupings from
		(select case
				when yearr=min(yearr) over(order by yearr) or lag(yearr) over(order by yearr)<>yearr-1 then 1
				else 0
			end as beginn,
				case
				when yearr=max(yearr)over(order by yearr desc) or lead(yearr) over(order by yearr)<>yearr+1 then 1
				else 0
			end as endd, yearr from(
				select year_count,yearr from(
					select count(y.yearr) as year_count,y.yearr from years as y 
					inner join  [dbo].[EMPLOYEES_N] as n on y.yearr<>year(n.HIRE_DATE)
					group by y.yearr) my_table1
				where year_count=22) my_table2)mytable3) mytable4
group by groupings;

