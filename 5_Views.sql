-- Q1. Create a view EMPLOYEES_DETAILS to display all details(name,id,gender,salary(basic_pay),rank) of all Male Employees.
CREATE OR REPLACE view EMPLOYEES_DETAILS as
select emp.emp_no as EmployeeID,emp.first_name as FirstName, emp.last_name as LastName,emp.gender as Gender, sal.basic_pay as Basic_Pay, tit.title_rank as EmployeeRank 
from employees emp,titles tit,salaries sal
where emp.emp_title=tit.title_id and emp.emp_no=sal.emp_no;

select * from EMPLOYEES_DETAILS;

-- Q2. Create a view to DEPARTMENTS_DETAILS to display all department details along with details of building they are located in.
CREATE OR REPLACE view DEPARTMENTS_DETAILS as
select d.dept_no as DepartmentID, d.dept_name as Department, d.annual_expenditure_in_lakhs, b.building_id as BuildingID, b.building_name as Building, b.floors as floors
from departments d, building b
where d.building=b.building_id;

select * from DEPARTMENTS_DETAILS;

-- Q3.From views DEPARTMENTS_DETAILS and EMPLOYEES_DETAILS and dept_emp table find details of all male employees(not managers and CEO) who work in a department whose building has more than 8 floors.
select *
from EMPLOYEES_DETAILS ED
where ED.gender='M' and ED.EmployeeID in (
    select de.emp_no
    from dept_emp de, DEPARTMENTS_DETAILS DD
    where de.dept_no=DD.DepartmentID and DD.floors>8
);

-- Q4. Create a view MANAGER_DETAILS to display details of all the managers(similar to employees in Q2).
CREATE OR REPLACE view MANAGER_DETAILS as
select emp.emp_no as ManagerID , d.dept_no as DepartmentID, d.dept_name as Depatment ,emp.first_name as FirstName, emp.last_name as LastName,emp.gender as Gender, dm.emp_working_under as EmployeesWorkingUnder ,sal.basic_pay as Basic_Pay, tit.title_rank as EmployeeRank
from employees emp,titles tit,salaries sal, departments d, dept_manager dm
where emp.emp_title=tit.title_id and emp.emp_no=sal.emp_no and dm.dept_no=d.dept_no and dm.emp_no=emp.emp_no;

select * from MANAGER_DETAILS;

-- Q5. Create a view TITLE_DETAILS which will display all title details as well as average salary(net_pay) of all employess according to title_id in ascending order of rank.
CREATE OR REPLACE view TITLE_DETAILS as
select tit.title_id as TitleID, tit.title as Title, tit.title_rank as TitleRank, avg(sal.net_pay) as AverageTitleSalary
from titles tit, salaries sal, employees emp
where emp.emp_no=sal.emp_no and emp.emp_title=tit.title_id
group by tit.title_id 
order by tit.title_rank;

select * from TITLE_DETAILS;
