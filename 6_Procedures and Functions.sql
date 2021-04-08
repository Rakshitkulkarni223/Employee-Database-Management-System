-- Q1.Create a stored procedure EmployeesOfDepartmentWithRank that takes input department and rank(2,3 or 4) name and returns all employees(excluding Mangers and CEO) Id,Name, Gender and Rank belonging to that department with the given rank.
DROP PROCEDURE IF EXISTS EmployeesOfDepartmentWithRank;
Delimiter $$
create Procedure EmployeesOfDepartmentWithRank(IN InputDepartment varchar(40), IN InputRank int)
Begin
select distinct emp.emp_no as EmployeeID, emp.first_name as FirstName, emp.last_name as LastName, emp.gender as Gender, tit.title_rank as EmployeeRank
from employees emp, titles tit, departments d, dept_emp as de
where emp.emp_title = tit.title_id and emp.emp_no = de.emp_no and de.dept_no = d.dept_no and d.dept_name = InputDepartment and tit.title_rank = InputRank;
End $$
Delimiter ;

call EmployeesOfDepartmentWithRank('Finance',2);
call EmployeesOfDepartmentWithRank('Finance',3);
call EmployeesOfDepartmentWithRank('Sales',2);
call EmployeesOfDepartmentWithRank('Human Resources',4);


-- Q2. Create a stored procedure ManagersJoinedAfter that accepts a date and returns data of all managers who joined the firm on or after the given date. Sort the result based on Joining date
DROP PROCEDURE IF EXISTS ManagersJoinedAfter;
Delimiter $$
create Procedure ManagersJoinedAfter(IN MinDate date)
Begin
select emp.emp_no as EmployeeID, d.dept_name as Department, emp.first_name as FirstName, emp.last_name as LastName, dm.emp_working_under as EmployeesWorkingUnder, emp.gender as Gender,emp.birth_date as BirthDate, emp.hire_date as JoinedOn
from employees emp, dept_manager dm, departments d
where emp.emp_no = dm.emp_no and dm.dept_no = d.dept_no and emp.hire_date >= MinDate
order by emp.hire_date;
End $$
Delimiter ;

call ManagersJoinedAfter('1980-11-17');
call ManagersJoinedAfter('1986-11-17');
call ManagersJoinedAfter('1993-06-27');
call ManagersJoinedAfter('1995-08-24');
call ManagersJoinedAfter('1996-08-24');


-- Q3. Create stored procedure EmployeeWithSalaryGreater that accept a number as parameter and return all employees id,first and last names and their salary whose salary(net_pay) is above or equal to the given number. The result should be sorted by first_name then by last_name alphabetically.
DROP PROCEDURE IF EXISTS EmployeeWithSalaryGreater;
Delimiter $$
create Procedure EmployeeWithSalaryGreater(IN MinSalary DECIMAL(12,3))
Begin
select emp.emp_no as EmployeeID, emp.first_name as FirstName, emp.last_name as LastName, sal.net_pay as Net_Pay
from employees emp, salaries sal
where emp.emp_no=sal.emp_no and sal.net_pay>MinSalary
order by emp.first_name,emp.last_name;
End $$
Delimiter ;
call EmployeeWithSalaryGreater(40000);
call EmployeeWithSalaryGreater(73428.740);
call EmployeeWithSalaryGreater(311861.940);

-- Q4. Write a stored procedure BuildingContains that takes an input string as parameter and returns all buildings whose name contain the string. The result should be sorted by town name alphabetically.
DROP PROCEDURE IF EXISTS BuildingContains;
Delimiter $$
Create Procedure BuildingContains(IN initial varchar(255) )
Begin
Select b.building_id as BuildingID, b.building_name as Building, b.floors
from building b
where b.building_name like
concat('%',concat(initial,'%')) order by b.building_name;
End $$
Delimiter ;

Call BuildingContains('Blue ');
Call BuildingContains(' ');
Call BuildingContains('ak');
Call BuildingContains('ore');


-- Q5. Write a stored procedure EmployeesWithDifferenceBetweenNetPayAndBasicPayGreaterThan which takes input an integer and returns name, id and Difference between Net Pay and Basic Pay of all Employees having difference between NetPay and Basic Pay greater than the input. Arrange the output by first name and then by last name.
DROP PROCEDURE IF EXISTS EmployeesWithDifferenceBetweenNetPayAndBasicPayGreaterThan;
Delimiter $$
create Procedure EmployeesWithDifferenceBetweenNetPayAndBasicPayGreaterThan(IN MinDifference DECIMAL(12,3))
Begin
select emp.emp_no as EmployeeID, emp.first_name as FirstName, emp.last_name as LastName,sal.net_pay-sal.basic_pay as Diff
from employees emp, salaries sal
where emp.emp_no=sal.emp_no and sal.net_pay-sal.basic_pay>MinDifference
order by emp.first_name,emp.last_name;
End $$
Delimiter ;
call EmployeesWithDifferenceBetweenNetPayAndBasicPayGreaterThan(5000);
call EmployeesWithDifferenceBetweenNetPayAndBasicPayGreaterThan(5528.530);
call EmployeesWithDifferenceBetweenNetPayAndBasicPayGreaterThan(73428.740);




-- Stored Functions
-- Q1. Create a function EmployeeExperience() which takes input as EmployeeID and returns experience(in days) the Employee has gained in the firm.Consider today's Date as 01-01-1996
DROP FUNCTION IF EXISTS EmployeeExperience;
Delimiter $$
Create Function EmployeeExperience(EmployeeID INT)
Returns INT
READS SQL DATA
DETERMINISTIC
Begin
DECLARE JoinDate DATE;
DECLARE TodaysDate DATE DEFAULT '1996-01-01';
SET TodaysDate = '1996-01-01';
select hire_date INTO JoinDate
from employees
where
emp_no = EmployeeID;
return DATEDIFF(TodaysDate,JoinDate);
END $$
Delimiter ;

select EmployeeExperience(10001);
select EmployeeExperience(10035);
select EmployeeExperience(110027);
select EmployeeExperience(120000);

-- Q2. Create a function BuildingSize which takes in parameter Building_ID and returns the BuildingSize as Small,Medium or big.
-- Floors<5 means Small
-- Floors>=5 and Floors<=10 means Medium
-- Floors>10 means Large
DROP FUNCTION IF EXISTS BuildingSize;
Delimiter $$
Create Function BuildingSize(BuildingID varchar(5))
Returns varchar(10)
READS SQL DATA
DETERMINISTIC
Begin
DECLARE f1 INT DEFAULT 0;
select floors  INTO f1
from building
where building_id = BuildingID;
IF f1<5 THEN
RETURN 'SMALL';
ELSEIF f1>=5 and f1<=10 THEN
RETURN 'MEDIUM';
ELSE
RETURN 'LARGE';
END IF;
END $$
Delimiter ;

select BuildingSize('b001');
select BuildingSize('b002');
select BuildingSize('b003');
select BuildingSize('b004');
select BuildingSize('b005');
select BuildingSize('b006');
select BuildingSize('b007');
select BuildingSize('b008');

-- Q3.Create IT_RATE_EMPLOYEE stored function which takes input salary(basic_pay) of on Employee and Returns the tax applicable to the Employee.
-- The tax is calculated as
-- If Basicpay is > 100000, IT = 20%
-- If Basicpay is between 100000 and 50000 (inclusive), IT = 15%
-- If Basicpay is < 50000, IT = 10%
DROP FUNCTION IF EXISTS IT_RATE_EMPLOYEE;
delimiter ##
create function IT_RATE_EMPLOYEE(salary decimal(12,3))
returns decimal(12,3)
NOT DETERMINISTIC
READS SQL DATA
begin
    declare IT_Rate decimal(12,3) default 0.00;
    
    if salary>100000 then 
        set IT_Rate=salary*0.20;
    elseif (salary<=100000 and salary>=50000) then
        set IT_Rate=salary*0.15;
    elseif salary<50000 then
        set IT_Rate=salary*0.10;
    end if;
    return IT_Rate;
end ##
delimiter ;

select IT_RATE_EMPLOYEE(20000) as Tax;
select IT_RATE_EMPLOYEE(50000) as Tax;
select IT_RATE_EMPLOYEE(70000) as Tax;
select IT_RATE_EMPLOYEE(100000) as Tax;
select IT_RATE_EMPLOYEE(150000) as Tax;
select IT_RATE_EMPLOYEE(69000.5) as Tax;

-- Q4. Create a function AverageEmployeeSalary() which takes input parameter as DepartmentID and returns Average of NetPay of all Employees(Including Managers) working in the Department.
DROP FUNCTION IF EXISTS AverageEmployeeSalary;
Delimiter $$
Create Function AverageEmployeeSalary(DepartmentID varchar(4))
Returns DECIMAL(12,3)
READS SQL DATA
DETERMINISTIC
Begin
DECLARE AvgSalary DECIMAL(12,3) DEFAULT 0;
DECLARE EmployeesExcludingManager INT DEFAULT 0;
DECLARE EmployeeTotalSalaryExcludingManager DECIMAL(12,3) DEFAULT 0;
DECLARE ManagerSalary DECIMAL(12,3) DEFAULT 0;

select sal.net_pay INTO ManagerSalary
from dept_manager dm, salaries sal
where dm.emp_no = sal.emp_no and dm.dept_no = DepartmentID;

select count(*) INTO EmployeesExcludingManager
from dept_emp de
where de.dept_no = DepartmentID;

select sum(sal.net_pay) INTO EmployeeTotalSalaryExcludingManager
from salaries sal, dept_emp de
where sal.emp_no=de.emp_no and de.dept_no= DepartmentID;

SET AvgSalary = (ManagerSalary + EmployeeTotalSalaryExcludingManager)/( EmployeesExcludingManager+1 );
RETURN AvgSalary;
END $$
Delimiter ;

select AverageEmployeeSalary('d001');
select AverageEmployeeSalary('d002');
select AverageEmployeeSalary('d003');
select AverageEmployeeSalary('d004');
select AverageEmployeeSalary('d005');
select AverageEmployeeSalary('d006');
select AverageEmployeeSalary('d007');
select AverageEmployeeSalary('d008');

-- Q5. Create a function ProfitGained() which takes input as department ID calculates profit made by department based on the below formula.
-- Profit = AnnualExpenditure*1.5 + AverageEmployeeSalary*2 + CEOSalary/5 .All salaries are net_pay
DROP FUNCTION IF EXISTS ProfitGained;
Delimiter $$
Create Function ProfitGained(DepartmentID varchar(4))
Returns DECIMAL(12,3)
READS SQL DATA
DETERMINISTIC
Begin
DECLARE AnnualExpenditure INT DEFAULT 0;
DECLARE AverageEmployeeSalary INT DEFAULT 0;
DECLARE CEOSalary INT DEFAULT 0;

select d.annual_expenditure_in_lakhs*100000 INTO AnnualExpenditure
from departments d
where d.dept_no=DepartmentID;

select AverageEmployeeSalary(DepartmentID) INTO AverageEmployeeSalary;

select sal.net_pay INTO CEOSalary
from salaries sal
where sal.emp_no=120000;

Return AnnualExpenditure*1.5 + AverageEmployeeSalary*2 + CEOSalary/5;

END $$
Delimiter ;

select ProfitGained('d001');
select ProfitGained('d002');
select ProfitGained('d003');
select ProfitGained('d004');
select ProfitGained('d005');
select ProfitGained('d006');
select ProfitGained('d007');
select ProfitGained('d008');
select ProfitGained('d009');
