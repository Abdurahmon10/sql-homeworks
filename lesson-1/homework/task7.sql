drop table if exists invoice;
create table invoice(
    invoice_id int identity(1,1),
    amount decimal(10,5)
);

insert into invoice(amount)
values (100.09);

insert into invoice(amount)
values(0.50);

insert into invoice(amount)
values (70.45045);

insert into invoice(amount)
values (90.5050);

insert into invoice(amount)
values(30.6);

select * from invoice;

--SET IDENTITY_INSERT master.dbo.person OFF

set identity_insert invoice on;

insert into invoice(invoice_id,amount)
values(100,40.777);

set identity_insert invoice off;
select * from invoice;