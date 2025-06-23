-- Run entire script all together.
-- It will create the database, create the tables and keys and import the data from the csv files we were given.
-- The 4 csv files we were given must be in the folder sunshine_desert in the root of the c drive (e.g. C:\sunshine_desert\file.csv)
------------------------------------------------------------------
-- create database
Create database sunshine_desert;
go
use sunshine_desert;
go
------------------------------------------------------------------
--create tables
create table employees (
emp_no int not null primary key,
birth_date date not null,
first_name varchar(50) not null,
last_name varchar(50) not null,
gender char(1) check (gender='M' or gender='F'),
hire_date date not null);

create table salaries (
emp_no int not null foreign key references employees(emp_no),
salary int not null,
from_date date not null,
to_date date not null,
primary key (emp_no,from_date,to_date));

create table departments (
dept_no char(4) not null primary key,
dept_name varchar(30) not null);

create table dept_emp (
emp_no  int not null foreign key references employees(emp_no),
dept_no varchar(4) not null,
from_date date not null,
to_date date not null,
primary key (emp_no,dept_no,from_date));
------------------------------------------------------------------
-- import data from files
-- import employees
bulk insert employees
from 'C:\sunshine_desert\employees.csv'
with (format='csv', firstrow=2);
go
-- import salaries
bulk insert salaries
from 'C:\sunshine_desert\salaries.csv'
with (format='csv', firstrow=2);
go
-- import dept_emp
bulk insert dept_emp
from 'C:\sunshine_desert\dept_emp.csv'
with (format='csv', firstrow=2);
go
-- import departments
bulk insert departments
from 'C:\sunshine_desert\departments.csv'
with (format='csv', firstrow=2);
------------------------------------------------------------------
-- END