drop table if exists numbers
create table numbers(
	n int
);

insert into numbers
values (1),(2),(3),(4),(5),(6),(7),(8),(9),(10);

with factorials as(
	select n,1 as factorial from numbers
	where n=1

	union all

	select numbers.n+1 as n,
	(numbers.n+1)*factorial as factorial
	from numbers inner join factorials on factorials.n=numbers.n
)

select * from factorials
--option(maxrecursion 1);