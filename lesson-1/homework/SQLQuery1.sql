CREATE DATABASE class1;
GO
--1. NOT NULL Constraint
DROP TABLE IF EXISTS student;
CREATE TABLE student(
	id int, 
	name varchar(50),
	age int
);

INSERT INTO student 
VALUES (1, 'Dalloris', 24), (2, 'Tumaris', 26), (3, 'Sayora', 28);

ALTER TABLE student
ALTER COLUMN id INTEGER NOT NULL;

SELECT * FROM student;

---------------------------------
--2. UNIQUE Constraint
DROP TABLE IF EXISTS product;
CREATE TABLE product(
       product_id int NOT NULL UNIQUE,
	   product_name varchar(50),
	   price decimal
);

INSERT INTO product  
VALUES
(1, 'Apple', 20), (2, 'Banana', 15), (3, 'Strawberry', 23);

ALTER TABLE product
drop constraint UQ__product__47027DF49A06E97E;

ALTER TABLE product
ADD CONSTRAINT unique_product_id_name UNIQUE(product_id, product_name);

SELECT * FROM product;
----------------------------------------------
--3. PRIMARY KEY Constraint
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
    order_id int PRIMARY KEY,
    customer_name varchar(50),
    order_date date
);

INSERT INTO orders (order_id, customer_name, order_date)
VALUES (1, 'Dalloris', '2025-01-10'),
       (2, 'Tumaris', '2025-02-12'), 
       (3, 'Sayora', '2025-04-18');

ALTER TABLE orders
DROP CONSTRAINT PK__orders__465962291B13C51A;

ALTER TABLE orders
ADD CONSTRAINT PK__orders__465962291B13C51A PRIMARY KEY (order_id);
SELECT * FROM orders;
/*
SELECT 
    CONSTRAINT_NAME 
FROM 
    INFORMATION_SCHEMA.TABLE_CONSTRAINTS 
WHERE 
    TABLE_NAME = 'orders' AND 
    CONSTRAINT_TYPE = 'PRIMARY KEY';
	
*/
----------------------------------------------
--4. FOREIGN KEY Constraint
DROP TABLE IF EXISTS category;
CREATE TABLE category(
	category_id int PRIMARY KEY,
	category_name varchar(50)
);

INSERT INTO category
VALUES (1, 'high'),(2, 'low'),(3, 'high');

DROP TABLE IF EXISTS item;
CREATE TABLE item(
	item_id int PRIMARY KEY,
	item_name varchar(50),
	category_id int FOREIGN KEY REFERENCES category(category_id) 
);

INSERT INTO item
VALUES (1, 'A', 1),(2, 'B', 3),(3, 'C', 2);

/*
SELECT 
    CONSTRAINT_NAME 
FROM 
    INFORMATION_SCHEMA.TABLE_CONSTRAINTS 
WHERE 
    TABLE_NAME = 'item' AND 
    CONSTRAINT_TYPE = 'FOREIGN KEY';
*/

ALTER TABLE item
DROP CONSTRAINT FK__item__category_i__49E3F248;

ALTER TABLE item
ADD FOREIGN KEY (category_id) REFERENCES category(category_id);

-------------------------------------------------------
--5. CHECK Constraint
DROP TABLE IF EXISTS account;
CREATE TABLE account(
	account_id int PRIMARY KEY,
	balance decimal CHECK (balance>=0),
	account_type varchar(50) CHECK(account_type = 'Saving' or account_type='Checking')
);

INSERT INTO account 
VALUES
	(1, 20, 'Saving'),
	(2, 23, 'Sav'),
	(3, 28, 'Checking');
SELECT * FROM account;

/*
SELECT 
    CONSTRAINT_NAME 
FROM 
    INFORMATION_SCHEMA.TABLE_CONSTRAINTS 
WHERE 
    TABLE_NAME = 'account' AND 
    CONSTRAINT_TYPE = 'CHECK';
*/

ALTER TABLE account
DROP CONSTRAINT CK__account__balance__668030F6;

ALTER TABLE account
DROP CONSTRAINT CK__account__account__6774552F;

ALTER TABLE account 
ADD CONSTRAINT CK__account__balance__668030F6 CHECK (balance >=0);

ALTER TABLE account 
ADD CONSTRAINT CK__account__account__6774552F CHECK (account_type = 'Checking' or account_type = 'Saving');
SELECT * FROM account;

---------------------------------------------------------

--6. DEFAULT Constraint
DROP TABLE IF EXISTS customer;
CREATE TABLE customer(
	customer_id int PRIMARY KEY, 
	name varchar(50), 
	city varchar(100) NOT NULL DEFAULT 'Unknown',
);

INSERT INTO customer
VALUES 
	(1, 'Dalloris', 'Nukus'),
	(2, 'Tumaris', 'Tashkent'),
	(3, 'Sayora', 'Paris')
 ;

 /*
SELECT 
    COLUMN_NAME, 
    CONSTRAINT_NAME 
FROM 
    INFORMATION_SCHEMA.CONSTRAINT_COLUMN_USAGE 
WHERE 
    TABLE_NAME = 'customer' AND 
    COLUMN_NAME = 'city';
*/

 INSERT INTO customer
 VALUES (4, 'Samira', DEFAULT);
 SELECT * FROM customer;

 ALTER TABLE customer 
 ALTER COLUMN city DROP DEFAULT;

 ALTER TABLE customer
 ADD CONSTRAINT city DEFAULT 'Unknown1' FOR city;

 --------------------------------------------------------
 --7. IDENTITY Column
 DROP TABLE IF EXISTS invoice;
 CREATE TABLE invoice(
	invoice_id int PRIMARY KEY IDENTITY,
	amount decimal
 );

 INSERT INTO invoice
 VALUES 
 (20), (23), (24), (12), (31);

 SELECT * FROM invoice;

 SET IDENTITY_INSERT invoice ON;

INSERT INTO invoice (invoice_id, amount) VALUES (100, 34);

 SET IDENTITY_INSERT invoice OFF;

 SELECT * FROM invoice;

---------------------------------------------
--8. All at once
 DROP TABLE IF EXISTS books;
 CREATE TABLE books(
	book_id int PRIMARY KEY IDENTITY,
	title varchar(50) NOT NULL,
	price decimal CHECK(price > 0),
	genre varchar(50) DEFAULT 'Unknown'
 );

 INSERT INTO books
 VALUES 
 ('Me before you', 40, DEFAULT),
 ('Basic English', 55, 'Double');
  SELECT * FROM books;

  ---------------------------------------
  --9. Scenario: Library Management System
  DROP TABLE IF EXISTS Book;
  CREATE TABLE Book(
	book_id int PRIMARY KEY,
	title varchar(100),
	author varchar(100)
  );
	
  INSERT INTO Book
  VALUES 
  (1, 'Me before you1', 'Jojo1 Moyes'),
  (2, 'Me before you2', 'Jojo2 Moyes'),
  (3, 'Me before you3', 'Jojo3 Moyes'),
  (4, 'Me before you4', 'Jojo4 Moyes');

    SELECT * FROM Book;

  DROP TABLE IF EXISTS Member;
  CREATE TABLE Member(
	member_id int PRIMARY KEY,
	name varchar(100),
	email varchar(100),
	phone_number varchar(100)
  );

  INSERT INTO Member
  VALUES 
  (1, 'Dalloris', 'dollydolly@gmail.com', '+998993453434'),
  (2, 'Tumaris', 'tollytolly@gmail.com', '+998993453535'),
  (3, 'Sayora', 'sollysolly@gmail.com', '+998993453636');

  SELECT * FROM Member;

  DROP TABLE IF EXISTS Loan;
  CREATE TABLE Loan(
	loan_id int PRIMARY KEY,
	book_id int FOREIGN KEY REFERENCES Book(book_id),
	member_id int FOREIGN KEY REFERENCES Member(member_id),
	loan_date date,
	return_date date NULL 
  );

  INSERT INTO Loan
  VALUES 
  (1, 4, 2, '2024-10-11', '2024-11-11'),
  (3, 3, 1, '2024-08-11', '2024-09-11'),
  (2, 2, 3, '2024-10-11', '2024-12-11');
  SELECT * FROM Loan;


  


