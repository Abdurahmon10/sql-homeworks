drop table if exists orders;
create table orders(
	order_id int constraint p_k primary key,
	curtomer_name varchar(50),
	order_date date
);

alter table orders
drop constraint p_k;

alter table orders
add constraint p_k primary key(order_id);