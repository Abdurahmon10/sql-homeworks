drop table if exists worker;
create table worker
(
	id int,
	name varchar(50)
);

bulk insert worker
from 'C:\Users\user\sql-homeworks\lesson-2\homework\task5\sample.csv'
WITH (
	firstrow=2,
	fieldterminator=',',
	rowterminator='\n'
);

select * from worker;

SELECT SERVERPROPERTY('MachineName') AS MachineName, 
       SERVERPROPERTY('InstanceName') AS InstanceName,
       SERVERPROPERTY('IsClustered') AS IsClustered;