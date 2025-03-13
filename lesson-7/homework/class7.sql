use class7;
go
drop table if exists Customers;
drop table if exists Orders;
drop table if exists  OrderDetails;
drop table if exists Products;
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE
);

CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT FOREIGN KEY REFERENCES Orders(OrderID),
    ProductID INT,
    Quantity INT,
    Price DECIMAL(10,2)
);

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50)
);

INSERT INTO Customers (CustomerID, CustomerName) VALUES
(1, 'John Doe'),
(2, 'Jane Smith'),
(3, 'Alice Johnson'),
(4, 'Mark Johnson');

INSERT INTO Orders (OrderID, CustomerID, OrderDate) VALUES
(1, 1, '2025-03-13'),
(2, 2, '2025-03-14'),
(3, 3, '2025-03-15');

INSERT INTO OrderDetails (OrderDetailID, OrderID, ProductID, Quantity, Price) VALUES
(1, 1, 1, 2, 10.99),
(2, 1, 2, 1, 5.99),
(3, 2, 3, 3, 8.49),
(4, 3, 1, 1, 10.99);

INSERT INTO Products (ProductID, ProductName, Category) VALUES
(1, 'Product A', 'Electronics'),
(2, 'Product B', 'Clothing'),
(3, 'Product C', 'Home & Kitchen');

--1. Retrieve All Customers With Their Orders (Include Customers Without Orders)
--		*Use an appropriate JOIN to list all customers, their order IDs, and order dates.
--		*Ensure that customers with no orders still appear.

select CustomerName, OrderID, OrderDate from 
Customers c
left join Orders o
on c.CustomerID = o.CustomerID

--2. Find Customers Who Have Never Placed an Order
--		*Return customers who have no orders.

select CustomerName from 
Customers c
left join Orders o
on c.CustomerID = o.CustomerID
WHERE  o.OrderID is null

--3. List All Orders With Their Products
--		*Show each order with its product names and quantity.
select  p.ProductName, od.Quantity from 
OrderDetails od
join Products p
on od.ProductID = p.ProductID

--4. Find Customers With More Than One Order
--		*List customers who have placed more than one order.
select c.CustomerName, od.Quantity from 
Customers c
join Orders o
on c.CustomerID = o.CustomerID
join OrderDetails od
on o.OrderID = od.OrderID
where od.Quantity>1

--5.Find the Most Expensive Product in Each Order
select p.ProductName, MAX(od.Price/od.Quantity) as most_expensive from 
Customers c 
join Orders o
on c.CustomerID=o.CustomerID
join OrderDetails od
on o.OrderID=od.OrderID
join Products p
on od.ProductID = p.ProductID
group by p.ProductName
order by most_expensive DESC

--6. Find the Latest Order for Each Customer
select p.ProductName, MAX(od.Price/od.Quantity) as most_expensive from 
Customers c 
join Orders o
on c.CustomerID=o.CustomerID
join OrderDetails od
on o.OrderID=od.OrderID
join Products p
on od.ProductID = p.ProductID
group by p.ProductName
order by most_expensive DESC
select * from Customers;
select * from Orders;
select * from  OrderDetails;
select * from Products;
--7. Find Customers Who Ordered Only 'Electronics' Products
--		*List customers who only purchased items from the 'Electronics' category.
select c.CustomerName, p.Category from 
Customers c
join Orders o
on c.CustomerID = o.CustomerID
join OrderDetails od
on o.OrderID = od.OrderID
join Products p 
on od.ProductID = p.ProductID
where p.Category='Electronics'

--8. Find Customers Who Ordered at Least One 'Stationery' Product
--		*List customers who have purchased at least one product from the 'Stationery' category.
select c.CustomerName, p.Category from 
Customers c
join Orders o
on c.CustomerID = o.CustomerID
join OrderDetails od
on o.OrderID = od.OrderID
join Products p 
on od.ProductID = p.ProductID
where p.Category='Stationery'

--9️ Find Total Amount Spent by Each Customer
--		*Show CustomerID, CustomerName, and TotalSpent.
select c.CustomerID, c.CustomerName, SUM(Quantity*Price) as t_sum from 
Customers c
join Orders o
on c.CustomerID = o.CustomerID
join OrderDetails od
on o.OrderID = od.OrderID
group by c.CustomerID, c.CustomerName

