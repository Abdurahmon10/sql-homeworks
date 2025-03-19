drop table if exists photos;
create table photos(
	id int primary key identity(1,1),
	photo varbinary(max)
);

insert into photos
select * from openrowset( bulk 'C:\Users\user\sql-homeworks\lesson-2\homework\task3', single_blob) as img;
