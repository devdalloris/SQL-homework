 USE CLASS5;
 GO
 --TABLE STRUTURE
 --   Employees:
 --   - EmployeeID    INT
 --   - Name          VARCHAR(50)
 --   - Department    VARCHAR(50)
 --   - Salary        DECIMAL(10,2)
 --   - HireDate      DATE
drop table if exists Employees;
CREATE TABLE Employees (
    EmployeeID INT IDENTITY(1,1) PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Department VARCHAR(50) NOT NULL,
    Salary DECIMAL(10,2) NOT NULL,
    HireDate DATE NOT NULL
);

INSERT INTO Employees (Name, Department, Salary, HireDate) VALUES
('Alice', 'HR', 50000, '2020-06-15'),
('Bob', 'HR', 60000, '2018-09-10'),
('Charlie', 'IT', 70000, '2019-03-05'),
('David', 'IT', 80000, '2021-07-22'),
('Eve', 'Finance', 90000, '2017-11-30'),
('Frank', 'Finance', 75000, '2019-12-25'),
('Grace', 'Marketing', 65000, '2016-05-14'),
('Hank', 'Marketing', 72000, '2019-10-08'),
('Ivy', 'IT', 67000, '2022-01-12'),
('Jack', 'HR', 52000, '2021-03-29');

INSERT INTO Employees (Name, Department, Salary, HireDate) VALUES
('Lisa', 'IT', 50000, '2020-06-16')
INSERT INTO Employees (Name, Department, Salary, HireDate) VALUES
('Lisa', 'HR', 67000, '2020-06-26')

select * from Employees;

--Tasks
--Ranking Functions
--1.Assign a Unique Rank to Each Employee Based on Salary
select *, 
ROW_NUMBER() OVER(order by Salary) as u_r 
from Employees order by EmployeeID

--2.Find Employees Who Have the Same Salary Rank
select  Salary, COUNT(Salary) as t from Employees

GROUP BY Salary 
HAVING COUNT(Salary)>1;

select * from Employees;

--3.Identify the Top 2 Highest Salaries in Each Department
select Department, Salary from 
(select *, DENSE_RANK() 
OVER(partition by Department order by Salary DESC) as t from Employees) mytb
where t<3;

--4.Find the Lowest-Paid Employee in Each Department
select Name, Department, Salary from 
(select *, DENSE_RANK() 
OVER(partition by Department order by Salary) as t from Employees) mytb
where t=1;

--5.Calculate the Running Total of Salaries in Each Department
SELECT
    *,
    SUM(Salary) OVER (PARTITION BY Department ORDER BY HireDate) AS RunningTotal
FROM Employees

--6.Find the Total Salary of Each Department Without GROUP BY
select *, SUM(Salary) over(partition by Department) as TotalSalary from Employees;

--7.Calculate the Average Salary in Each Department Without GROUP BY
select *, AVG(Salary) over(partition by Department) as AverageSalary from Employees;

--8.Find the Difference Between an Employee’s Salary and Their Department’s Average
select *, e.Salary-AVG(e.Salary) over(partition by Department) as DifferenceSalary from Employees e;

--9.Calculate the Moving Average Salary Over 3 Employees (Including Current, Previous, and Next)
select 
		*,
		avg(salary) over(order by HireDate rows between 1 preceding and 1 following) as res
		from Employees;
--10.Find the Sum of Salaries for the Last 3 Hired Employees
select 
		*,
		sum(salary) over(order by HireDate rows between current row and 2 following) as res
		from Employees;
--11.Calculate the Running Average of Salaries Over All Previous Employees
select 
		*,
		avg(salary) over(order by HireDate) as res
		from Employees;
--12.Find the Maximum Salary Over a Sliding Window of 2 Employees Before and After
select 
		*,
		max(salary) over(order by HireDate rows between 1 preceding and 1 following) as res
		from Employees;
--13.Determine the Percentage Contribution of Each Employee’s Salary to Their Department’s Total Salary
select 
		*,
		CAST(Salary/sum(Salary) over(order by Department rows between 1 preceding and 1 following) *100 as DECIMAL(10,2)) as res
		from Employees;