--letcode: https://leetcode.com/studyplan/top-sql-50/


--Select 

--Recyclable and Low Fat Products
select product_id from products where low_fats ='y' and recyclable ='y'

--Find Customer Referee
select name from customer where referee_id <> 2

--Big Countries
select * from world where area >= 3000000 or population >= 25000000

--Article Views I
select distinct author_id as id from Views where author_id = viewer_id order by id

--Invalid Tweets
select tweet_id from tweets where LEN(content) >15







--Basic Joins

--Replace Employee ID With The Unique Identifier
select unique_id, name from employees as emp 
left join employeeuni as u on u.id = emp.id

--Product Sales Analysis I
select pr.product_name, sa.year, sa.price
from product pr join sales sa on pr.product_id = sa.product_id

--Customer Who Visited but Did Not Make Any Transactions
select v.customer_id, COUNT(*) as count_no_trans
from Visits v left join Transactions t on v.visit_id=t.visit_id
where t.visit_id is null group by v.customer_id

--Rising Temperature
select w2.id from Weather w1 left join Weather w2 on w1.Id +1 = w2.Id
where w1.Temperature < w2.Temperature

--Average Time of Process per Machine
select machine_id, 
round(sum(if(activity_type = 'start', -1, 1) * timestamp)/count(distinct process_id), 3) as pro_time
from activity group by machine_id

--Employee Bonus
select e.name, b.bonus from employee e left join bonus b on e.empid = b.empid
where b.bonus <1000 or bonus is null

--Students and Examinations
select st.student_id, st.student_name, s.subject_name, count(e.subject_name) as attended_exams
from students st cross join subjects s left join Examinations e
on e.student_id = st.student_id and e.subject_name = s.subject_name
group by st.student_id, s.subject_name, st.student_name
order by st.student_id, s.subject_name

--Managers with at Least 5 Direct Reports
select m.name from employee e join employee m where e.managerid=m.id
group by e.managerid having count(*) >= 5

--Confirmation Rate
select s.user_id, round(ifnull(avg(action = 'confirmed'), 0),2) as confirmation_rate
from Signups s left join Confirmations b on s.user_id = b.user_id group by s.user_id






--Basic Aggregate Functions

--Not Boring Movies
select * from cinema where (id % 2 = 1) and (description != "boring") order by rating desc

--Average Selling Price
select p.product_id, ROUND(sum(price*units)/sum(units),2) as average_price from Prices p join UnitsSold u
on p.product_id = u.product_id where u.purchase_date between p.start_date and p.end_date group by p.product_id

--Project Employees I
select p.project_id, round(avg(cast(e.experience_years as float)), 2) as average_years from project p
left join employee e on p.employee_id = e.employee_id group by p.project_id order by project_id

--Percentage of Users Attended a Contest
select r.contest_id , round(count( r.contest_id)/(select count(user_id) from Users) *100,2) as percentage 
from Register r join Users u on r.user_id=u.user_id group by contest_id order by percentage desc , contest_id asc

--Queries Quality and Percentage
select query_name, ROUND(AVG(rating/position), 2) as quality,
ROUND(100.0*sum(if(rating<3, 1,0))/count(1),2) as poor_query_percentage
from Queries group by query_name order by 2 desc

--Monthly Transactions I
select date_format(trans_date, '%Y-%m') as month, country, count(trans_date) as trans_count, 
sum(case when state='approved' then 1 else 0 end) as approved_count, 
sum(amount) as trans_total_amount, 
sum(case when state='approved' then amount else 0 end) as approved_total_amount
from Transactions group by month, country

--Immediate Food Delivery II
select (round(sum(if(order_date=customer_pref_delivery_date, 1, 0)) / count(*) , 4) * 100) as immediate_percentage
from Delivery where (customer_id,order_date) in (select customer_id, min(order_date) from delivery group by customer_id)

--Game Play Analysis IV
select round(sum(case when temp.min_date+1=a.event_date then 1 else 0 end)/count(distinct temp.player_id), 2) as fraction
from (select player_id, min(event_date) as min_date from activity group by player_id) as temp
join activity a on temp.player_id = a.player_id







--Sorting and Grouping

--Number of Unique Subjects Taught by Each Teacher
select teacher_id, count(distinct subject_id) as cnt from Teacher group by teacher_id

--User Activity for the Past 30 Days I
select activity_date as day, count(distinct user_id) as active_users from Activity
where datediff('2019-07-27',activity_date)<30 and activity_date <= '2019-07-27' 
group by activity_date

--Product Sales Analysis III
select product_id, year as first_year, quantity,price from Sales
where (product_id,year) in (select product_id, min(year) from Sales group by product_id)

--Classes More Than 5 Students
select class from Courses group by class having count(student) >= 5

--Find Followers Count
select user_id,count(follower_id) as followers_count from followers
group by user_id order by user_id

--Biggest Single Number
select max(num) as num from MyNumbers where num in(
select num from myNumbers group by num having count(*) = 1)

--Customers Who Bought All Products
select c.customer_id from Customer c group by c.customer_id
having count(distinct product_key) = (select count(*) from Product)






--Advanced Select and Joins

--The Number of Employees Which Report to Each Employee
select e1.employee_id, e1.name, count(e2.employee_id) as reports_count, round(avg(e2.age)) as average_age
from Employees e1, Employees e2 where e1.employee_id = e2.reports_to group by 1
having reports_count>0 order by 1

--Primary Department for Each Employee
select distinct e1.employee_id,e1.department_id from employee e1 left join employee e2 
on e1.department_id<>e2.department_id and e1.employee_id=e2.employee_id
where e2.department_id is null or e1.primary_flag='Y'

--Triangle Judgement
select x,y,z, if(x+y>z and y+z>x and x+z>y, 'Yes', 'No') as triangle from triangle

--Consecutive Numbers
select distinct l1.num as ConsecutiveNums from logs l1,logs l2,logs l3
where l1.id = l2.id+1 and l2.Id=l3.Id+1 and l1.Num=l2.Num and l2.Num=l3.Num

--Product Price at a Given Date
select distinct product_id, new_price as price from Products 
where (product_id, change_date) in (select product_id, max(change_date) 
from Products where change_date <= '2019-08-16' group by product_id)
union
select product_id, 10 as price from Products group by product_id
having min(change_date) > '2019-08-16'

--Last Person to Fit in the Bus
select person_name from (select person_name,weight,sum(weight) over (order by turn) as weight_total
from queue) as total where weight_total<=1000 order by weight_total desc limit 1

--Count Salary Categories
select "Low Salary" as category, sum(if(income<20000,1,0)) as accounts_count from Accounts
union
select "Average Salary" as category, sum(if(income>=20000 and income<=50000,1,0)) as accounts_count from Accounts
union
select "High Salary" as category, sum(if(income>50000,1,0)) as accounts_count from Accounts







--Subqueries

--Employees Whose Manager Left the Company
select employee_id from Employees as a where manager_id not in 
(select employee_id from employees) and salary < 30000 order by employee_id asc

--Exchange Seats
select case when id%2=0 then id-1
when (id%2!=0 AND id=(select max(id) from Seat)) then id
when id%2!=0 then id+1 end as id, student from Seat order by id

--Movie Rating
(select u.name as results from Users u join MovieRating m
on u.user_id = m.user_id group by u.user_id order by count(m.movie_id) desc, u.name asc limit 1)
union all
(select Movies.title as results from Movies join MovieRating m
on Movies.movie_id = m.movie_id where m.created_at between '2020-02-01' and '2020-02-29'
group by Movies.movie_id order by abg(M.rating) desc, Movies.title asc limit 1)

--Restaurant Growth
with cte as (
select *,
sum(sum_amt) over(order by visited_on rows between 6 preceding and current row) moving_sum,
round(avg(sum_amt) over(order by visited_on rows between 6 preceding and current row), 2) moving_avg,
date_sub(visited_on, interval 6 day) pre_6_day,
datediff(visited_on, (select min(visited_on) from customer)) diff_date
from (select visited_on, sum(amount) sum_amt from customer group by visited_on ) tab)
select visited_on, moving_sum amount, moving_avg average_amount
from cte where datediff(visited_on, (select min(visited_on) from cte)) >= 6

--Friend Requests II: Who Has the Most Friends
with cte as(
select requester_id , accepter_id from RequestAccepted
union all
select accepter_id , requester_id from RequestAccepted)
select requester_id id, count(accepter_id) num from cte group by 1 order by 2 desc limit 1

--Investments in 2016
select round(sum(tiv_2016), 2) tiv_2016 from insurance where tiv_2015 in (
select tiv_2015 from insurance group by tiv_2015 having count(tiv_2015)>1)
and (lat, lon) in (select lat, lon from insurance group by lat + lon having count(lat + lon)=1)

--Department Top Three Salaries
select d.Name as Department, e.Name as Employee, e.Salary 
from Department d, Employee e, Employee e2 where d.id = e.DepartmentId and e.DepartmentId = e2.DepartmentId 
and e.Salary <= e2.Salary group by d.id, e.Name having count(distinct e2.Salary) <= 3
order by d.Name, e.Salary desc








--Advanced String Functions / Regex / Clause

--Fix Names in a Table
select user_id, concat(upper(left(name,1)), lower(right(name,length(name)-1))) as name from users order by user_id

--Patients With a Condition
select patient_id, patient_name, conditions from patients 
where conditions like 'diab1%' or conditions like '% diab1%'

--Delete Duplicate Emails
delete tb1 from person tb1 join person tb2 on tb1.email = tb2.email where tb1.id > tb2.id

--Second Highest Salary
select max(salary) as secondhighestsalary from employee where salary <> (select max(salary) from employee)

--Group Sold Products By The Date
select sell_date, count(distinct product) as num_sold, group_concat(distinct product) as products 
from activities group by sell_date

--List the Products Ordered in a Period
select p.product_name, sum(o.unit) as unit from orders as o left join products as p 
on o.product_id = p.product_id where date_format(o.order_date,'%y-%m') ='2020-02' group by o.product_id having unit >=100

--Find Users With Valid E-Mails	
select user_id, name, mail from users where regexp_like (mail,'^[a-z]+[0-9a-zA-Z_.-]*@leetcode[.]{1}com$')