--Lesson 14
--Homework for recursive cte. Find the hierarchial level of people

create table #PostDef(postid int, definition varchar(25))
insert into #PostDef values (0, 'Director'), (1, 'Deputy Director'), (2, 'Executive Director'), (3, 'Department head'), 
              (4, 'Manager'), (5, 'Senior officer'), (6, 'Junior Officer'), (7, 'Intern')

create table #Hierarchy(id int, name varchar(100), manager_id int, manager varchar(100))
insert into #Hierarchy values 
(150, 'John Ryden', 111, 'Jack Tarkowski'),
(165, 'Sara Miller', 111, 'Jack Tarkowski'), 
(180, 'Rebecca Carson', 211, 'Thomas Kim'), 
(107, 'Sean Sullivan', 180, 'Rebecca Carson'), 
(142, 'Floyd Kan', 122, 'Alex Pereira'), 
(122, 'Alex Pereira', 107, 'Sean Sullivan'), 
(111, 'Jack Tarkowski', 107, 'Sean Sullivan'), 
(211, 'Thomas Kim', 191, 'Nicolas Jackson'), 
(177, 'Michael Rim', Null, Null), 
(191, 'Nicolas Jackson', 177, 'Michael Rim')


select * from #postdef
;
with cte as(
select *, 0 as strt from #Hierarchy where manager_id is null
union all
select h.*, strt+1 from #Hierarchy h join cte on h.manager_id = cte.id)
select id, name, definition from cte join #postdef on cte.strt = #postdef.postid




--1.	
use W3Resource
select * from Movies.Actor where act_id in (
select act_id from Movies.Movie_cast where mov_id in (
select mov_id from Movies.Movie where mov_title='Annie Hall'))




--2.
select dir_fname, dir_lname from  Movies.director where dir_id in (
select dir_id from movies.movie_direction where mov_id in (
select mov_id from movies.movie_cast where role = any (
select role from movies.movie_cast where mov_id in (
select  mov_id from movies.movie where mov_title='Eyes Wide Shut'))))



--3.
select mov_title, mov_year, mov_time, mov_dt_rel as Date_of_Release, mov_rel_country as Releasing_Country
from movies.movie where mov_rel_country not in ('UK')





--4.
select mov_title, mov_year, mov_dt_rel, dir_fname, dir_lname, act_fname, act_lname
from movies.movie a, movies.movie_direction b, movies.director c, movies.rating d, movies.reviewer e, movies.actor f, movies.movie_cast g
where a.mov_id=b.mov_id and b.dir_id=c.dir_id and a.mov_id=d.mov_id and d.rev_id=e.rev_id and a.mov_id=g.mov_id and g.act_id=f.act_id and e.rev_name is null






--5.
select mov_title from movies.movie where mov_id=(
select mov_id from movies.movie_direction where dir_id=(
select dir_id from movies.director where dir_fname='Woody' and dir_lname='Allen'))






--6.
select distinct mov_year from movies.movie where mov_id in (
select mov_id from movies.rating where rev_stars > 3) order by mov_year;






--7.
select distinct mov_title from movies.movie where mov_id in (
select mov_id from movies.movie where mov_id not in (
select mov_id from movies.Rating))






--8.
select distinct rev_name from movies.reviewer where rev_id in (
select rev_id from movies.rating where rev_stars is null)






--9.
select rev_name, mov_title, rev_stars  from movies.reviewer, movies.rating, movies.movie where reviewer.rev_id = rating.rev_id 
and movie.mov_id = rating.mov_id and reviewer.rev_name is not null and rating.rev_stars is not null
order by rev_name, mov_title, rev_stars





--10.
select rev_name, mov_title from movies.reviewer, movies.movie, movies.rating, movies.rating r2
where rating.mov_id = movie.mov_id and reviewer.rev_id = rating.rev_ID and rating.rev_id = r2.rev_id 
group by rev_name, mov_title having count(*) > 1





--11.
select mov_title, MAX(rev_stars) from movies.movie, movies.rating where movie.mov_id = rating.mov_id 
and rating.rev_stars is not null group by mov_title order by mov_title





--12.
select distinct reviewer.rev_name from movies.reviewer, movies.rating, movies.movie
where reviewer.rev_id = rating.rev_id and movie.mov_id = rating.mov_id and movie.mov_title = 'American Beauty'





--13
select movie.mov_title from movies.movie where movie.mov_id in (
select mov_id from movies.rating where rev_id not in (
select rev_id from movies.reviewer where rev_name='Paul Monks'))





--14.
select reviewer.rev_name, movie.mov_title, rating.rev_stars from movies.reviewer, movies.movie, movies.rating 
where rating.rev_stars = (
select MIN(rating.rev_stars) from movies.rating) and rating.rev_id = reviewer.rev_id and rating.mov_id = movie.mov_id





--15.
select mov_title from movies.movie where mov_id in (
select mov_id from movies.movie_direction where dir_id in (
select dir_id from movies.director where dir_fname = 'James' and dir_lname='Cameron'))





--16.
select mov_title from movies.movie where mov_id in (
select mov_id from movies.movie_cast where act_id in (
select act_id from movies.movie_cast group by act_id having count(act_id) > 1 ))

