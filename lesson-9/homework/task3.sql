drop table if exists numbers
create table numbers(
	n int
);

insert into numbers
values (1),(2),(3),(4),(5),(6),(7),(8),(9),(10);


with fibonacci as(
	
	select 1 as n,1 as fib, 0 as prev_fib
	from numbers
	where n=1

	union all

	select 2 as n,1 as fib, 1 as prev_fib
	from numbers
	where n=2

	union all
	
	select f.n+1,
	f.fib+f.prev_fib as fib,
	f.fib as prev_fib
	from fibonacci as f
	where f.n<10

)
select distinct f.n,f.fib from fibonacci as f
option(maxrecursion 0)