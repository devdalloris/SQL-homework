CREATE DATABASE class4;
GO

-- Task1. If all the columns having zero value then don't show that row.
CREATE TABLE [dbo].[TestMultipleZero]
(
    [A] [int] NULL,
    [B] [int] NULL,
    [C] [int] NULL,
    [D] [int] NULL
);
GO

INSERT INTO [dbo].[TestMultipleZero](A,B,C,D)
VALUES 
    (0,0,0,1),
    (0,0,1,0),
    (0,1,0,0),
    (1,0,0,0),
    (0,0,0,0),
    (1,1,1,0);

select * from [dbo].[TestMultipleZero]
WHERE A<>0 or B<>0 or C<>0 or D<>0;

-- Task2. Write a query which will find maximum value from multiple columns of the table.

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
CASE 
	WHEN Max1>Max2 and Max1>Max3 THEN Max1
	WHEN Max2>Max1 and Max2>Max3 THEN Max2
	WHEN Max3>Max2 and Max3>Max1 THEN Max3
END as Maximum
from TestMax

-- Task3. Write a query which will find the Date of Birth of employees whose birthdays lies between May 7 and May 15.

CREATE TABLE EmpBirth
(
    EmpId INT  IDENTITY(1,1) 
    ,EmpName VARCHAR(50) 
    ,BirthDate DATETIME 
);
 
INSERT INTO EmpBirth(EmpName,BirthDate)
SELECT 'Pawan' , '12/04/1983'
UNION ALL
SELECT 'Zuzu' , '11/28/1986'
UNION ALL
SELECT 'Parveen', '05/07/1977'
UNION ALL
SELECT 'Mahesh', '01/13/1983'
UNION ALL
SELECT'Ramesh', '05/09/1983';

select * from EmpBirth
WHERE (DAY(BirthDate) between 7 and 15) and MONTH(BirthDate)=05;

--Task4. Order letters but 'b' must be first/last
       --Order letters but 'b' must be 3rd (Optional)
drop table if exists letters;
create table letters
(letter char(1));

insert into letters
values ('a'), ('a'), ('a'), 
  ('b'), ('c'), ('d'), ('e'), ('f');

SELECT letter
FROM letters
ORDER BY 
CASE 
    WHEN letter = 'b' THEN 0
    ELSE 1
END, letter;

SELECT letter
FROM letters
ORDER BY 
CASE 
    WHEN letter = 'b' THEN 1
    WHEN letter != 'b' THEN 0
END, 
CASE 
    WHEN letter = 'b' THEN 0
    ELSE 1
END, letter;


