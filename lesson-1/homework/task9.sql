drop table if exists book;

create table book(
	book_id int primary key identity(1,1),
	title varchar(100),
	author varchar(60),
	published_year int

);

drop table if exists member;

create table member(
	member_id int primary key identity(1,1),
	name varchar(60),
	email varchar(60),
	phone_number varchar(50)

);


drop table if exists loan;

create table loan(
	loan_id int primary key identity(1,1),
	member_id int foreign key references member(member_id),
	book_id int foreign key references book(book_id),
	loan_date date not null,
	return_date date default null

);




insert into book(title,author,published_year)
values('Lord of The Rings','J.R.R. Tolkien',1938);
insert into book(title,author,published_year)
values('Lord of The Rings','J.R.R. Tolkien',1938);



insert into book(title,author,published_year)
values('Hunger Games','Suzane Collins',2012);

insert into book(title,author,published_year)
values('Wuthering heights','Emily Bronte',1870);

select * from book;


insert into member(name,email,phone_number)
values('a','a@.com','1')


insert into member(name,email,phone_number)
values('b','b@.com','2')

insert into member(name,email,phone_number)
values('c','c@.com','3')

insert into member(name,email,phone_number)
values('d','d@.com','4')

select * from member;


insert into loan(book_id,member_id,loan_date)
values (1,1,'2025/3/15');


insert into loan(book_id,member_id,loan_date,return_date)
values (1,2,'2025/3/18','2025/4/1');


insert into loan(book_id,member_id,loan_date)
values (2,2,'2025/1/3');

select * from loan