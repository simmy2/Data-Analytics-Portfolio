  -- create a database
  create database if not exists Employees;
  
  use employees;
  -- create table in the database
  create table if not exists employee(
							 employee_no int primary key,
                             firstName varchar(14) not null,
                             lastName varchar(16) not null,
                             Birthdate date not null,
                             gender enum('M','F') not null,
                             HireDate date not null
);
			


	create table if not exists department(
								department_no varchar(4) primary key,
                                departmentName varchar(40) unique not null
);
                                
alter table department
modify department_no char(4);

	create table if not exists Dept_managers(
							   employee_no int ,
							   department_no char(4),
                               fromDate date not null,
                               Todate date not null
);

	create table if not exists Dept_employees(
							   employee_no int,
	  						   department_no char(4),
							   fromDate date not null,
							   ToDate date not null
);                               
                                
create table if not exists titles(
						   employee_no int,
                           title varchar(50),
                           fromDate date not null,
                           ToDate date not null
);

create table if not exists salaries(
						   employee_no int,
                           salary double not null,
                           fromDate date not null,
                           ToDate date not null
);
use employees;
-- setting pk
alter table dept_managers 
add constraint foreign key(employee_no) references employee(employee_no);


alter table dept_managers 
add constraint foreign key(department_no) references department(department_no);

alter table Dept_employees
add constraint foreign key(employee_no) references employee(employee_no);

alter table dept_employees
add constraint foreign key(department_no) references department(department_no);

alter table titles
add constraint foreign key(employee_no) references employee(employee_no);

alter table salaries
add constraint foreign key(employee_no) references employee(employee_no);

-- quick analysis
select *
from department;
 
select *
from dept_employees;

select *
from dept_managers;

select *
from employee;

select *
from salaries;

select *
from titles;


-- 1. what is the salary of a specific employee with employee_no=1016
select employee_no,salary
from salaries
where employee_no=1016;

-- 2 what is the average salary of all male employees in the company
select e.gender, avg(s.salary) as "Average salary by gender"
from employee as e
inner join salaries as s on e.employee_no=s.employee_no  
where gender='M'
group by gender;

-- 3 What is the salary of female employees in the company
select e.gender, avg(s.salary) as "Average salary by gender"
from employee as e
inner join salaries as s on e.employee_no=s.employee_no  
where gender='F'
group by gender;

-- 4 How many employees are there in each department
select departmentName,count(employee_no) as "Number of employees by department"
from dept_employees as DE
inner join department as D on DE.department_no=D.department_no
group by departmentName;

-- 5 who is the youngest employee in the company
select concat(firstName," ", lastname) as "Full Name", Birthdate
from employee
order by Birthdate asc;

-- what is the average salary for each department
select d.departmentName,avg(s.salary) as "Average Salary of each Department"
from dept_employees as DE 
inner join salaries as s on DE.employee_no=s.employee_no
inner join department as d on DE.department_no=d.department_no
group by d.departmentName; 

 
























                                         

    
    
    
    
    
