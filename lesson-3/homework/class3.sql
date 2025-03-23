use class3;
DROP TABLE IF EXISTS dbo.Employees;
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10,2),
    HireDate DATE
);

INSERT INTO Employees (EmployeeID, FirstName, LastName, Department, Salary, HireDate)
VALUES 
    (1, 'Alice', 'Johnson', 'HR', 60000, '2019-03-15'),
    (2, 'Bob', 'Smith', 'IT', 85000, '2018-07-20'),
    (3, 'Charlie', 'Brown', 'Finance', 95000, '2017-01-10'),
    (4, 'David', 'Williams', 'HR', 50000, '2021-05-22'),
    (5, 'Emma', 'Jones', 'IT', 110000, '2016-12-02'),
    (6, 'Frank', 'Miller', 'Finance', 40000, '2022-06-30'),
    (7, 'Grace', 'Davis', 'Marketing', 75000, '2020-09-14'),
    (8, 'Henry', 'White', 'Marketing', 72000, '2020-10-10'),
    (9, 'Ivy', 'Taylor', 'IT', 95000, '2017-04-05'),
    (10, 'Jack', 'Anderson', 'Finance', 105000, '2015-11-12');

SELECT  AVG(Salary) as Average_Salary, Department,
	CASE
		WHEN AVG(Salary)>8000 THEN 'HIGH'
		WHEN AVG(Salary) BETWEEN 50000 AND 80000 THEN 'Medium'
		ELSE 'Low'
	END as SalaryCategory
FROM Employees
GROUP BY  Department
ORDER BY AVG(Salary) DESC
OFFSET 2 ROWS FETCH NEXT 5 ROWS ONLY;

------------------------------------
--Task 2: Customer Order Insights

DROP TABLE IF EXISTS Orders;
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    OrderDate DATE,
    TotalAmount DECIMAL(10,2),
    Status VARCHAR(20) CHECK (Status IN ('Pending', 'Shipped', 'Delivered', 'Cancelled'))
);

INSERT INTO Orders (OrderID, CustomerName, OrderDate, TotalAmount, Status)
VALUES 
    (101, 'John Doe', '2023-01-15', 2500, 'Shipped'),
    (102, 'Mary Smith', '2023-02-10', 4500, 'Pending'),
    (103, 'James Brown', '2023-03-25', 6200, 'Delivered'),
    (104, 'Patricia Davis', '2023-05-05', 1800, 'Cancelled'),
    (105, 'Michael Wilson', '2023-06-14', 7500, 'Shipped'),
    (106, 'Elizabeth Garcia', '2023-07-20', 9000, 'Delivered'),
    (107, 'David Martinez', '2023-08-02', 1300, 'Pending'),
    (108, 'Susan Clark', '2023-09-12', 5600, 'Shipped'),
    (109, 'Robert Lewis', '2023-10-30', 4100, 'Cancelled'),
    (110, 'Emily Walker', '2023-12-05', 9800, 'Delivered');

SELECT * FROM Orders;

SELECT 
	CASE
		WHEN Status='Shipped' OR Status='Delivered' THEN 'Completed'
		WHEN Status='Pending' THEN 'Pending'
		WHEN Status='Cancelled' THEN 'Cancelled'
	END as OrderStatus, SUM(TotalAmount) as TotalRevenue
FROM Orders
WHERE OrderDate BETWEEN '2023-01-01' and '2023-12-31'
GROUP BY 	
	CASE
		WHEN Status='Shipped' OR Status='Delivered' THEN 'Completed'
		WHEN Status='Pending' THEN 'Pending'
		WHEN Status='Cancelled' THEN 'Cancelled'
	END 
HAVING SUM(TotalAmount)>5000
ORDER BY TotalRevenue DESC; 

-------------------------------------
--Task 3: Product Inventory Check

DROP TABLE IF EXISTS Products;
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2),
    Stock INT
);

INSERT INTO Products (ProductID, ProductName, Category, Price, Stock)
VALUES 
    (1, 'Laptop', 'Electronics', 1200, 15),
    (2, 'Smartphone', 'Electronics', 800, 30),
    (3, 'Desk Chair', 'Furniture', 150, 5),
    (4, 'LED TV', 'Electronics', 1400, 8),
    (5, 'Coffee Table', 'Furniture', 250, 0),
    (6, 'Headphones', 'Accessories', 200, 25),
    (7, 'Monitor', 'Electronics', 350, 12),
    (8, 'Sofa', 'Furniture', 900, 2),
    (9, 'Backpack', 'Accessories', 75, 50),
    (10, 'Gaming Mouse', 'Accessories', 120, 20);

SELECT DISTINCT Category, MAX(Price) as MostExpensiveProducts,
IIF(sum(Stock)=0, 'Out of Stock', IIF(sum(Stock) between 1 and 10, 'Low Stock', 'In Stock')) as Inventory_status
FROM Products
GROUP BY Category
ORDER BY MostExpensiveProducts DESC 