-- 1. Create and select the database
CREATE DATABASE bank_fraud_db;
GO

USE bank_fraud_db;
GO

-- 2. Create tables

CREATE TABLE users (
    user_id INT PRIMARY KEY,
    name NVARCHAR(100),
    email NVARCHAR(100),
    country NVARCHAR(50)
);

CREATE TABLE accounts (
    account_id INT PRIMARY KEY,
    user_id INT,
    account_type NVARCHAR(50),
    balance DECIMAL(12,2),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE transactions (
    transaction_id INT PRIMARY KEY,
    account_id INT,
    transaction_type NVARCHAR(20),
    amount DECIMAL(10,2),
    transaction_time DATETIME,
	country NVARCHAR(50),
    FOREIGN KEY (account_id) REFERENCES accounts(account_id)
);

CREATE TABLE fraud_flags (
    flag_id INT PRIMARY KEY IDENTITY,
    transaction_id INT,
    flag_reason NVARCHAR(255),
    flag_date DATETIME,
    resolved BIT DEFAULT 0,
    FOREIGN KEY (transaction_id) REFERENCES transactions(transaction_id)
);

CREATE TABLE user_logins (
    login_id INT PRIMARY KEY,
    user_id INT,
    login_time DATETIME,
    ip_address VARCHAR(45),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE user_ip_log (
    log_id INT PRIMARY KEY IDENTITY,
    user_id INT,
    old_ip VARCHAR(45),
    new_ip VARCHAR(45),
    change_time DATETIME,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- 3. Insert data

-- Users
INSERT INTO users (user_id, name, email, country) VALUES
(1,'Alice','alice@example.com','USA'),
(2,'Bob','bob@example.com','UK'),
(3,'Charlie','charlie@example.com','Canada'),
(4,'David','david@example.com','USA'),
(5,'Eve','eve@example.com','Germany'),
(6,'Frank','frank@example.com','USA'),
(7,'Grace','grace@example.com','UK'),
(8,'Heidi','heidi@example.com','India'),
(9,'Ivan','ivan@example.com','Russia'),
(10,'Judy','judy@example.com','France'),
(11,'Ken','ken@example.com','Germany'),
(12,'Leo','leo@example.com','Italy'),
(13,'Mia','mia@example.com','Spain'),
(14,'Nina','nina@example.com','India'),
(15,'Oscar','oscar@example.com','UK'),
(16,'Peggy','peggy@example.com','Canada'),
(17,'Quentin','quentin@example.com','France'),
(18,'Rita','rita@example.com','Brazil'),
(19,'Steve','steve@example.com','USA'),
(20,'Trent','trent@example.com','Japan');

-- Accounts
INSERT INTO accounts (account_id, user_id, account_type, balance) VALUES
(1,1,'savings',10000),
(2,2,'checking',5000),
(3,3,'savings',12000),
(4,4,'checking',7000),
(5,5,'savings',15000),
(6,6,'checking',4500),
(7,7,'savings',8000),
(8,8,'checking',6000),
(9,9,'savings',5000),
(10,10,'checking',3000),
(11,11,'savings',14000),
(12,12,'checking',2000),
(13,13,'savings',16000),
(14,14,'checking',4000),
(15,15,'savings',11000),
(16,16,'checking',7500),
(17,17,'savings',9500),
(18,18,'checking',6700),
(19,19,'savings',10300),
(20,20,'checking',5800);

-- Transactions

INSERT INTO transactions (transaction_id, account_id, transaction_type, amount, transaction_time,country) VALUES
(1,1,'withdrawal',1000,'2025-05-05 09:00','USA'),
(2,1,'deposit',2000,'2025-05-05 10:00','USA'),
(3,2,'withdrawal',6000,'2025-05-05 11:00','USA'),
(4,2,'withdrawal',7000,'2025-05-05 11:30','USA'),
(5,2,'withdrawal',8000,'2025-05-05 12:00','USA'),
(6,3,'deposit',5000,'2025-05-04 13:00','USA'),
(7,4,'withdrawal',200,'2025-05-04 14:00','USA'),
(8,5,'withdrawal',300,'2025-05-04 15:00','USA'),
(9,6,'deposit',1000,'2025-05-03 16:00','USA'),
(10,7,'withdrawal',100,'2025-05-03 17:00','USA'),
(11,8,'deposit',1500,'2025-05-02 18:00','USA'),
(12,9,'withdrawal',2500,'2025-05-02 19:00','USA'),
(13,10,'deposit',3000,'2025-05-01 20:00','USA'),
(14,11,'withdrawal',6000,'2025-05-01 21:00','USA'),
(15,12,'withdrawal',5500,'2025-05-01 22:00','USA'),
(16,13,'withdrawal',5200,'2025-05-01 23:00','USA'),
(17,14,'deposit',2500,'2025-05-01 08:00','USA'),
(18,15,'withdrawal',500,'2025-04-30 10:00','USA'),
(19,16,'deposit',1500,'2025-04-30 11:00','USA'),
(20,17,'withdrawal',8000,'2025-04-30 12:00','USA');

-- Fraud Flags
INSERT INTO fraud_flags (transaction_id, flag_reason, flag_date, resolved) VALUES
(3,'3 large withdrawals in a row','2025-05-05',0),
(4,'3 large withdrawals in a row','2025-05-05',0),
(5,'3 large withdrawals in a row','2025-05-05',0),
(14,'Suspicious high withdrawal','2025-05-01',1),
(15,'Suspicious high withdrawal','2025-05-01',0),
(16,'Suspicious high withdrawal','2025-05-01',0),
(20,'International card transfer','2025-04-30',0);

-- User Logins
INSERT INTO user_logins (login_id, user_id, login_time, ip_address) VALUES
(1,1,'2025-05-06 08:00','192.168.1.1'),
(2,1,'2025-05-06 08:01','192.168.1.1'),
(3,2,'2025-05-06 09:00','192.168.1.2'),
(4,2,'2025-05-06 09:00','192.168.1.3'),
(5,3,'2025-05-06 10:00','10.0.0.1'),
(6,4,'2025-05-05 11:00','10.0.0.2'),
(7,5,'2025-05-05 12:00','172.16.0.1'),
(8,6,'2025-05-04 13:00','172.16.0.2'),
(9,7,'2025-05-04 14:00','192.168.2.1'),
(10,8,'2025-05-04 15:00','192.168.2.2'),
(11,9,'2025-05-03 16:00','192.168.3.1'),
(12,10,'2025-05-03 17:00','192.168.3.2'),
(13,11,'2025-05-03 18:00','192.168.4.1'),
(14,12,'2025-05-03 19:00','192.168.4.2'),
(15,13,'2025-05-03 20:00','192.168.5.1'),
(16,14,'2025-05-02 21:00','192.168.5.2'),
(17,15,'2025-05-02 22:00','192.168.6.1'),
(18,16,'2025-05-01 23:00','192.168.6.2'),
(19,17,'2025-05-01 08:00','192.168.7.1'),
(20,18,'2025-05-01 09:00','192.168.7.2');

-- IP Log
INSERT INTO user_ip_log (user_id, old_ip, new_ip, change_time) VALUES
(1,'192.168.1.1','10.10.1.1','2025-05-06 08:05'),
(2,'192.168.1.2','10.10.1.2','2025-05-06 09:05'),
(3,'10.0.0.1','10.10.2.1','2025-05-06 10:05'),
(4,'10.0.0.2','10.10.2.2','2025-05-05 11:05'),
(5,'172.16.0.1','10.10.3.1','2025-05-05 12:05'),
(6,'172.16.0.2','10.10.3.2','2025-05-04 13:05'),
(7,'192.168.2.1','10.10.4.1','2025-05-04 14:05'),
(8,'192.168.2.2','10.10.4.2','2025-05-04 15:05'),
(9,'192.168.3.1','10.10.5.1','2025-05-03 16:05'),
(10,'192.168.3.2','10.10.5.2','2025-05-03 17:05'),
(11,'192.168.4.1','10.10.6.1','2025-05-03 18:05'),
(12,'192.168.4.2','10.10.6.2','2025-05-03 19:05'),
(13,'192.168.5.1','10.10.7.1','2025-05-03 20:05'),
(14,'192.168.5.2','10.10.7.2','2025-05-02 21:05'),
(15,'192.168.6.1','10.10.8.1','2025-05-02 22:05'),
(16,'192.168.6.2','10.10.8.2','2025-05-01 23:05'),
(17,'192.168.7.1','10.10.9.1','2025-05-01 08:05'),
(18,'192.168.7.2','10.10.9.2','2025-05-01 09:05'),
(19,'10.0.0.5','10.0.0.8','2025-05-01 10:05'),
(20,'10.0.0.6','10.0.0.9','2025-05-01 11:05');



--1
with transaction_days as (
select transaction_id, account_id, datefromparts(year(transaction_time),month(transaction_time),day(transaction_time)) as t_date
from transactions as t
),
u_d_f as(
select u.user_id, count(t.transaction_id) over(partition by t.t_date order by t.t_date) as t_count from transaction_days as t
inner join accounts as a on a.account_id=t.account_id
inner join users as u on u.user_id=a.user_id
)
select * from u_d_f
where t_count>=5;

--2
truncate table fraud_flags;

with withdrawals as (
  select u.user_id, t.*,
    row_number() over (partition by u.user_id order by t.transaction_time) as rn
  from transactions as t
  inner join accounts as a on a.account_id = t.account_id
  inner join users as u on u.user_id = a.user_id
  where transaction_type = 'withdrawal' and amount > 5000
)

insert into fraud_flags (transaction_id, flag_reason, flag_date, resolved)
select w1.transaction_id, 
       '3 large withdrawals in a row', 
       w1.transaction_time, 
       0
from withdrawals as w1
join withdrawals as w2 
  on w1.user_id = w2.user_id and w2.rn = w1.rn + 1
join withdrawals as w3 
  on w1.user_id = w3.user_id and w3.rn = w1.rn + 2;

--3
select account_id, max(amount) as max_amount, min(amount) as min_amount from transactions as t
group by account_id;

--4
select l1.user_id, l1.login_time, l2.login_time from user_logins as l1
inner join user_logins as l2 on l1.user_id=l2.user_id and l1.login_time=l2.login_time and l1.login_id<>l2.login_id;


--5

select datepart(week,f.flag_date) as week_num,
count(*) as flag_count,
sum(case when f.resolved=1 then 1 else 0 end) as resolved_sum from fraud_flags as f
group by datepart(week,f.flag_date);

--6

if object_id('trg_foreign_transfer_flag','tr') is not null
  drop trigger trg_foreign_transfer_flag;
go

create trigger trg_foreign_transfer_flag
on transactions
after insert
as
begin
  insert into fraud_flags (transaction_id, flag_reason, flag_date)
  select i.transaction_id, 'foreign transfer', getdate()
  from inserted as i
  join accounts as a on i.account_id = a.account_id
  join users as u on u.user_id=a.user_id
  where  i.country<> u.country;
end;
go

--7

create view countries_fraud
select u.country, count(f.flag_id) number_of_fraud from fraud_flags as f
inner join transactions as t on f.transaction_id=t.transaction_id
inner join accounts as a on t.account_id=a.account_id
inner join users as u on u.user_id=a.account_id
group by u.country
order by  count(f.flag_id) desc





--8


if object_id('sp_log_ip_change','p') is not null
  drop procedure sp_log_ip_change;
go

-- create procedure to log IP changes
create procedure sp_log_ip_change
  @user_id   int,
  @new_ip    varchar(45)
as
begin
  set nocount on;

  declare @last_ip varchar(45);

  -- get the most recent IP for this user
  select top 1 @last_ip = new_ip
  from user_ip_log
  where user_id = @user_id
  order by change_time desc;

  -- if first time or IP has changed, insert a log
  if @last_ip is null or @last_ip <> @new_ip
  begin
    insert into user_ip_log (user_id, old_ip, new_ip, change_time)
    values (@user_id, @last_ip, @new_ip, getdate());
  end
end;
go

exec sp_log_ip_change @user_id = 5, @new_ip = '203.0.113.42';

