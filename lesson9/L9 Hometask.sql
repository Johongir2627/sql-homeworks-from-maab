

create database homeworks_from_maab
use homeworks_from_maab


/*Puzzle 1 A value of 0 signifies the workflow failed, and a value of 1 signifies the workflow passed.
Write an SQL statement that transforms the following table into the expected output.*/


CREATE TABLE #WorkflowCases
(
Workflow  VARCHAR(100) PRIMARY KEY,
Case1     INTEGER NOT NULL DEFAULT 0,
Case2     INTEGER NOT NULL DEFAULT 0,
Case3     INTEGER NOT NULL DEFAULT 0
);
GO

INSERT INTO #WorkflowCases (Workflow, Case1, Case2, Case3) VALUES
('Alpha',0,0,0),('Bravo',0,1,1),('Charlie',1,0,0),('Delta',0,0,0);
GO






--1. method
select Workflow, Case1 + Case2 + Case3 from #WorkflowCases

drop table rr
--2. method
create table rr (workflow varchar(50), cases int) 
insert into rr (workflow, cases)
select Workflow, Case1 from #WorkflowCases
union all
select Workflow, Case2 from #WorkflowCases
union all
select Workflow, Case3 from #WorkflowCases
select workflow, sum(cases) from rr group by workflow






/*Puzzle 2
Write an SQL statement given the following requirements.
For every customer that had a delivery to California, provide a result set of the customer orders that
were delivered to Texas*/

CREATE TABLE #Orders
(
CustomerID     INTEGER,
OrderID        INTEGER,
DeliveryState  VARCHAR(100) NOT NULL,
Amount         MONEY NOT NULL,
PRIMARY KEY (CustomerID, OrderID)
);
GO

INSERT INTO #Orders (CustomerID, OrderID, DeliveryState, Amount) VALUES
(1001,1,'CA',340),(1001,2,'TX',950),(1001,3,'TX',670),
(1001,4,'TX',860),(2002,5,'WA',320),(3003,6,'CA',650),
(3003,7,'CA',830),(4004,8,'TX',120);
GO

select * from #Orders
select * from #Orders o1 cross join #Orders o2

select distinct o1.CustomerID, o2.OrderID, o2.DeliveryState, o2.Amount, o1.DeliveryState from #Orders o1 cross join #Orders o2
where o1.DeliveryState = 'ca' and o2.DeliveryState = 'tx'





/*Puzzle 3
Your customer phone directory table allows individuals to set up a home, cellular, or work phone
number.
Write an SQL statement to transform the following table into the expected output
*/

CREATE TABLE #PhoneDirectory
(
CustomerID   INTEGER,
[Type]       VARCHAR(100),
PhoneNumber  VARCHAR(12) NOT NULL,
PRIMARY KEY (CustomerID, [Type])
);
GO

INSERT INTO #PhoneDirectory (CustomerID, [Type], PhoneNumber) VALUES
(1001,'Cellular','555-897-5421'),
(1001,'Work','555-897-6542'),
(1001,'Home','555-698-9874'),
(2002,'Cellular','555-963-6544'),
(2002,'Work','555-812-9856'),
(3003,'Cellular','555-987-6541');
GO

select CustomerID, [Cellular], [Home], [Work] from 
    (select CustomerID, [Type], PhoneNumber from #PhoneDirectory) as SourceTable
pivot (MAX(PhoneNumber) for [Type] in ([Cellular], [Home], [Work])) as PivotTable order by CustomerID




select distinct 
	case when p1.customerID = p2.CustomerID then p1.customerID
	else null end, 
	case when p1.Type = 'cellular' and p1.CustomerID = p2.CustomerID then p1.PhoneNumber
	else null end as 'Cellular',
	case when p1.Type = 'work' and p1.CustomerID = p2.CustomerID then p1.PhoneNumber
	else null end as 'Work',
	case when p1.Type = 'home' and p1.CustomerID = p2.CustomerID then p1.PhoneNumber
	else null end as 'Home'
from #PhoneDirectory p1 cross join #PhoneDirectory p2



select  distinct
	 p1.customerID, 
	case when p1.Type = 'cellular' and p1.CustomerID = p2.CustomerID then p1.PhoneNumber
	else null end as Cellular,
	case when p1.Type = 'work' and p1.CustomerID = p2.CustomerID then p1.PhoneNumber
	else null end as Work,
	case when p1.Type = 'home' and p1.CustomerID = p2.CustomerID then p1.PhoneNumber
	else null end as Home
from #PhoneDirectory p1 cross join #PhoneDirectory p2





/*Puzzle 4
You work for a manufacturing company and need to track inventory adjustments from the warehouse.
Some days the inventory increases, on other days the inventory decreases.
Write an SQL statement that will provide a running balance of the inventory
*/
CREATE TABLE #Inventory
(
InventoryDate       DATE PRIMARY KEY,
QuantityAdjustment  INTEGER NOT NULL
);
GO

INSERT INTO #Inventory (InventoryDate, QuantityAdjustment) VALUES
('7/1/2018',100),('7/2/2018',75),('7/3/2018',-150),
('7/4/2018',50),('7/5/2018',-75);
GO



select InventoryDate, QuantityAdjustment, sum(QuantityAdjustment) over (order by InventoryDate) as RunningBalance
from #Inventory order by InventoryDate
