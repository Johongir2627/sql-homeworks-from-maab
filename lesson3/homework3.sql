--Homework 3

create database H3
use H3

create table iam_members(db_id int primary key, name text)
create table iam_policies(db_id int primary key, id int, name text, type text)
create table iam_policy_members (member_id int foreign key references iam_members(db_id), policy_id int foreign key references iam_policies(db_id))
create table iam_roles(db_id int primary key, id int, name text, type text, actions text)
create table iam_projects(db_id int primary key, id int, name text, type text)
create table iam_statements(db_id int primary key, effect text, action text, resourses text, policy_id int foreign key references iam_policies(db_id), role_id int foreign key references iam_roles(db_id))
create table iam_role_projects (role_id int foreign key references iam_roles(db_id), project_id int foreign key references iam_projects(db_id))
create table iam_statement_projects(project_id int foreign key references iam_projects(db_id), statement_id int foreign key references iam_statements(db_id))
create table iam_policy_projects (policy_id int foreign key references iam_policies(db_id), project_id int foreign key references iam_projects(db_id))
create table iam_staged_project_roles(db_id int primary key, id int, name text, type text, deleted text, project_id int foreign key references iam_projects(db_id))
create table iam_project_roles(db_id int primary key, id int, name text, type text, project_id int foreign key references iam_projects(db_id))
create table iam_staged_project_rules(db_id int primary key, role_db_id int foreign key references iam_staged_project_roles(db_id), value text, attribute text, operator text)
create table iam_rule_conditions(db_id int primary key, role_db_id int foreign key references iam_project_roles(db_id), value text, attribute text, operator text)
create table iam_projects_graveyard(db_id int primary key, id int)
