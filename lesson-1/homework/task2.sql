drop table if exists product;
create table product(
	product_id int constraint unique_id unique,
	product_name varchar,
	price decimal

);




alter table product
drop constraint unique_id;

alter table product
add constraint unique_id unique (product_id);



alter table product
drop constraint unique_id;

alter table product
add constraint unique_id_name unique(product_id,product_name);