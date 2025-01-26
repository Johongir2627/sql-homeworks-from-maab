--Lesson7 W3Schools Joins


--1
select s.name, c.cust_name, s.city from Inventory.Salesman s join Inventory.Customer c on s.city = c.city




--2
select o.ord_no, o.purch_amt, c.cust_name, c.city from Inventory.Customer c right join Inventory.Orders o on c.customer_id = o.customer_id
where o.purch_amt between 500 and 2000



--3
select c.cust_name, c.city, s.name, s.commission from Inventory.Customer c inner join Inventory.Salesman s on c.salesman_id = s.salesman_id



--4
select c.cust_name, c.city, s.salesman_id, s.commission from Inventory.Customer c inner join Inventory.Salesman s on c.salesman_id = s.salesman_id
where commission > 0.12



--5
select c.cust_name, c.city, s.name, s.city, s.commission from Inventory.Customer c inner join Inventory.Salesman s on c.salesman_id = s.salesman_id
where commission > 0.12 and c.city != s.city



--6
select a.ord_no, a.ord_date, a.purch_amt, b.cust_name, b.grade, c.name, c.commission 
from inventory.orders a INNER JOIN inventory.customer b on a.customer_id = b.customer_id INNER JOIN inventory.salesman c 
on a.salesman_id = c.salesman_id



--7  ? natural join didn't work
--select * from Inventory.Orders NATURAL JOIN Inventory.Customer NATURAL JOIN inventory.salesman
select * from Inventory.Orders o INNER JOIN Inventory.Customer c ON o.customer_id = c.customer_id
INNER JOIN Inventory.Salesman s ON o.salesman_id = s.salesman_id



--8
select c.cust_name, c.city, c.grade, s.name, s.city from Inventory.customer c inner join Inventory.Salesman s on c.salesman_id = s.salesman_id 
order by c.customer_id asc



--9
select c.cust_name, c.city, c.grade, s.name, s.city from Inventory.customer c inner join Inventory.Salesman s on c.salesman_id = s.salesman_id 
where c.grade < 300 order by c.customer_id asc 



--10
select c.cust_name, c.city, o.ord_no, o.ord_date from Inventory.Orders o inner join Inventory.Customer c 
on o.customer_id = c.customer_id order by o.ord_date asc


--11
select c.cust_name, c.city, o.ord_no, o.ord_date, o.purch_amt, s.name, s.commission 
from Inventory.Customer c left outer join Inventory.Orders o on c.customer_id = o.customer_id
left outer join Inventory.Salesman s on o.salesman_id = s.salesman_id


--12
select * from Inventory.Customer c right outer join Inventory.Salesman s on c.salesman_id = s.salesman_id order by s.name asc


--13
select c.cust_name, c.city, c.grade, o.ord_no, o.ord_date, o.purch_amt 
from Inventory.Customer c right outer join Inventory.Salesman s on c.salesman_id = s.salesman_id 
right outer join Inventory.Orders o on c.customer_id = o.customer_id


--14
select c.cust_name, c.city, c.grade, o.ord_no, o.ord_date, o.purch_amt 
from Inventory.Customer c right outer join Inventory.Salesman s on s.salesman_id = c.salesman_id 
left outer join Inventory.Orders o on c.customer_id = o.customer_id
where c.grade is not null and o.purch_amt >= 2000




--15
select c.cust_name, c.city, o.ord_no, o.ord_date, o.purch_amt from Inventory.Customer c left outer join Inventory.Orders o
on c.customer_id = o.customer_id



--16
select c.cust_name, c.city, o.ord_no, o.ord_date, o.purch_amt from Inventory.Customer c full outer join Inventory.Orders o
on c.customer_id = o.customer_id where c.grade is not null



--17
select * from Inventory.Salesman cross join Inventory.Customer

select * from Inventory.Salesman
select * from Inventory.Customer





--18
select * from Inventory.Customer c cross join Inventory.Salesman s where c.city is not null




--19
select * from Inventory.Salesman s cross join Inventory.Customer c where s.city is not null and c.grade is not null



--20
select * from Inventory.Salesman s cross join Inventory.Customer c where s.city is not null and c.grade is not null and s.city <> c.city


--21
select * from item_mast inner join company_mast on item_mast.pro_com = company_mast.com_id



--22
select item_mast.pro_name, pro_price, company_mast.com_name from item_mast inner join company_mast
on item_mast.pro_com = company_mast.com_id


--23
select avg(pro_price), company_mast.com_name from item_mast  inner join company_mast on item_mast.pro_com = company_mast.com_id
group by company_mast.com_name



--24
select avg(pro_price), company_mast.com_name from item_mast inner join company_mast on item_mast.pro_com = company_mast.com_id
group by company_mast.com_name having avg(pro_price) >= 350




--25
select A.pro_name, A.pro_price, F.com_name from item_mast A inner join company_mast F on A.pro_com = F.com_id
and A.pro_price = (select max(A.pro_price) from item_mast A where A.pro_com = F.com_id)


--26
SELECT emp_idno, A.emp_fname AS "First Name", emp_lname AS "Last Name", B.dpt_name AS "Department", emp_dept, dpt_code, dpt_allotment
FROM emp_details A INNER JOIN emp_department B ON A.emp_dept = B.dpt_code


--27
SELECT emp_details.emp_fname AS "First Name", emp_lname AS "Last Name", emp_department.dpt_name AS "Department", dpt_allotment AS "Amount Allotted"
FROM emp_details INNER JOIN emp_department ON emp_details.emp_dept = emp_department.dpt_code



--28
SELECT emp_details.emp_fname AS "First Name", emp_lname AS "Last Name" FROM emp_details INNER JOIN emp_department
ON emp_details.emp_dept = emp_department.dpt_code AND emp_department.dpt_allotment > 50000




--29
SELECT emp_department.dpt_name FROM emp_details  INNER JOIN emp_department ON emp_dept = dpt_code
GROUP BY emp_department.dpt_name HAVING COUNT(*) > 2
