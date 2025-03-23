drop table if exists TextMax;
CREATE TABLE TestMax
(
    Year1 INT
    ,Max1 INT
    ,Max2 INT
    ,Max3 INT
);
GO
 
INSERT INTO TestMax 
VALUES
    (2001,10,101,87)
    ,(2002,103,19,88)
    ,(2003,21,23,89)
    ,(2004,27,28,91);

select Year1,
	iif(max1>max2 and max1>max3, max1,
			iif (max2>max1 and max2>max3, max2, max3)) as MaxAll
from TestMax
--group by Max1, Max2, Max3;