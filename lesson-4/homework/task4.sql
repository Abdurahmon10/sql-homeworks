drop table if exists letters;
create table letters
(letter char(1));

insert into letters
values ('a'), ('a'), ('a'), 
  ('b'), ('c'), ('d'), ('e'), ('f');


select * from letters;
SELECT *
FROM letters
ORDER BY 
    CASE WHEN letter = 'b' THEN 0 ELSE 1 END,
    ASCII(letter);


select * from letters
order by
	case when letter = 'b' then 1 else 0  end,
	ascii(letter);

select *,
	case
		when ascii(letter)<ascii('b')  then 1
		when ascii(letter)>ascii('b')  then 4
		when letter = 'b' then 3
	end
from letters
order by
	case
		when ascii(letter)<ascii('b')  then 1
		when ascii(letter)>ascii('b')  then 4
		when letter = 'b' then 3
		end,
	ascii(letter);
