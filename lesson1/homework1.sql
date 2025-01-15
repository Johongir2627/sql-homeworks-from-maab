create database Homework1
use Homework1

create table Table1 (id int, FName varchar(20))
create table Table2 (id int, FName varchar(20))
create table Table3 (id int, FName varchar(20))
create table Table4 (id int, FName varchar(20))
create table Table5 (id int, FName varchar(20))
create table Table6 (id int, FName varchar(20))
create table Table7 (id int, FName varchar(20))
create table Table8 (id int, FName varchar(20))
create table Table9 (id int, FName varchar(20))
create table Table10 (id int, FName varchar(20))

create login JohongirH1 with password = 'JohongirH1'
create user Johongir1 for login JohongirH1
create role UserRole
alter role UserRole add member Johongir1
grant select, update on Homework1.dbo.Table1 to UserRole
grant select, update on Homework1.dbo.Table3 to UserRole
grant select, update on Homework1.dbo.Table5 to UserRole
grant select, update on Homework1.dbo.Table6 to UserRole
grant select, update on Homework1.dbo.Table10 to UserRole


