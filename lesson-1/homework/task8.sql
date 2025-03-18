drop table if exists books;

create table books(
	book_id int primary key identity(1,1),
	title varchar(100) check(len(title)>0),
	price decimal(20,10) check(price>0),
	genre varchar(500) default 'Unknown'

);

insert into books(title,price,genre)
values('Lord of The Rings',100.0,'Fantasy');


insert into books(title,price,genre)
values('Hunger Games',75.0,'Dystopian');


--insert into books(title,price,genre)
--values('Winds of winter',0,'Fantasy');

-- did not work because of check



insert into books(title,price)
values('Dunyoning ishlari',85.9);


insert into books(title,price,genre)
values('Wuthering heights',90.0,'Romance');

select * from books;