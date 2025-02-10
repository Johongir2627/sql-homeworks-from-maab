use W3Resource


--1.
select * from Inventory.Orders where salesman_id =
(select salesman_id from Inventory.Salesman where name = 'Paul Adam')


--2.
select * from Inventory.Orders where salesman_id =
(select salesman_id from Inventory.Salesman where city = 'london')


--3.
select * from Inventory.Orders where salesman_id =
(select distinct salesman_id from Inventory.Orders where customer_id = 3007)


--4.
select * from Inventory.Orders where purch_amt >
(select avg(purch_amt) from Inventory.Orders 
where ord_date = '2012-10-10')


--5
select * from Inventory.Orders where salesman_id in
(select distinct salesman_id from Inventory.Salesman where city = 'New York')


--6
select commission from Inventory.Salesman where salesman_id in 
(select salesman_id from Inventory.Customer where city = 'Paris')


--7
select * from Inventory.Customer where 
customer_id =  
(select salesman_id - 2001 from Inventory.Salesman where name = 'Mc Lyon')


--8
select grade, count(*) from Inventory.Customer 
group by grade having grade > 
(select avg(grade) from Inventory.Customer where city = 'New york')


--9
select * from Inventory.Orders where salesman_id in
(select salesman_id from Inventory.Salesman where commission in
(select max(commission) from Inventory.Salesman))


--10
select * from Inventory.Orders where customer_id in
(select customer_id from Inventory.Customer where ord_date = '2012-08-17')


--11
select salesman_id, name from Inventory.Salesman where 1 < 
(select count(*) from Inventory.Customer 
where salesman_id = Inventory.Salesman.salesman_id)


--12
select * from Inventory.Orders where purch_amt > 
(select avg(purch_amt) from Inventory.Orders 
where Inventory.Orders.customer_id = Inventory.Orders.customer_id)


--13
select * from Inventory.Orders where purch_amt >= 
(select avg(purch_amt) from Inventory.orders)


--14
select ord_date, sum(purch_amt) from Inventory.Orders a group by ord_date
having max(purch_amt) + 1000 < (select sum(purch_amt) 
from Inventory.Orders b where a.ord_date = b.ord_date)


--15
select * from Inventory.customer where exists
(select * from Inventory.Customer where city = 'London')


--16
select * from Inventory.Salesman where salesman_id in 
(select distinct salesman_id from Inventory.Customer a where exists (
select * from Inventory.Customer b where b.salesman_id = a.salesman_id and
b.cust_name <> a.cust_name
))


--17
select * from Inventory.Salesman where salesman_id in 
(select distinct salesman_id from Inventory.Customer a where not exists (
select * from Inventory.Customer b where b.salesman_id = a.salesman_id and
b.cust_name <> a.cust_name
))


--18
select * from Inventory.Salesman a where exists (
select * from inventory.customer b 
where a.salesman_id = b.salesman_id
and 1 < (select count(*) from Inventory.orders 
where Inventory.Orders.customer_id = b.customer_id)
)



--19
select * from Inventory.Salesman where city = any(select city from Inventory.Customer)


--20
select * from Inventory.Salesman where city in (select city from Inventory.Customer)


--21
select * from Inventory.Salesman s where exists 
(select * from Inventory.Customer b where s.name < b.cust_name)



--22
select * from Inventory.Customer where grade > any 
(select grade from Inventory.Customer where city < 'New york')


--23
select * from Inventory.orders where purch_amt > any 
(select purch_amt from Inventory.Orders where ord_date = '2012-09-10')



--24
select * from Inventory.orders where purch_amt < any 
(select purch_amt from Inventory.Orders a, Inventory.Customer b where a.customer_id = b.customer_id
and b.city = 'london')


--25
select * from Inventory.Orders where purch_amt < 
(select max(purch_amt) from Inventory.Orders a, Inventory.Customer b
where a.customer_id = b.customer_id and b.city = 'london')


--26
select * from Inventory.Customer where grade > all (select grade from Inventory.Customer where city = 'new york')



--27




--28
select * from Inventory.Customer where grade <> all 
(select grade from Inventory.Customer where city = 'london' and not grade is null)



--29
select * from Inventory.Customer where grade not in 
(select grade from Inventory.Customer where city = 'paris')


--30
select * from Inventory.Customer where not grade = any (select grade from Inventory.Customer where city = 'dallas')


--31
select avg(pro_price) as 'AP', company_mast.com_name as 'Company'
from item_mast, company_mast where item_mast.pro_com = company_masr.com_id group by company_mast.com_name


--32
SELECT AVG(pro_price) AS "Average Price", 
   company_mast.com_name AS "Company"
FROM item_mast, company_mast
WHERE item_mast.pro_com = company_mast.com_id
GROUP BY company_mast.com_name
HAVING AVG(pro_price) >= 350


--33
SELECT P.pro_name AS "Product Name", 
       P.pro_price AS "Price", 
       C.com_name AS "Company"
FROM item_mast P, company_mast C
WHERE P.pro_com = C.com_id
AND P.pro_price =
     (
       SELECT MAX(P.pro_price)
         FROM item_mast P
         WHERE P.pro_com = C.com_id
     )



--34
select * from emp_details where emp_lname in ('gabriel', 'dosio')

--35
SELECT * 
FROM emp_details
WHERE emp_dept IN (89, 63)

--36
SELECT emp_fname, emp_lname FROM emp_details WHERE emp_dept IN
(SELECT dpt_code 
     FROM emp_department 
       WHERE dpt_allotment > 50000)


--37
SELECT *
FROM emp_department
WHERE dpt_allotment >
  (
    SELECT AVG(dpt_allotment)
    FROM emp_department
  )


--38
SELECT dpt_name FROM emp_department
  WHERE dpt_code IN
  (
    SELECT emp_dept FROM emp_details GROUP BY emp_dept HAVING COUNT(*) > 2
  )

--39
SELECT emp_fname, emp_lname 
FROM emp_details 
WHERE emp_dept IN (
  SELECT dpt_code
  FROM emp_department 
  WHERE dpt_allotment = (
    SELECT MIN(dpt_allotment)
    FROM emp_department 
    WHERE dpt_allotment > (
      SELECT MIN(dpt_allotment) 
      FROM emp_department 
    )
  )
)






