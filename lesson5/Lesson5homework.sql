
--Lesson 5
--Hometask 1
--Return people who get the 2nd highest salaries in each departments
use W3Resource

select * from hr.Employees order by department_id, salary desc


WITH RankedSalaries AS (
    SELECT
        salary,
        ROW_NUMBER() OVER (PARTITION BY Department_ID ORDER BY Salary DESC) AS SalaryRank
    FROM hr.Employees
)
SELECT *
FROM RankedSalaries
WHERE SalaryRank = 2




--Hometask 2

1)		select sum(purch_amt) from Inventory.Orders
2)		select AVG(purch_amt) from Inventory.Orders
3)		select count(distinct salesman_id) from Inventory.Orders
4)		select count(*) from Inventory.Customer
5)		select count (all grade) from Inventory.Customer
6)		select MAX(purch_amt) from Inventory.Orders
7)		select min(purch_amt) from Inventory.Orders
8)		select city, MAX(grade) from inventory.Customer group by city
9)		select customer_id, MAX(purch_amt) from inventory.Orders group by customer_id
10		select customer_id, ord_date, MAX(purch_amt) from inventory.Orders group by customer_id, ord_date
11)		select salesman_id, MAX(purch_amt) from Inventory.Orders where ord_date = '2012-08-17' group by salesman_id
12)		select customer_id,ord_date,MAX(purch_amt) from Inventory.Orders group by customer_id,ord_date having MAX(purch_amt)>2000.00
13)		select customer_id,ord_date,MAX(purch_amt) from Inventory.Orders group by customer_id,ord_date having MAX(purch_amt) BETWEEN 2000 AND 6000
14)		select customer_id,MAX(purch_amt) from Inventory.Orders where customer_id BETWEEN 3002 and 3007 group by customer_id
15)		select customer_id,MAX(purch_amt) from Inventory.Orders where customer_id BETWEEN 3002 and 3007 group by customer_id having MAX(purch_amt)>1000
16)		select customer_id,MAX(purch_amt) from Inventory.Orders where customer_id BETWEEN 3002 and 3007 group by customer_id having MAX(purch_amt)>1000
17)		select salesman_id,MAX(purch_amt) from Inventory.Orders group by salesman_id having salesman_id BETWEEN 5003 AND 5008
18)		select COUNT(*) from Inventory.Orders where ord_date='2012-08-17'
19)		select COUNT(*) from Inventory.Salesman where city IS NOT NULL
20)		select ord_date,salesman_id,COUNT(*) from Inventory.Orders group by ord_date,salesman_id
21)		select AVG(pro_price) as "Average Price" from item_mast
22)		select AVG(pro_price) as "Average Price", pro_com as "Company ID" from item_mast group by pro_com
23)		select AVG(pro_price) as "Average Price", pro_com as "Company ID" from item_mast group by pro_com
24)		select SUM(dpt_allotment) from emp_department
25)		select emp_dept, COUNT(*) from emp_details group by emp_dept