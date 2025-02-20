use Northwind


--Northwind Advanced Part


--Q32
select Customers.CustomerID, Customers.CompanyName, Orders.OrderID, SUM(Quantity*UnitPrice) as TotalOrderAmount
from Customers join	Orders on Orders.CustomerID	= Customers.CustomerID join	OrderDetails on	Orders.OrderID = OrderDetails.OrderID
where OrderDate	>= '20160101' and OrderDate < '20170101'
group by Customers.CustomerID, Customers.CompanyName, Orders.Orderid 
having	sum(Quantity * UnitPrice) > 10000
order by TotalOrderAmount DESC






 --Q33
select	Customers.CustomerID, Customers.CompanyName, Orders.OrderID, SUM(Quantity * UnitPrice) as TotalOrderAmount from Customers join
Orders	on	Orders.CustomerID = Customers.CustomerID join OrderDetails on Orders.OrderID = OrderDetails.OrderID 
where OrderDate	>=	'20160101' and	OrderDate < '20170101' 
group by	Customers.CustomerID, Customers.CompanyName, Orders.Orderid	
having	sum(Quantity * UnitPrice) > 15000 order	by	TotalOrderAmount desc;






 --Q34
select	Customers.CustomerID, Customers.CompanyName, TotalsWithoutDiscount	= SUM(Quantity * UnitPrice), TotalsWithDiscount	= SUM(Quantity * UnitPrice * (1-Discount))
From	Customers join Orders	on	Orders.CustomerID	=	Customers.CustomerID
join	OrderDetails	on	Orders.OrderID	=	OrderDetails.OrderID
where	OrderDate >= '20160101' and	OrderDate <	'20170101'
group	by	Customers.CustomerID, Customers.CompanyName	
having	sum(Quantity*UnitPrice*(1-Discount)) > 10000
order by TotalsWithDiscount	DESC;





 --Q35
select EmployeeID, OrderID, OrderDate from	Orders 
where OrderDate = EOMONTH(OrderDate)
order	by EmployeeID, OrderID






--Q36
select top 10 Orders.OrderID, count(*) from Orders 
join OrderDetails on Orders.OrderID = OrderDetails.OrderID
group by Orders.OrderID order by COUNT(*) desc





--Q37
select top 2 percent orderid from Orders order by NEWID()




--Q38
select orderid from OrderDetails where Quantity >= 60 group by OrderID, Quantity having COUNT(*)>1




--39
;with PotDup as (select orderid from OrderDetails 
where Quantity>=60 group by OrderID, Quantity having count(*)>1)
select OrderID, ProductID, UnitPrice, Quantity, Discount from OrderDetails 
where OrderID in (select OrderID from PotDup) order by OrderID, Quantity





--40
select OrderDetails.OrderID, ProductID, UnitPrice, Quantity, Discount from OrderDetails
join(select	distinct OrderID from OrderDetails where Quantity >= 60
group by OrderID, Quantity having count(*) > 1) PotentialProblemOrders on PotentialProblemOrders.OrderID =	OrderDetails.OrderID
order by OrderID, ProductID





 --41
select OrderID, OrderDate = convert(date, OrderDate), RequiredDate = convert(date,	RequiredDate), ShippedDate = convert(date, ShippedDate)
from Orders where RequiredDate <= ShippedDate




 --42
select Employees.EmployeeID, LastName, TotalLateOrders	=	count(*) from	Orders
Join Employees on Employees.EmployeeID = Orders.EmployeeID
where RequiredDate <= ShippedDate group	by Employees.EmployeeID, Employees.LastName
order by TotalLateOrders desc





 --43
;with LateOrders as (select EmployeeID, TotalOrders	= count(*)	from Orders 
where RequiredDate <= ShippedDate group	by EmployeeID), AllOrders as(
select	EmployeeID,TotalOrders = count(*) from Orders 
group By EmployeeID) select Employees.EmployeeID, LastName, AllOrders = AllOrders.TotalOrders, LateOrders =
LateOrders.TotalOrders	from Employees join AllOrders	on AllOrders.EmployeeID = Employees.EmployeeID
join LateOrders	on LateOrders.EmployeeID = Employees.EmployeeID





 --44
;with LateOrders as	(
select EmployeeID, TotalOrders	= count(*) from Orders where RequiredDate <= ShippedDate	
group by EmployeeID), AllOrders	as (
select EmployeeID, TotalOrders	= count(*) from	Orders group by EmployeeID)	
select Employees.EmployeeID, LastName, AllOrders =	AllOrders.TotalOrders, LateOrders = LateOrders.TotalOrders
from Employees join	AllOrders on AllOrders.EmployeeID = Employees.EmployeeID
left join LateOrders on LateOrders.EmployeeID = Employees.EmployeeID




 --45
;with LateOrders as (select EmployeeID, TotalOrders = count(*) from	Orders 
where RequiredDate <= ShippedDate group by EmployeeID), AllOrders as (
select EmployeeID, TotalOrders = count(*) from Orders group by EmployeeID)
select Employees.EmployeeID, LastName, AllOrders = AllOrders.TotalOrders, LateOrders =
isnull(LateOrders.TotalOrders,	0)	from Employees	join AllOrders	on
AllOrders.EmployeeID =	Employees.EmployeeID
left join LateOrders on	LateOrders.EmployeeID =	Employees.EmployeeID





 --46
;with LateOrders as	(
select	EmployeeID, TotalOrders	= count(*) from	Orders	
where RequiredDate	<= ShippedDate	group by EmployeeID), AllOrders as (
select EmployeeID, TotalOrders	=	count(*) from Orders	group by EmployeeID)
select Employees.EmployeeID, LastName, AllOrders = AllOrders.TotalOrders, LateOrders =
isnull(LateOrders.TotalOrders,	0), PercentLateOrders =
(isnull(LateOrders.TotalOrders,	0) * 1.00) / AllOrders.TotalOrders	from
Employees join AllOrders on AllOrders.EmployeeID = Employees.EmployeeID
left join LateOrders	on	LateOrders.EmployeeID	=	Employees.EmployeeID




 --47
;With LateOrders as 
(select	EmployeeID, TotalOrders	=	Count(*)	from	Orders	
where	RequiredDate	<= ShippedDate 
Group By EmployeeID),	AllOrders	as	(select	EmployeeID,TotalOrders	=	Count(*)	
From	Orders	Group	By	EmployeeID
) select	Employees.EmployeeID,LastName	,AllOrders	=	AllOrders.TotalOrders	,LateOrders	=
IsNull(LateOrders.TotalOrders,	0), PercentLateOrders	= Convert(Decimal	(10,2)	,(IsNull(LateOrders.TotalOrders,	0)	*	1.00)	/
AllOrders.TotalOrders) From	Employees	Join	AllOrders	on AllOrders.EmployeeID = Employees.EmployeeID
Left Join LateOrders	on	LateOrders.EmployeeID	=	Employees.EmployeeID


--48
;with	Orders2016	as	(select	Customers.CustomerID, Customers.CompanyName, TotalOrderAmount	=	SUM(Quantity	*
UnitPrice)	From	Customers	Join	Orders	on	Orders.CustomerID	=
Customers.CustomerID Join	OrderDetails	on	Orders.OrderID	=	OrderDetails.OrderID
Where	OrderDate	>=	'20160101' and	OrderDate		<	'20170101'
Group	by	Customers.CustomerID, Customers.CompanyName	)	Select	CustomerID, CompanyName	,TotalOrderAmount	,CustomerGroup	=
	Case when TotalOrderAmount	between	0	and	1000	then	'Low'
	when TotalOrderAmount between 1001 and 5000	then 'Medium'
	when TotalOrderAmount between 5001 and 10000 then 'High'
	when	TotalOrderAmount	>	10000	then	'Very	High' End	from	Orders2016
 Order	by	CustomerID



--49
;with	Orders2016	as	(
select	Customers.CustomerID, Customers.CompanyName	,TotalOrderAmount	=	SUM(Quantity	*
UnitPrice)	From	Customers	Join	Orders	on	Orders.CustomerID	=
Customers.CustomerID Join	OrderDetails	on	Orders.OrderID	=	OrderDetails.OrderID
Where	OrderDate	>=	'20160101' and	OrderDate		<	'20170101'
Group	by	Customers.CustomerID, Customers.CompanyName	)	select	CustomerID, CompanyName	,TotalOrderAmount	,CustomerGroup	=
	case when TotalOrderAmount >= 0 and TotalOrderAmount < 1000 then 'Low'
		when TotalOrderAmount	>=	1000	and	TotalOrderAmount < 5000	then 'Medium'
		when TotalOrderAmount	>=	5000	and	TotalOrderAmount		<10000	then 'High'
		when TotalOrderAmount	>=	10000	then	'Very	High' end	from	Orders2016
 Order	by	CustomerID





 --50
;with Orders2016 as (
select Customers.CustomerID, Customers.CompanyName, TotalOrderAmount	=	SUM(Quantity * UnitPrice)	
From	Customers	join	Orders	on	Orders.CustomerID	= Customers.CustomerID 
join	OrderDetails	on	Orders.OrderID	=	OrderDetails.OrderID
Where	OrderDate	>=	'20160101' and	OrderDate		<	'20170101'
Group	By	Customers.CustomerID, Customers.CompanyName	), CustomerGrouping	as	(select	CustomerID,CompanyName	,TotalOrderAmount	,CustomerGroup	=
case	when	TotalOrderAmount >=	0	and	TotalOrderAmount		<	1000	then 'Low'
		when	TotalOrderAmount >=	1000 and	TotalOrderAmount		<	5000 then	'Medium'
		when	TotalOrderAmount >=	5000 and TotalOrderAmount < 10000 then	'High'
		when	TotalOrderAmount	>=	10000	then	'Very	High' end	from	Orders2016
Order	by	CustomerID)	select	CustomerGroup	,	TotalInGroup	=	Count(*)	,	PercentageInGroup	=
Count(*)	*	1.0/	(select	count(*)	from	CustomerGrouping)	
from CustomerGrouping	group	by	CustomerGroup	order	by	TotalInGroup		desc


--51
 ;with	Orders2016	as	(select	Customers.CustomerID, Customers.CompanyName	,TotalOrderAmount	=	SUM(Quantity	*
 UnitPrice)	From	Customers	Join	Orders	on	Orders.CustomerID	=
 Customers.CustomerID Join	OrderDetails	on	Orders.OrderID	=	OrderDetails.OrderID
Where	OrderDate	>=	'20160101' and	OrderDate		<	'20170101'
Group	by	Customers.CustomerID, Customers.CompanyName	)	Select	CustomerID, CompanyName	,TotalOrderAmount	,CustomerGroupName	from	Orders2016
Join	CustomerGroupThresholds	on	Orders2016.TotalOrderAmount	between
 CustomerGroupThresholds.RangeBottom	and
 CustomerGroupThresholds.RangeTop	Order	by	CustomerID





--52
 select	Country	From	Customers
 Union
 select	Country	From	Suppliers
 Order	by	Country




 --53
;with SupplierCountries	as (select distinct	Country	from Suppliers), CustomerCountries as (select distinct Country from	Customers)
select SupplierCountry = SupplierCountries.Country, CustomerCountry	= CustomerCountries.Country
from SupplierCountries full	outer join CustomerCountries
on	CustomerCountries.Country =	SupplierCountries.Country





 --54
;with SupplierCountries as
(select Country, Total = count(*) from Suppliers group by Country), CustomerCountries as (
select Country, Total = count(*) from Customers group by Country) 
select Country = isnull(SupplierCountries.Country, CustomerCountries.Country), 
TotalSuppliers = isnull(SupplierCountries.Total,0), 
TotalCustomers = isnull(CustomerCountries.Total,0) from	SupplierCountries full outer join
CustomerCountries on CustomerCountries.Country = SupplierCountries.Country





 --55
;with OrdersByCountry as (select ShipCountry, CustomerID, OrderID, OrderDate = convert(date, OrderDate), RowNumberPerCountry =	
Row_Number() over (partition by	ShipCountry	order by ShipCountry, OrderID) from	Orders)
select ShipCountry,CustomerID,OrderID,OrderDate from OrdersByCountry
where RowNumberPerCountry = 1 order	by ShipCountry





--56
select InitialOrder.CustomerID, InitialOrderID = InitialOrder.OrderID, InitialOrderDate	= convert(date, InitialOrder.OrderDate), NextOrderID = NextOrder.OrderID
,NextOrderDate	=	convert(date,	NextOrder.OrderDate), DaysBetween	=
datediff(dd, InitialOrder.OrderDate, NextOrder.OrderDate) from Orders
InitialOrder join Orders	NextOrder	on	InitialOrder.CustomerID	= NextOrder.CustomerID
where	InitialOrder.OrderID	<	NextOrder.OrderID
and	datediff(dd,	InitialOrder.OrderDate,	NextOrder.OrderDate)<= 5
order by InitialOrder.CustomerID, InitialOrder.OrderID






 --57
;with NextOrderDate	as (
select	CustomerID, OrderDate = convert(date, OrderDate), NextOrderDate	=
convert(date, lead(OrderDate,1) OVER (partition	by	CustomerID	order	by
CustomerID,	OrderDate)) from Orders)	
select	CustomerID, OrderDate, NextOrderDate	,DaysBetweenOrders	= DateDiff (dd,	OrderDate,
NextOrderDate)	from NextOrderDate where DateDiff (dd, OrderDate, NextOrderDate) <= 5







