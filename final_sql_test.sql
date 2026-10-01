create database company_sql_test;
use company_sql_test;

create table department (
dept_id int primary key,
dept_name varchar(200) not null,
location varchar(100)
);

create table employees(
emp_id int primary key,
emp_name varchar(100) not null,
dept_id int,
salary decimal(10,2),
hire_date date,
foreign key (dept_id) references department(dept_id)
);

insert into department (dept_id,dept_name,location)
values
(1,"IT","Pune"),
(2,"Finance","Mumbai"),
(3,"Marketing","Satara"),
(4,"Legal","Pune"),
(5,"Sales","Gujarat"),
(6,"HR","Mumbai");

insert into employees(emp_id,emp_name,dept_id,salary,hire_date)
values
(1,"Jayesh Khanna",1,89000,"2024-09-12"),
(2,"Jethalal Gada",2,87000,"2026-05-02"),
(3,"Aatmaram Gada",3,56000,"2021-05-02"),
(4,"Mitali Bhide",1,8000,"2026-09-30"),
(5,"Omkar",5,64000,"2026-06-06"),
(6,"Apurva",6,8000,"2024-09-30"),
(7,"Piyush Roy",5,45000,"2022-09-30"),
(8,"Madhavi Bhide",6,23000,"2025-09-30"),
(9,"Ankit",1,23000,"2025-09-30"),
(10,"Sohail",3,23000,"2025-09-30")
;

-- Q.3 Add an email column to the employees table
alter table employees add column email varchar(50) not null;

-- Q.4 Add a status column using alter , Update atleast on employees status
alter table employees add column status varchar(50)default "Active";
update employees set status="Inactive" where emp_id=1;
select * from  employees;

-- Q.5 Display employees whose salary is between 50000 and 90000
select * from employees where salary between 50000 and 90000 order by salary desc;

-- Q.6 Display employees whose name starts with A and conatains r letter
select * from employees where emp_name like "A%" or emp_name like "%r%";

-- Q.7 Display each department name  and the number of employees in that department . Departments with zero employees must appear
select d.dept_name,count(emp_id) from department d left join employees e on  d.dept_id=e.dept_id group by d.dept_id;


-- Q.8 display the dept anme and average salary for dept whose salary is greate than 70000
SELECT d.dept_name, AVG(e.salary) AS avg_salary
FROM employees e
GROUP BY d.dept_name
HAVING AVG(salary) > 70000;

-- Q.9 Display employee name , salry , location department name using inner join
select e.emp_name , d.dept_name , d.location , e.salary from employees e inner join department d 
on e.dept_id=d.dept_id;

-- Q.10 Display employees whose slary is greater than average salary
select emp_name , salary from employees where salary>(select avg(salary) from employees);
SELECT avg(salary) from employees;

-- Q.11 Find employees whose salary is greater than average salary of their own departent using correlated query
select e.emp_name , e.salary , e.dept_id 
from employees e
where e.salary >(
select avg(e2.salary) from employees e2
where e2.dept_id=e.dept_id
);
select avg(salary) from employees where dept_id=1;

-- Q.12 Use Exist to depatments that have eployees
select d.dept_id,d.dept_name 
from department d
where exists (
select 1
from employees  e
where e.dept_id=d.dept_id
);	

-- Use not exists to show departments that don't have employees
select d.dept_id,d.dept_name 
from department d
where not exists (
select 1
from employees  e
where e.dept_id=d.dept_id
);	

-- Q. 13 Using a window function assign a dense_rank() to employees based on salary with each department
select emp_name 
,salary , dense_rank()over(
order by salary desc) as salary_rank
from employees;





