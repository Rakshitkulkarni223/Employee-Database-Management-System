drop database if exists MiniProject;
create database MiniProject;
use MiniProject;

CREATE TABLE building(
building_id varchar(5) NOT NULL,
building_name varchar(15) NOT NULL,
floors INT NOT NULL,
UNIQUE(building_id),
PRIMARY KEY (building_id)
);

CREATE TABLE building_rooms(
building_id varchar(5) NOT NULL,
number_of_rooms INT NOT NULL,
FOREIGN KEY (building_id) REFERENCES building (building_id)
);

CREATE TABLE departments(
dept_no varchar(4) NOT NULL,
dept_name varchar(40) NOT NULL,
building varchar(5) NOT NULL,
annual_expenditure_in_lakhs INT NOT NULL,
UNIQUE (dept_name),
PRIMARY KEY (dept_no),
FOREIGN KEY (building) REFERENCES building (building_id)
);

CREATE TABLE titles (
title_id varchar(10) NOT NULL,
title varchar(30) NOT NULL,
title_rank int NOT NULL,
PRIMARY KEY (title_id)
);

CREATE TABLE employees (
emp_no 	int NOT NULL,
emp_title varchar(10) NOT NULL,
birth_date date NOT NULL,
first_name varchar(30) NOT NULL,
last_name varchar(30) NOT NULL,
gender varchar(1) NOT NULL,
hire_date date NOT NULL,
PRIMARY KEY (emp_no),
FOREIGN KEY (emp_title) REFERENCES titles (title_id)
);

CREATE TABLE dept_emp (
emp_no int NOT NULL,
dept_no varchar(4) NOT NULL,
PRIMARY KEY (emp_no,dept_no),
FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
FOREIGN KEY (dept_no) REFERENCES departments (dept_no)
);


CREATE TABLE dept_manager(
dept_no varchar(4) NOT NULL,
emp_no int NOT NULL,
emp_working_under int NOT NULL,
PRIMARY KEY (emp_no,dept_no),
FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
FOREIGN KEY (dept_no) REFERENCES departments (dept_no)
);

CREATE TABLE salaries (
emp_no int NOT NULL,
basic_pay decimal(12,3) NOT NULL default 0,
hra decimal(12,3) DEFAULT 0,
da decimal(12,3) DEFAULT 0,
gross_pay decimal(12,3) DEFAULT 0,
net_pay decimal(12,3) DEFAULT 0,
PRIMARY KEY (emp_no)	
);
-- HRA= 12% of BP and DA=10% of BP)
-- GP = BP + HRA+DA
-- NP = GP – IT

desc building;
desc building_rooms;
desc departments;
desc titles;
desc employees;
desc dept_emp;
desc dept_manager;
desc salaries;