drop table if exists student;
create table student(
	id int,
	name varchar(50),
	age int
);

alter table student
add constraint NN_student_id check(id is not null);