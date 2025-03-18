drop table if exists category;
create table category(
	category_id int constraint p_k_c primary key,
	category_name varchar(50)
);

drop table if exists item;
create table item(
	item_id int constraint p_k_i primary key,
	item_name varchar(50),
	category_id int constraint f_k_c foreign key references category(category_id)
);

alter table item
drop constraint f_k_c;

alter table item
add constraint f_k_c foreign key(category_id) references category(category_id);