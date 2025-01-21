--Lesson3

--Homework1

create table iam_policies(db_id int primary key, id varchar(50), name varchar(50), type varchar(50))


create table iam_policy_members (member_id int, policy_id int foreign key references iam_policies(db_id))


create table iam_members (db_id int primary key, name varchar(50))


alter table iam_policy_members add constraint FK_IamMembers foreign key(member_id) references iam_members(db_id)


alter table iam_policy_members add constraint PK_Anything primary key(member_id, policy_id)


alter table iam_policy_members alter column member_id int not null


alter table iam_policy_members alter column policy_id int not null



create table iam_roles(db_id int primary key, id varchar(50), name varchar(50), type varchar(50), actions text)



create table iam_statements(db_id int primary key, effect varchar(50), actions text, resources text, 
policy_id int foreign key references iam_policies(db_id), role_id int foreign key references iam_roles(db_id))


create table iam_projects (db_id int primary key, id nvarchar(50), name varchar(50), type text)


create table iam_role_projects(role_id int foreign key references iam_roles(db_id),
project_id int foreign key references iam_projects(db_id), primary key(role_id, project_id))



create table iam_project_rules(db_id int primary key, id text, 
name text, type text, project_id int foreign key references iam_projects(db_id))



create table staged_project_rules(db_id int primary key, id text, name text,
type text, deleted bit, project_id int foreign key references iam_projects(db_id))



create table iam_staged_rule_conditions(db_id int primary key, rule_db_id int foreign key references iam_staged_rule_conditions(db_id),
value text, attribute text, operator text)



alter table iam_staged_rule_conditions drop constraint FK__iam_stage__rule___412EB0B6



alter table iam_staged_rule_conditions
add constraint FK_RuleConditions foreign key(rule_db_id) references staged_project_rules(db_id)



create table iam_rule_conditions (db_id int primary key, value text, attribute varchar(100), operator varchar(100),
rule_db_id int foreign key references iam_project_rules(db_id))



create table iam_statement_projects(project_id int foreign key references iam_projects(db_id),
statement_id int foreign key references iam_statements(db_id), primary key (project_id, statement_id))



create table iam_policy_projects(policy_id int foreign key references iam_policies(db_id),
project_id int foreign key references iam_projects(db_id), primary key (policy_id, project_id))



create table iam_projects_graveyard(db_id int primary key, id varchar(50))



--Homework2
create table Personaddress(fullname varchar(50), address varchar(50) default 'Tashkent')

insert into Personaddress values ('Son Heung', 'Taegu')
insert into Personaddress values ('Luiz Felipe', 'Brazilia')
insert into Personaddress values ('Lucas Paqueta', '')



create trigger ForPersonAddress on personAddress
after insert
as
begin
update Personaddress
set address = 'Tashkent'
where address is null or address = ''
end

insert into Personaddress values ('Justin Cluivert', null)
insert into Personaddress values ('Max Holloway', '   ')

select * from Personaddress