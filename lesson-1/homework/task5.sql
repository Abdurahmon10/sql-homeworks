drop table if exists account;
create table account(
	account_id int constraint p_k_account primary key,
	balance decimal constraint positive check(balance>=0),
	account_type varchar(10) constraint s_c check (account_type='Saving' or account_type='Checking')
);

/*alter table account
drop constraint p_k_account;*/

alter table account
drop constraint positive;

alter table account
drop constraint s_c;

/*alter table account
add constraint p_k_account primary key(account_id);*/

alter table account
add constraint positive check(balance>=0);

alter table account
add constraint s_c check(account_type='Saving' or account_type='Checking');