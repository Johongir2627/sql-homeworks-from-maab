--Lesson 6

--1
select * from Employee.employees



--2
select salary from Employee.employees



--3
select distinct job_name from Employee.employees



--4
select emp_name, format(1.15 * salary, '$ #######'), salary*1.15 as Salary from Employee.employees




--5
select emp_name + ' ' + job_name as [Employee&Job] from Employee.employees



--6
select emp_name+'('+LOWER(job_name)+')' from Employee.employees





--7
select emp_id, emp_name, salary, FORMAT(hire_date, 'MMMM dd, yyyy') from Employee.employees




--8
select len(trim(emp_name)) from Employee.employees




--9
select emp_id, salary, commission from Employee.employees



--10
select distinct dep_id,  job_name from Employee.employees



--11
select * from Employee.employees where dep_id <> 2001
select * from Employee.employees where dep_id not in (2001)



--12
select * from Employee.employees where year(hire_date) <= 1990




--13
select AVG(salary) as avg_sal from Employee.employees where job_name = 'analyst'





--14
select * from Employee.employees  where emp_name = 'Blaze'




--15
select * from Employee.employees where commission > salary




--16
select * from Employee.employees where salary * 1.25 > 3000




--17
select * from Employee.employees where len(emp_name) = 6




--18
select * from Employee.employees where MONTH(hire_date) = 01



--19
select e.emp_name + ' works for ' + m.emp_name from Employee.employees m, Employee.employees e where e.manager_id = m.emp_id




--20
select * from Employee.employees where job_name = 'clerk'




--21
select * from Employee.employees where (YEAR(GETDATE())-YEAR(hire_date)) > 27




--22
select * from Employee.employees where salary < 3500




--23
select emp_name, job_name, salary from Employee.employees where job_name = 'analyst'




--24
select * from Employee.employees where YEAR(hire_date) = 1991



--25
select emp_id, emp_name, hire_date, salary from Employee.employees where hire_date < '1991-04-01'




--26
select emp_name, job_name from Employee.employees where manager_id is null



--27
select * from Employee.employees where hire_date = '1991-05-01'



--28--couldnot solve
select emp_id, emp_name, salary, format(year(getdate())-year(hire_date),'##') + ' years ' + 
									format(month(getdate())-month(hire_date),'##') + ' months ' + 
									format(day(getdate())-day(hire_date),'##') + ' days' 
									experience from Employee.employees where manager_id = 68319



--29
select emp_id, emp_name, salary, format(year(getdate())-year(hire_date),'##') + ' years ' + 
									format(month(getdate())-month(hire_date),'##') + ' months ' + 
									format(day(getdate())-day(hire_date),'##') + ' days' 
									experience from Employee.employees where salary / 30 > 100




--30
select emp_name from Employee.employees where hire_date  > '1991-12-31'  --  '1991-12-31' is 8 years back from '1999-12-31'




--31
select * from Employee.employees where (salary / 2) = 1




--32
select * from Employee.employees where (salary) < 1000 and salary > 100



--33
select * from Employee.employees where month(hire_date) = 4




--34
select * from Employee.employees where DAY(hire_date) < 19




--35
select * from employee.employees where job_name = 'salesman' and extract(month from age(current_date, hire_date)) > 10  


select *, datediff(year, hire_date, getdate())  years_of_experience, datediff(month, hire_date, getdate()) % 12 remaining_months
from employee.employees where job_name = 'salesman' and datediff(month, hire_date, getdate()) % 12 > 10;




--36
select * from Employee.employees where dep_id in (3001, 1001) and year(hire_date) = 1991




--37
select * from Employee.employees where dep_id in (2001, 1001)



--38
select * from Employee.employees where dep_id = 2001 and job_name = 'clerk'




--39
select emp_id, emp_name, salary, job_name from Employee.employees 
where commission is not null and commission < salary and (salary+commission) * 12 < 34000 and job_name = 'salesman' and dep_id = 3001




--40
select * from Employee.employees where job_name in ('clerk', 'manager')




--41
select * from Employee.employees where  month(hire_date) <> 2




--42
select * from Employee.employees where year(hire_date) = 1991




--43
select * from Employee.employees where year(hire_date) = 1991 and month(hire_date) = 06



--44
select * from Employee.employees where salary * 12 between 24000 and 50000




--45
select * from Employee.employees where hire_date in ('1991-05-01', '1991-02-20', '1991-12-03')




--46
select * from Employee.employees where manager_id in (63679, 68319, 66564, 69000)



--47
select * from Employee.employees where hire_date between '1991-07-01' and '1992-07-01'



--48
select * from Employee.employees where hire_date between '1991-01-01' and '1999-12-31'




--49
select * from Employee.employees where dep_id in (1001, 2001)




--50
select * from Employee.employees where month(hire_date) = 02 and salary between 1001 and 2000





--51
select * from Employee.employees where year(hire_date) <> 1991





--52
select e.emp_id, e.emp_name, e.job_name, e.manager_id, e.hire_date, e.salary, e.commission, e.dep_id, d.dep_name from Employee.employees e, employee.department d
WHERE e.dep_id = d.dep_id





--53 ?
select emp_name, job_name, salary * 12 as [Annual Salary], d.dep_id, grade 
	from Employee.employees e, Employee.department d, Employee.salary_grade s 
	where e.dep_id = d.dep_id and e.salary between s.min_salary and s.max_salary and salary * 12 >= 60000 or job_name <> 'analyst'




--54 ?
select e.emp_name, e.job_name, e.manager_id, e.salary, m.emp_name "Manager", m.emp_id, m.salary "Manager_Salary"
FROM employee.employees e, employee.employees m WHERE e.manager_id = m.emp_id AND e.salary > m.salary




--55
select e.emp_name, e.dep_id, e.salary, e.commission from Employee.employees e, Employee.department d 
where e.dep_id = d.dep_id and e.salary between 2000 and 5000 and dep_location = 'perth'





--56
select s.grade, e.emp_name from Employee.employees e, Employee.salary_grade s 
where e.dep_id in (1001, 3001) and hire_date < '1992-12-31' and e.salary between s.min_salary and s.max_salary and s.grade <> 4




--57
select e.emp_id, e.emp_name, e.job_name, e.manager_id, e.hire_date, e.salary, e.dep_id, m.emp_name
from Employee.employees e, Employee.employees m where  e.manager_id = m.emp_id and m.emp_name = 'jonas'





--58
select e.emp_name, s.max_salary as salary from Employee.employees e, Employee.salary_grade s
where emp_name = 'frank' and e.salary between s.min_salary and s.max_salary 




--59
select * from Employee.employees where job_name in ('manager', 'analyst') and salary between 2000 and 5000





--60 ?
select e.emp_id, e.emp_name, e.dep_id, e.salary, d.dep_location  from Employee.employees e, Employee.department d 
where e.dep_id = d.dep_id and d.dep_location in ('perth', 'melbourne') and 
extract (month from age(current_date, hire_date)) > 10





--61
select e.emp_id, e.emp_name, e.dep_id, e.salary, d.dep_location from Employee.employees e, Employee.department d 
where e.dep_id = d.dep_id and year(e.hire_date) = 1991 and d.dep_location in ('sydney', 'melbourne') and e.salary between 2000 and 5000




--62
select e.dep_id, e.emp_id, e.emp_name, e.salary, d.dep_name, d.dep_location, s.grade 
from Employee.employees e, Employee.salary_grade s, Employee.department d
where e.dep_id = d.dep_id and e.salary between s.min_salary and s.max_salary and s.grade in (3, 4, 5)
and (d.dep_name = 'marketing' and d.dep_location in ('melbourne', 'perth'))
and extract(year from age (current_date, e.hire_date)) > 25





--63
select * from Employee.employees e, Employee.employees m 
where e.manager_id = m.emp_id and e.hire_date < m.hire_date




--64
select * from Employee.employees e, Employee.salary_grade s 
where e.salary between s.min_salary and s.max_salary and s.grade = 4 



--65
select e.emp_name from Employee.employees e, Employee.department d 
where e.dep_id = d.dep_id and year(hire_date) > 1991 and d.dep_name in ('production', 'audit')
and e.emp_name not in ('marker', 'adelyn')



--66
select * from Employee.employees order by salary asc




--67
select * from Employee.employees order by dep_id asc, job_name desc



--68
select distinct job_name from Employee.employees order by  job_name desc




--69
select emp_id, emp_name, salary, salary / 300 as Daily_salary, 12 * salary as Annual_salary from Employee.employees 
order by Annual_salary asc



--70
select * from Employee.employees where job_name in ('clerk', 'analyst') order by job_name desc



--71
select dep_location from Employee.employees e, Employee.department d where e.dep_id = d.dep_id and e.emp_name = 'clare'



--72
select * from Employee.employees where hire_date in ('1991-05-01', '1991-12-03', '1990-01-19') order by hire_date asc



--73
select * from Employee.employees where salary < 1000 order by salary asc




--74
select * from Employee.employees order by salary asc




--75
select * from Employee.employees order by job_name asc, emp_id desc




--76
select distinct job_name from Employee.employees where dep_id in (2001, 3001) order by job_name



--77
select * from Employee.employees where job_name not in ('president', 'manager') order by salary asc



--78
select * from Employee.employees where  12 * salary < 25000 order by salary asc




--79
select emp_id, emp_name, 12 * salary annual_salary, salary / 30 daily_salary from Employee.employees 
where job_name = 'salesman' order by annual_salary asc



--80 ?
select emp_id, emp_name, hire_date, getdate(), age(getdate(), hire_date) experience 
from Employee.employees order by experience asc




--81
select * from Employee.employees where hire_date > '1991-06-30' and year(hire_date) = 1991 order by job_name asc




--82
select * from Employee.employees e, Employee.department d 
where e.dep_id = d.dep_id and d.dep_name in ('finance', 'audit') order by e.dep_id asc




--83
select * from Employee.employees e, Employee.salary_grade s where e.salary between s.min_salary and s.max_salary
order by s.grade asc




--84
select e.emp_name, e.job_name, d.dep_name, e.salary, s.grade 
from Employee.employees e, Employee.department d, Employee.salary_grade s 
where e.dep_id = d.dep_id and e.salary between s.min_salary and s.max_salary 
order by d.dep_name asc


--85
select e.emp_name, e.job_name, e.salary, s.grade, d.dep_name
from Employee.employees e, Employee.department d, Employee.salary_grade s 
where e.dep_id = d.dep_id and e.salary between s.min_salary and s.max_salary 
order by salary desc


--86 ?
select e.emp_id, e.emp_name, e.salary, d.dep_name, s.grade, age(getdate(), hire_date) experience, e.salary * 12 Annual_salary
from Employee.employees e, Employee.department d, Employee.salary_grade s 
where e.dep_id = d.dep_id and e.salary between s.min_salary and s.max_salary and e.dep_id in (1001, 2001)




--87
select * from Employee.employees e, Employee.department d where e.dep_id = d.dep_id



--88
select * from Employee.employees e, Employee.employees m where e.manager_id = m.emp_id and e.hire_date > m.hire_date




--89
select emp_id, emp_name, salary, dep_id from Employee.employees where dep_id = 1001 order by salary asc 



--90
select max(salary) max from Employee.employees 



--91
select job_name, avg(salary) avg_s, avg(salary + commission) avg_r from Employee.employees group by job_name



--92
select job_name, sum(salary * 12) total_annual_salary from Employee.employees where year(hire_date) = 1991 group by job_name



--93
select e.emp_id, e.emp_name, e.dep_id, d.dep_location from Employee.employees e, Employee.department d where e.dep_id = d.dep_id



--94
select e.emp_id, e.emp_name, e.dep_id, d.dep_location, d.dep_name from Employee.employees e, Employee.department d 
where e.dep_id = d.dep_id and e.dep_id in (1001, 2001)




--95
select e.emp_id, e.emp_name, e.salary, s.grade from Employee.employees e, Employee.salary_grade s 
where e.salary between s.min_salary and s.max_salary



--96 ?
select e.manager_id, count(*) counting from Employee.employees e, Employee.employees m where e.manager_id = m.emp_id
group by e.manager_id order by e.manager_id asc




--97
select dep_id, job_name, COUNT(*) from Employee.employees group by dep_id, job_name





--98
select dep_id, COUNT(*)  from Employee.employees  group by dep_id having  count(*) >= 2





--99
select s.grade, count(*), max(salary) from Employee.employees e, Employee.salary_grade s 
where e.salary between s.min_salary and s.max_salary group by s.grade





--100
select d.dep_name, s.grade, count(*) from Employee.employees e, Employee.department d, Employee.salary_grade s
where e.dep_id = d.dep_id and e.salary between s.min_salary and s.max_salary and e.job_name = 'salesman'
group by d.dep_name, s.grade
having count(*) >= 2




--101
select dep_id, COUNT(*) from Employee.employees group by dep_id having count(*) <=4



--102
select d.dep_name, COUNT(*) from Employee.employees e, Employee.department d where e.dep_id = d.dep_id
group by d.dep_name having COUNT(*) >= 2



--103
select emp_id, COUNT(*) from Employee.employees group by emp_id




--104
select COUNT(*), AVG(salary), dep_id, job_name from Employee.employees
group by dep_id, job_name



--105
select emp_name from Employee.employees where emp_name like 'A%' and len(emp_name) = 6




--106
select * from Employee.employees where emp_name like '__R%' and len(emp_name) = 6




--107
select * from Employee.employees where emp_name like 'A%N' and len(emp_name) = 6




--108
select * from Employee.employees where datename(month, hire_date) like '_a%'



--109
select * from Employee.employees where emp_name like '%AR%'



--110
select * from Employee.employees where datename(year, hire_date) like '199%'



--111
select emp_id, cast(emp_id as varchar(5)) as formatted_emp_id
from Employee.employees where cast(emp_id as varchar(5)) not like '68%'




--112
select * from Employee.employees where emp_name like '%A%'




--113
select * from Employee.employees where emp_name like '%S' and len(emp_name) = 6




--114
select * from Employee.employees where datename(month, hire_date) like '%a%'




--115
select * from Employee.employees where datename(month, hire_date) like '_a%'