drop table if exists student;
create table student
(
	id uniqueidentifier primary key,
	[name] varchar(50),
	tuition_per_class decimal(10,4),
	classes decimal(2,0),
	total_tuition as (tuition_per_class*classes) persisted
);

insert into student(id,[name],tuition_per_class,classes)
values
	(newid(),'a',50.00,6),
	(newid(),'b',67.90,8),
	(newid(),'a',105.98,3);

select * from student;