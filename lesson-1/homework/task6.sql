drop table if exists customer;
create table customer(
    customer_id int constraint p_k_cutomer primary key,
    name varchar(50),
    city varchar(50) constraint def_city default 'Unknown'
);

alter table customer
drop constraint def_city;

alter table customer
add constraint def_city default 'Unknown' for city;
