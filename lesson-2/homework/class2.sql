CREATE DATABASE class2;
GO

--1. DELETE vs TRUNCATE vs DROP (with IDENTITY example)
DROP TABLE IF EXISTS test_identity;
CREATE TABLE test_identity(
	test_id int PRIMARY KEY IDENTITY(1,1),
	test_name varchar(255)
);

INSERT INTO test_identity(test_name)
VALUES ('Math'), ('Phisics'), ('Biology'), ('Geography'), ('Law');

SELECT * FROM test_identity;

--DELETE
DELETE FROM test_identity;

DELETE FROM test_identity WHERE test_id=3;

--TRUNCATE
TRUNCATE TABLE test_identity;

--DROP 
DROP TABLE test_identity;

/*Answers for questions
I. DELETE is used for deleting data from database. In DELETE we can use a condition. 
II. TRUNCATE is used for deleting data from table. In TRUNCATE has not got a condition 'where'. 
III. DROP is used for completely deleting table from database.
*/

------------------------------------
--2. Common Data Types
DROP TABLE IF EXISTS data_types_demo;
CREATE TABLE data_types_demo(
	student_id int PRIMARY KEY IDENTITY,
	student_name varchar(50),
	student_birth date,
	student_weight decimal(10,2),
	student_email varchar(100),
	student_password UNIQUEIDENTIFIER, 
	);

INSERT INTO data_types_demo(student_name, student_birth, student_weight, student_email, student_password)
VALUES ('Dalloris', '2000-01-03', 62.00, 'dollydolly@gmail.com', '9C996FD7-819D-413F-A5D8-ABA7BB4BAFFF'); 

SELECT * FROM data_types_demo;

--------------------------------------
--3. Inserting and Retrieving an Image

DROP TABLE IF EXISTS photos;
CREATE TABLE photos(
	id int PRIMARY KEY IDENTITY,
	photo varbinary(MAX)
);

INSERT INTO photos
select BulkColumn from openrowset(
	BULK 'C:\Users\79639\Desktop\SQL\SQL-homework\images\image.png', SINGLE_BLOB
) AS img;

SELECT * FROM photos;

--------------------
--4. Computed Columns
DROP TABLE IF EXISTS student;
CREATE TABLE student(
	student_id int PRIMARY KEY IDENTITY,
	classes int,
	tuition_per_class int,
	total_tuition as (classes*tuition_per_class)
);

INSERT INTO student
VALUES (20,30), (23,25), (21, 27);

SELECT * FROM student;

---------------------------
--5. CSV to SQL Server
drop table if exists worker;
create table worker
(
	id int primary key identity,
	name varchar(100)
);

BULK INSERT worker
FROM 'C:\Users\79639\Desktop\SQL\SQL-homework\lesson-2\homework\data.csv'
WITH (
	firstrow=2,
	fieldterminator=',',
	rowterminator='\n'
);

SELECT * FROM worker;