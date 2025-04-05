drop table if exists shipments;
CREATE TABLE Shipments (
    N INT PRIMARY KEY,
    Num INT
);

INSERT INTO Shipments (N, Num) VALUES 
    (1, 1),
    (2, 1),
    (3, 1),
    (4, 1),
    (5, 1),
    (6, 1),
    (7, 1),
    (8, 1),
    (9, 2),
    (10, 2),
    (11, 2),
    (12, 2),
    (13, 2),
    (14, 4),
    (15, 4),
    (16, 4),
    (17, 4),
    (18, 4),
    (19, 4),
    (20, 4),
    (21, 4),
    (22, 4),
    (23, 4),
    (24, 4),
    (25, 4),
    (26, 5),
    (27, 5),
    (28, 5),
    (29, 5),
    (30, 5),
    (31, 5),
    (32, 6),
    (33, 7);

with nums as(
	select num from shipments
	union all
	select 0 from (values (1),(1),(1),(1),(1),(1),(1)) as zeros(n)
),
ranked as(
	select num, row_number() over (order by num) as rn from nums
)
select avg(num) as median from ranked
where rn in( (select count(*)/2 from ranked),(select count(*)/2+1 from ranked))


	