create database Homework1_1
use Homework1_1

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

create login JohongirH1_1 with password = 'JohongirH1'
create user Johongir1_1 for login JohongirH1_1
create role UserRole1_1
alter role UserRole1_1 add member Johongir1_1
grant select, update on Homework1_1.dbo.Table1 to UserRole1_1
grant select, update on Homework1_1.dbo.Table3 to UserRole1_1
grant select, update on Homework1_1.dbo.Table5 to UserRole1_1
grant select, update on Homework1_1.dbo.Table6 to UserRole1_1
grant select, update on Homework1_1.dbo.Table10 to UserRole1_1


