--Homework 16

CREATE TABLE #Consecutives (Id VARCHAR(5), Vals INT)
GO
 
INSERT INTO #Consecutives VALUES
('a', 1),
('a', 0),
('a', 1),
('a', 1),
('a', 1),
('a', 0),
('b', 1),
('b', 1),
('b', 0),
('b', 1),
('b', 0)
GO

select * from #Consecutives


--first way of solving
with cte as(
select id, count(*) + 1 as num from #Consecutives where id = 'a' group by id 
union all
select id, count(*) + 1 as num from #Consecutives where id = 'b' group by id),
cte2 as(
select id, isnull(lag(Vals) over(partition by id order by Vals), Vals) as Vals from #Consecutives)
select c2.id, num, count(Vals) as consecutive from cte2 as c2
join cte as c on c2.id = c.id
where Vals <> 0 group by c2.id, num
order by id



--second way of solving
with cte as(
select *, 
count(id) over (partition by id) + 1 as NextOne,
row_number() over (order by id) as rn from #Consecutives),
cte2 as(
select *, rn - lag(rn) over (order by (select null)) as prrn from cte
where vals = 1)
select id, nextone, count(id) + 1 from cte2
where prrn = 1
group by id, nextone
order by id


--third way of solving
with cte as
(select *,
count(id) over(partition by id)+1 as Nextonorder,
ROw_number() over(order by id) as rownumber
from #Consecutives),
abc as (select *,cte.rownumber - lag(cte.rownumber) over(order by (select null)) as asd from cte
where cte.vals = 1)
select abc.id,abc.nextonorder, count(abc.id)+1 as maxnum from abc
where asd = 1
group by abc.id,abc.nextonorder
order by abc.id