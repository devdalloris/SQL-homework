use class15;
go
--SQL Question 1. 
DROP TABLE IF EXISTS Contacts;
CREATE TABLE Contacts
(
	identifier_name NVARCHAR(50),
	identifier_value NVARCHAR(255),
	firstname NVARCHAR(255),
	lastname NVARCHAR(255),
	website NVARCHAR(255),
	company NVARCHAR(255),
	phone NVARCHAR(255),
	address NVARCHAR(255),
	city NVARCHAR(255),
	state NVARCHAR(255),
	zip NVARCHAR(255),
);

INSERT INTO Contacts(identifier_name, identifier_value, firstname, lastname, website, company, phone, address, city, state, zip)
VALUES 
	('vid', '259429', 'Harper', 'Wolfberg', 'http://hubspot.com', 'HubSpot', '555-122-2323', '25 First Street', 'Cambridge', 'MA', '02139'),
	('email', 'testingapis@hubspot.com', 'Codey', 'Huang', 'http://hubspot.com', 'HubSpot', '555-122-2323', '25 First Street', 'Cambridge', 'MA', '02139'),
    ('email', 'john.doe@example.com', 'John', 'Doe', 'http://example.org', 'Example Inc', '555-345-6789', '456 Oak St', 'Boston', 'MA', '02110'),
    ('email', 'alice.wonderland@fable.com', 'Alice', 'Wonderland', 'http://fable.com', 'Fable Enterprises', '555-987-6543', '102 Rabbit Hole', 'Wonderland', 'CA', '90210'),
	('vid', '543210', 'Ava', 'Smith', 'http://example.com', 'Example Corp', '555-233-4545', '123 Maple Ave', 'Springfield', 'IL', '62701'),
    ('vid', '987654', 'Jane', 'Roe', 'http://company.net', 'Company LLC', '555-678-1234', '789 Pine Rd', 'New York', 'NY', '10001'),
    ('email', 'emily.brown@company.com', 'Emily', 'Brown', 'http://company.com', 'Company Ltd', '555-222-3333', '88 Blueberry Lane', 'Austin', 'TX', '73301'),
    ('vid', '321987', 'Robert', 'Johnson', 'http://robertj.com', 'RJ Consulting', '555-111-2222', '22 Lincoln Way', 'Columbus', 'OH', '43215'),
    ('vid', '654321', 'Michael', 'Davis', 'http://davistech.com', 'Davis Technologies', '555-444-5555', '99 Tech Park', 'Seattle', 'WA', '98109'),
    ('email', 'oliver.queen@starcity.com', 'Oliver', 'Queen', 'http://starcity.com', 'Star City Industries', '555-777-8888', '567 Arrow St', 'Star City', 'CA', '94016');
SELECT
    identifier_name as name,
	identifier_value as value,
    JSON_QUERY(CONCAT('[{"property":"firstname","value":"', firstname, '"},{"property":"lastname","value":"', lastname, '"}]')) as properties
FROM Contacts
FOR JSON PATH;


--SQL Question 2.
drop table if exists items;
go

create table items
(
	ID						varchar(10),
	CurrentQuantity			int,
	QuantityChange   		int,
	ChangeType				varchar(10),
	Change_datetime			datetime
);
go

insert into items values
('A0013', 278,   99 ,   'out', '2020-05-25 0:25'), 
('A0012', 377,   31 ,   'in',  '2020-05-24 22:00'),
('A0011', 346,   1  ,   'out', '2020-05-24 15:01'),
('A0010', 347,   1  ,   'out', '2020-05-23 5:00'),
('A009',  348,   102,   'in',  '2020-04-25 18:00'),
('A008',  246,   43 ,   'in',  '2020-04-25 2:00'),
('A007',  203,   2  ,   'out', '2020-02-25 9:00'),
('A006',  205,   129,   'out', '2020-02-18 7:00'),
('A005',  334,   1  ,   'out', '2020-02-18 6:00'),
('A004',  335,   27 ,   'out', '2020-01-29 5:00'),
('A003',  362,   120,   'in',  '2019-12-31 2:00'),
('A002',  242,   8  ,   'out', '2019-05-22 0:50'),
('A001',  250,   250,   'in',  '2019-05-20 0:45');

select * from items;

;with AgeGroups as (
    SELECT
        ID,
        DATEDIFF(day, Change_datetime, '2020-05-25 0:25') as Age,
        CASE
            when DATEDIFF(day, Change_datetime, '2020-05-25 0:25') BETWEEN 1 AND 90    then '1-90 days old'
            when DATEDIFF(day, Change_datetime, '2020-05-25 0:25') BETWEEN 91 AND 180  then '91-180 days old'
            when DATEDIFF(day, Change_datetime, '2020-05-25 0:25') BETWEEN 181 AND 270 then '181-270 days old'
            when DATEDIFF(day, Change_datetime, '2020-05-25 0:25') BETWEEN 271 AND 360 then '271-360 days old'
            when DATEDIFF(day, Change_datetime, '2020-05-25 0:25') BETWEEN 361 AND 450 then '361-450 days old'
            ELSE 'Over 450 days old'
        END as AgeGroup
     from items
)
select
    SUM(CASE when AgeGroup = '1-90 days old'    then Age else 0 end) as '1-90 days old',
    SUM(CASE when AgeGroup = '91-180 days old'  then Age else 0 end) as '91-180 days old',
    SUM(CASE when AgeGroup = '181-270 days old' then Age else 0 end) as '181-270 days old',
    SUM(CASE when AgeGroup = '271-360 days old' then Age else 0 end) as '271-360 days old',
    SUM(CASE when AgeGroup = '361-450 days old' then Age else 0 end) as '361-450 days old'
from AgeGroups;

