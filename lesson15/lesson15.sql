--Homework  15
--1
use W3Resource

with cte as (
select *, SUM(goal_score) over (order by match_no) as gls from 
    soccer.match_details
)
select * 
from cte
where gls = 23;



--2   Find 3 successive empty seats
use Chunks
create table #EmptySeats(Number int, Empty varchar(1))
insert into #EmptySeats values (1, 'Y'), (2, 'N'), (3, 'N'), (4, 'Y'), (5, 'Y'), (6, 'Y'), (7, 'N'),
(8, 'Y'), (9, 'Y'), (10, 'Y'), (11, 'N'), (12, '')
select * from #EmptySeats


--first way
with cte as(
select *, lag(empty, 1) over (order by number) as preone, lag(empty, 2) over (order by number) as pretwo,
lead(empty, 1) over (order by number) afterone, lead(empty, 2) over (order by number) aftertwo
from #Emptyseats), cte2 as(
select *, number - row_number() over(order by number) rn from cte
where (empty = 'Y' and preone = 'Y' and pretwo = 'Y') or (empty = 'Y' and preone = 'Y' and afterone = 'Y')
or (empty = 'Y' and afterone = 'Y' and aftertwo = 'Y'))
select string_agg(number, ' - ') as EmptySeats from cte2
group by rn


--second way
with rcte as(
select *, lead(empty) over (order by number) prv, lead(empty,2) over (order by number) nxt from #EmptySeats)
select concat(number, ' - ', number +1, ' - ', number+2)from rcte
where rcte.empty='Y' and rcte.prv='Y' and rcte.nxt='Y'


--third way
with cte as
(select *,empty + '-' + LEAD(empty) over(order by (select null)) + '-' + LEAD(empty,2) over(order by (select null)) as l2,
cast(number as varchar(50)) + '-' 
+ cast(LEAD(number) over(order by (select null)) as varchar(50)) + '-' 
+ cast(LEAD(number,2) over(order by (select null)) as varchar(50)) as l3
from #EmptySeats)
select cte.l3 from cte
where cte.l2 = 'Y-Y-Y'