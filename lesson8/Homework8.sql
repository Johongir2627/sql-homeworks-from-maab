--Homework 8

use Homework8
create table Categories(CategoryName varchar(20), Description varchar(20))
create table Employees (FirstName varchar(20), Lastname varchar(20),  HireDate varchar(20))
update  employees add (Title varchar(20))







--1. Return all the fields from all the shippers
select * from Shippers



--2. We only want to see two columns, CategoryName and Description.
select CategoryName, Description from Categories



--3. We’d like to see just the FirstName, LastName, and HireDate of all the employees with the Title of Sales Representative.
select FirstName, LastName, HireDate from Employees where Title = 'Sales Representative'



--4. Now we’d like to see the same columns as above, but only for those employees that both have the title of Sales Representative, and also are in the United States.
select FirstName, LastName, HireDate from Employees where Title = 'Sales Representative' and country = 'United States'



--5. Show all the orders placed by a specific employee. The EmployeeID for this Employee (Steven Buchanan) is 5.
select * from Orders where EmployeeID = 5



--6. In the Suppliers table, show the SupplierID, ContactName, and ContactTitle for those Suppliers whose ContactTitle is not Marketing Manager
select SupplierID, ContactName, ContactTitle from Suppliers where ContactTitle != 'Marketing Manager'



--7. In the products table, we’d like to see the ProductID and ProductName for those products where the ProductName includes the string “queso”.
select ProductID, ProductName from Products where ProductName like '%queso%'



--8. Looking at the Orders table, there’s a field called ShipCountry. Write a query that shows the OrderID, CustomerID, and ShipCountry for the orders where the
--ShipCountry is either France or Belgium.
select OrderID, CustomerID, ShipCountry from Orders ShipCountry in ('France', 'Belgium')
select OrderID, CustomerID, ShipCountry from Orders ShipCountry = 'France' or ShipCountry = 'Belgium'



--9. we want to show all the orders from any Latin American country.
select OrderID, CustomerID, ShipCountry from Orders where ShipCountry in ('Brazil','Mexico','Argentina','Venezuela')



--10. For all the employees in the Employees table, show the FirstName, LastName, Title, and BirthDate. Order the results by BirthDate, so we have the oldest employees first.
select FirstName, LastName, Title, BirthDate from Employees order by Birthdate



--11. Show only the date portion of the BirthDate field.
select FirstName, LastName, Title, DateOnlyBirthDate = convert(date, BirthDate) from Employees order by Birthdate



--12. create a new column called FullName, showing FirstName and LastName joined together in one column, with a space in-between.
select FirstName + ' ' + LastName FullName from Employess




--13. In the OrderDetails table, we have the fields UnitPrice and Quantity. Create a new field, TotalPrice, that multiplies these two together. We’ll ignore the Discount field for now.
select OrderID, ProductID, UnitPrice, Quantity, UnitPrice * Quantity as TotalPrice from OrderDetails order by OrderID, ProductID



--14. How many customers do we have in the Customers table? Show one value only, and don’t rely on getting the recordcount at the end of a resultset.
select count(*) as COUNTING from Customers



--15. Show the date of the first order ever made in the Orders table.
select FirstOrder = min(OrderDate) from Orders



--16. Show a list of countries where the Northwind company has customers.
select Country from Customers group by Country



--17. Show a list of all the different values in the Customers table for ContactTitles. Also include a count for each ContactTitle.
select ContactTitle, count(*) from Customers group by ContactTitle



--18. show, for each product, the associated Supplier. Show the ProductID, ProductName, and the CompanyName of the Supplier. Sort by ProductID.
select p.ProductID, p.ProductName, s.CompanyName from Products p inner join Suppliers s on p.ProductID = s.ProductID order by ProductID


--19. 
select OrderID,OrderDate = convert(date, OrderDate), Shipper = CompanyName from Orders join Shippers on Shippers.ShipperID = Orders.ShipVia
where OrderID < 10300 order by OrderID



--20. 
select CategoryName, TotalProducts = count(*) from Products p Join Categories c on p.CategoryID = c.CategoryID
group by CategoryName order by count(*) desc



--21.
select Country, City, TotalCustomer = count(*) from Customers group by Country, City order by count(*) desc


--22.
select ProductID, UnitsInStock, ReorderLevel from Products where UnitsInStock <= ReorderLevel order by ProductID


--23.
select ProductID, ProductName, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued from Products
where UnitsInStock + UnitsOnOrder <= ReorderLevel and Discontinued = 0 order by ProductID



--24.
select CustomerID, CompanyName, Region from Customers order by
case when Region is null then 1 else 0 end, Region, CustomerID



--25. 
select top 3 ShipCountry, AverageFreight = AVG(freight) from Orders group by ShipCountry order by AverageFreight desc



--26
select top 3 ShipCountry, AverageFreight = avg(freight) from Orders where
OrderDate >= '20150101' and OrderDate < '20160101' group by ShipCountry order by AverageFreight desc




--27.




--28.
select top 3 ShipCountry, AVG(FRIEGHT) from orders where OrderDate >= dateadd(yy, -1, (select max(OrderDate) from Orders))
group by ShipCountry order by count(*) desc




--29.
select e.EmployeeID, e.LastName, o.OrderID, p.ProductName, od.Quantity from Employees e join orders o on o.EmployeeID = e.EmployeeID
join OrderDetails od on o.OrderID = od.OrderID join Products p on p.ProductID = od.ProductID
order by o.OrderID, p.ProductID




--30
select c.CustomerID, o.CustomerID from Customers c left join Orders o where o.CustomerID is null



--31
select c.CustomerID, o.CustomerID from Customers c left join Orders o on o.CustomerID = c.CustomerID and o.EmployeeID = 4
where o.CustomerID is null
















































































































