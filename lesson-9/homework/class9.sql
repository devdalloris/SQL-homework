CREATE DATABASE class9;
GO

--Task 1. Given this Employee table below, find the level of depth each employee from the President.

DROP TABLE IF EXISTS Employees;
CREATE TABLE Employees
(
	EmployeeID  INTEGER PRIMARY KEY,
	ManagerID   INTEGER NULL,
	JobTitle    VARCHAR(100) NOT NULL
);
INSERT INTO Employees (EmployeeID, ManagerID, JobTitle) 
VALUES
	(1001, NULL, 'President'),
	(2002, 1001, 'Director'),
	(3003, 1001, 'Office Manager'),
	(4004, 2002, 'Engineer'),
	(5005, 2002, 'Engineer'),
	(6006, 2002, 'Engineer');


SELECT *, CASE 
	WHEN ManagerID IS NULL THEN  0
	WHEN ManagerID = 1001 THEN 1
	WHEN ManagerID = 2002 THEN  2
END as depth
FROM Employees;
-----------------------------------------
--Task 2. Find Factorials up to N. Expected output for N=10:
;WITH fact_cte AS (
    SELECT 1 AS Number, 1 AS Factorial
    UNION ALL
    SELECT Number + 1, Factorial * (Number + 1)
    FROM fact_cte
    WHERE Number < 10  
)
SELECT Factorial
FROM fact_cte
option (maxrecursion 20);

--------------------------------------------
--Task 3. Find Fibonacci numbers up to N. Expected output for N =10:
;WITH fib_cte AS (
    SELECT 1 as N, 0 AS Number1, 1 AS Number2
    UNION ALL
    SELECT N+1, Number2, Number1 + Number2
    FROM fib_cte
    WHERE N <10
)
SELECT Number2
FROM fib_cte
option (maxrecursion 100);