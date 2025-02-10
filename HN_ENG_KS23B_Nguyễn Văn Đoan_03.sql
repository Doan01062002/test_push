create database hackathon;
 use hackathon;

-- thử sjshgfasfhdsfdgsjdfs
 
 -- Phần 1:
 -- Câu 2:
 create table tbl_departments(
	department_id int primary key auto_increment,
    department_name varchar(100) not null,
    manager_id int
 );

 create table tbl_employees(
	employee_id int primary key auto_increment,
    employee_name varchar(100) not null,
    phone varchar(20) not null unique,
    email varchar(100) not null unique,
    hire_date date,
    department_id int,
    foreign key (department_id) references tbl_departments(department_id)
 );
 
 create table tbl_projects(
	project_id int primary key auto_increment,
    project_name varchar(100) not null,
    start_date date,
    end_date date,
    budget decimal(10,2)
 );
 
 create table tbl_assignments(
	assignment_id int primary key auto_increment,
    employee_id int,
    foreign key (employee_id) references tbl_employees(employee_id),
    project_id int,
    foreign key (project_id) references tbl_projects(project_id),
    role varchar(50),
    hours_worked int
);

create table tbl_salaries(
	salary_id int primary key auto_increment,
    employee_id int,
    foreign key (employee_id) references tbl_employees(employee_id),
    salary_date date,
    basic_salary decimal(10,2),
    bonus decimal(10,2)
);

-- 1,
alter table tbl_employees
add column position varchar(50);

-- 2,
alter table tbl_employees
modify phone varchar(15);

-- 3,
alter table tbl_projects
drop budget;

-- Câu 3:

insert into tbl_departments(department_id, department_name, manager_id)
values(1,'Phát triển phần mềm',1),
		(2,'Marketing',2),
        (3,'Nhân sự', 5);

insert into tbl_employees(employee_id, employee_name, phone, email,hire_date, department_id)
values(1,'Nguyễn Văn A', '0932767326', 'anv@gmail.com', '2023-01-01',1),
		(2,'Trần Thị B', '0992378636', 'btt@gmail.com', '2023-04-05',2),
		(3,'Lê Văn C', '0932767365', 'clv@gmail.com', '2023-03-10',1),
        (4,'Phạm Thị D', '0973265632', 'dpt@gmail.com', '2023-02-15',2),
        (5,'Nguyễn Thị E', '0923865633', 'ent@gmail.com', '2023-05-20',3);


insert into tbl_projects(project_id, project_name, start_date, end_date, budget)
values(101, 'Dự án A', '2023-06-01', '2023-12-31',100000),
		(102, 'Dự án B', '2023-04-01', '2023-10-31',80000),
        (103, 'Dự án C', '2023-05-15', '2024-03-31',120000),
        (104, 'Dự án D', '2022-02-01', '2023-05-31',500000),
        (105, 'Dự án E', '2023-05-05', '2023-12-05',200000);
        
insert into tbl_assignments(assignment_id, employee_id, project_id, role, hours_worked)
values(1,1,101, 'Developer', 160),
		(2,3,102, 'Marketer', 120),
        (3,3,103, 'Tester', 80),
        (4,4,104, 'Designer', 100),
        (5,5,101, 'Project Manager', 200);

insert into tbl_salaries(salary_id, employee_id, salary_date, basic_salary, bonus)
values(1,1,'2023-07-01', 1200,300),
		(2,2,'2023-08-01', 700,50),
        (3,3,'2023-06-01', 800,100),
        (4,4,'2024-02-01', 1000,150),
        (5,5,'2024-05-01', 900,300);

-- Câu 4:
-- a,
select employee_id, employee_name, department_id, hire_date
from tbl_employees;

-- b,
select distinct p.project_name
from tbl_projects p
join tbl_assignments a on p.project_id = a.project_id;

-- Câu 5:
-- a,
select d.department_name, count(e.employee_id)
from tbl_departments d
join tbl_employees e on d.department_id = e.department_id
group by d.department_name;

-- b,
select p.project_name, count(e.employee_id)
from tbl_projects p
join tbl_employees e on p.project_id = e.project_id
group by p.project_name;

-- Câu 6:
-- a,
select e.employee_name, sum(a.hours_worked) as total_hours
from tbl_employees e
join tbl_assignments a on e.employee_id = a.employee_id
group by e.employee_name;

-- b,
select e.employee_name, sum(a.hours_worked) as total_hours
from tbl_employees e
join tbl_assignments a on e.employee_id = a.employee_id
group by e.employee_name
having total_hours > 50;

-- Câu 7:
select e.employee_name, sum(a.hours_worked) as total_hours
from tbl_employees e
join tbl_assignments a on e.employee_id = a.employee_id
group by e.employee_name
order by total_hours desc
limit 5;

-- Câu 8:
select e.employee_name, (s.basic_salary + s.bonus) as total_salary
from tbl_employees e
join tbl_salaries s on e.employee_id = s.employee_id
where s.salary_date = (select max(salary_date) from tbl_salaries);
