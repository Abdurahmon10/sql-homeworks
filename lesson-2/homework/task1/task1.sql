drop table if exists test_identity;
create table test_identity(
	id int primary key identity(1,1),
	name varchar(10)
);

insert into test_identity
select 'del1';

insert into test_identity
select 'del2';

insert into test_identity
select 'del3';
insert into test_identity
select 'del4';
insert into test_identity
select 'del5';

select * from test_identity;

delete test_identity;

select * from test_identity;

insert into test_identity
select 'adel1';

insert into test_identity
select 'adel2';

insert into test_identity
select 'adel3';
insert into test_identity
select 'adel4';
insert into test_identity
select 'adel5';

select * from test_identity

--delete over. it continued with the last id that was left.

drop table if exists test_identity;
create table test_identity(
	id int primary key identity(1,1),
	name varchar(10)
);

insert into test_identity
select 'del1';

insert into test_identity
select 'del2';

insert into test_identity
select 'del3';
insert into test_identity
select 'del4';
insert into test_identity
select 'del5';

select * from test_identity;

truncate table test_identity;

select * from test_identity;

insert into test_identity
select 'adel1';

insert into test_identity
select 'adel2';

insert into test_identity
select 'adel3';
insert into test_identity
select 'adel4';
insert into test_identity
select 'adel5';

select * from test_identity

--truncate over. it started the identity over from one.

drop table test_identity

--table dropped.

