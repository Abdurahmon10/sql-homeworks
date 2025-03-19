drop table if exists data_types_demo

create table data_types_demo(
	id uniqueidentifier primary key,
	[name] char(50),
	age int,
	height decimal(6,3),
	[description] text,
	dob date,
	entered datetime
);

insert into data_types_demo
select newid(),'d',10,140.50,'plump, nerdy','2015-12-19',GETDATE();


insert into data_types_demo
select newid(),'a',17,187.50,'muscular, hairy','2007-04-24',GETDATE();


insert into data_types_demo
select newid(),'r',6,135.68,'slim, reckless','2018-9-9',GETDATE();


insert into data_types_demo
select newid(),'k',72,157.34,'energetic, resilient','1952-1-1',GETDATE();


insert into data_types_demo
select newid(),'n',30,170.50,'beautiful, capable','1994-03-01',GETDATE();

select * from data_types_demo