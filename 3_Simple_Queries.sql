-- Q1.Which buildings have more than 1 departments inside them?
select bui1.building_id as BuildingID,bui1.building_name as BuildingName
from building bui1 where 1<
(select count(*)
from departments d
where d.building=bui1.building_id
group by bui1.building_id);

-- Q.2 Which building has the 2nd most number of floors?
select bui1.building_id as BuildingID,bui1.building_name as BuildingName, bui1.floors as Floors
from building bui1 where bui1.floors=
(select max(floors) from building where floors<
(select max(floors) from building));

-- Q.3 Print salary details of CEO?
select * from salaries sal
where sal.emp_no=(
    select emp_no
    from employees
    where emp_title='c0000');

-- Q.4 Which rank 3 employees(managers and designers) have more salary than any any rank 2 officer(Technique Leader)?
select emp.emp_no, emp.first_name as FirstName, emp.last_name as LastName, sal.basic_pay as BasicPay
from employees emp, salaries sal, titles tit
where emp.emp_no=sal.emp_no and emp.emp_title=tit.title_id and tit.title_rank=3 and sal.basic_pay> ANY (
    select sal2.basic_pay
    from salaries sal2, employees emp2, titles tit2
    where emp2.emp_no=sal2.emp_no and emp2.emp_title=tit2.title_id and tit2.title_rank=2 
);

-- Q.5 Which female employee has the least salary(basic_pay)?
select emp.emp_no, emp.first_name as FirstName, emp.last_name as LastName, sal.basic_pay as BasicPay
from employees emp, salaries sal
where emp.emp_no=sal.emp_no and emp.gender='F' and sal.basic_pay=(
    select min(sal2.basic_pay)
    from salaries sal2, employees emp2
    where emp2.emp_no=sal2.emp_no and emp2.gender='F'
);

-- Q6.Which manager has the most number of employees working under him?
select emp.emp_no, emp.first_name as FirstName, emp.last_name as LastName, dm.emp_working_under
from employees emp, dept_manager dm
where emp.emp_no=dm.emp_no and dm.emp_working_under=(
    select max(emp_working_under) from dept_manager
);


-- Q.7 Which managers are born in or after year 1960?
select emp.emp_no, emp.first_name as FirstName,  emp.last_name as LastName
from employees emp, dept_manager dm
where emp.emp_no=dm.emp_no and emp.birth_date>='1960-01-01';

-- Q.8 Which departments have annual expenditure between 50 and 100 lakhs(both included) in ascending order?
select * from departments
where annual_expenditure_in_lakhs>=50 and annual_expenditure_in_lakhs<=100
order by annual_expenditure_in_lakhs;

-- Q.9 Print titles of all employees whose names start with ‘A’ in decreasing order of their rank.
select emp.emp_no, emp.first_name as FirstName,  emp.last_name as LastName, tit.title as Title
from employees emp,titles tit
where emp.emp_title=tit.title_id and emp.first_name REGEXP '^A'
order by tit.title_rank desc;

-- Q.10 Which Female employees are Managers?
select emp.emp_no, emp.first_name as FirstName,  emp.last_name as LastName, tit.title as Title
from employees emp,titles tit
where emp.emp_title=tit.title_id and emp.gender='F' and tit.title='Manager';
