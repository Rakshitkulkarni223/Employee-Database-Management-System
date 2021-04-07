-- Q1. What is the average salary(basic_pay) of all managers?
select avg(sal.basic_pay) as AverageManagerSalary
from salaries sal
where sal.emp_no in (
    select emp_no
    from dept_manager
);

-- Q2. Which employees(not managers and ceo) have salaries(net_pay) between 60000 and 80000(both included)?
select emp.emp_no as EmployeeID, emp.first_name as FirstName, emp.last_name as LastName
from employees emp where emp.emp_no in(
    select de.emp_no
    from dept_emp de
    where de.emp_no in(
        select emp_no
        from salaries sal
        where sal.net_pay>=60000 and sal.net_pay<=80000
    ) 
);

-- Q3. Print name, department , emp_id and salary(basic_pay) of the manager having the least number of employees working under him
select emp.first_name as FirstName,emp.emp_no as EmployeeID,dep.dept_name as Department, sal.basic_pay as Basic_Pay
from employees emp, departments dep, salaries sal,dept_manager dm
where emp.emp_no=sal.emp_no and emp.emp_no=dm.emp_no  and dep.dept_no=dm.dept_no and emp.emp_no in(
    select dm1.emp_no
    from dept_manager dm1
    where dm1.emp_working_under=(
        select min(dm2.emp_working_under)
        from dept_manager dm2 
    ) 
);

-- Q4.  Print details(EmployeeID, Name, Salary, Rank) of all Male Employees and have salary(net_pay) greater than or equal salary of employee(net_pay) with emp_no=10023 in decreasing order of Net_Pay
select emp.emp_no as EmployeeID,emp.first_name as FirstName, sal.net_pay as Net_Pay,tit.title_rank as EmployeeRank
from employees emp, salaries sal,titles tit
where emp.emp_no=sal.emp_no and emp.emp_title=tit.title_id and sal.emp_no=emp.emp_no and emp.emp_no in(
    select emp1.emp_no
    from employees emp1
    where emp1.gender='M' and emp1.emp_no in(
        select sal1.emp_no
        from salaries sal1
        where sal1.net_pay>=(
            select sal2.net_pay
            from salaries sal2
            where sal2.emp_no=10023
        )
    )
) order by sal.net_pay desc;


-- Q5.Print average salary of all departments for employees(excluding manager and CEO).(correlated)
select d.dept_name as Department, avg(s.basic_pay)
from salaries s,departments d
where exists(
    select * from dept_emp de
    where de.emp_no=s.emp_no and de.dept_no=d.dept_no
)
group by d.dept_no;

-- Q6. Find all employees who earn highest for their rank and arrange them in descending order of their rank
select emp.emp_no as EmployeeID,emp.first_name as FirstName, emp.last_name as LastName, tit.title_rank as EmployeeRank, sal.net_pay as NET_PAY
from employees emp,titles tit,salaries sal
where emp.emp_title=tit.title_id and emp.emp_no=sal.emp_no and sal.net_pay in (
    select max(sal1.net_pay)
    from salaries sal1,titles tit1
    where exists(
        select * from employees emp1
        where emp1.emp_no=sal1.emp_no and tit1.title_id=emp1.emp_title
    )
    group by tit1.title_rank
)
order by tit.title_rank;

-- Q.7 Find all managers who work in a department having more than annual_expenditure 40 lakhs and has more than 30 employees working under him/her.
select emp.emp_no as EmployeeID,emp.first_name as FirstName, emp.last_name as LastName
from employees emp
where exists(
    select *
    from dept_manager dm
    where emp.emp_no=dm.emp_no and dm.emp_working_under>30 and exists(
        select *
        from departments d
        where d.dept_no=dm.dept_no and d.annual_expenditure_in_lakhs>40
    )
);