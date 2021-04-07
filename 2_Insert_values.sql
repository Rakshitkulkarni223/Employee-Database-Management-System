-- After Insert Trigger (1)
-- The trigger find_number_of_rooms will be activated and it will insert the building_id and number_of_rooms into building_rooms table 
-- after inserting the values into building table.We assumed that one floor conatins 10 rooms.

delimiter ##
create trigger find_number_of_rooms
after insert
on building for each row
begin 
    declare rooms int default 0;
    set rooms=new.floors*10;
    insert into building_rooms(building_id,number_of_rooms) values(new.building_id,rooms);
end ##

delimiter ;


-- Before Insert Trigger (2) 
-- The trigger insert_emp_no_into_salary_table will be activated and it will insert the emp_no into salaries table before inserting
-- employee details into emplpoyees table

delimiter ##
create trigger insert_emp_no_into_salary_table
before insert
on employees for each row
begin 
    insert into salaries(emp_no) values(new.emp_no);
end ##

delimiter ;

insert into building values('b001', 'Crimson Bay', 6);
insert into building values('b002', 'Altura',8);
insert into building values('b003', 'Blue Diamond', 10);
insert into building values('b004', 'Elite',3);
insert into building values('b005', 'Elanza',13);
insert into building values('b006', 'Blue Heights', 6);
insert into building values('b007', 'Adobe', 8);
insert into building values('b008', 'Lake Homes',7);

insert into departments values('d001', 'Marketing', 'b005', 60);
insert into departments values('d002', 'Finance', 'b003', 30);
insert into departments values('d003', 'Human Resources', 'b003', 20);
insert into departments values('d004', 'Production', 'b002', 100);
insert into departments values('d005', 'Development', 'b008', 50);
insert into departments values('d006', 'Quality Management', 'b007', 40);
insert into departments values('d007', 'Sales', 'b001', 80);
insert into departments values('d008', 'Research', 'b004', 30);
insert into departments values('d009', 'Customer Service', 'b006', 70);

insert into titles values('c0000','CEO', 0);
insert into titles values('e0001','Technique Leader', 2);
insert into titles values('e0002','Engineer', 3);
insert into titles values('e0003','Designer', 3);
insert into titles values('e0004','Assistant', 4);
insert into titles values('m0001','Manager', 1);


insert into employees values(10001,'e0001','1953-07-25','Hideyuki','Zallocco','M','1990-04-28');
insert into employees values(10002,'e0002','1954-11-18','Byong','Delgrande','F','1991-09-07');
insert into employees values(10003,'e0002','1958-01-30','Berry','Babb','F','1992-03-21');
insert into employees values(10004,'e0004','1957-09-28','Xiong','Verhoeff','M','1987-11-26');
insert into employees values(10005,'e0001','1952-10-28','Abdelkader','Baumann','F','1991-01-18');
insert into employees values(10006,'e0002','1959-10-30','Eran','Cusworth','M','1986-11-14');
insert into employees values(10007,'e0002','1957-04-14','Christoph','Parfitt','M','1991-06-28');
insert into employees values(10008,'e0004','1964-11-17','Xudong','Samarati','M','1985-11-13');
insert into employees values(10009,'e0001','1962-12-18','Lihong','Magliocco','M','1993-10-23');
insert into employees values(10010,'e0003','1956-04-24','Kwangyoen','Speek','F','1993-02-14');
insert into employees values(10011,'e0003','1961-12-31','Shuichi','Tyugu','F','1995-01-17');
insert into employees values(10012,'e0004','1961-10-25','Abdulah','Lunn','M','1989-04-08');
insert into employees values(10013,'e0001','1961-08-30','Perry','Lorho','F','1991-08-03');
insert into employees values(10014,'e0003','1958-03-23','Subbu','Bultermann','F','1988-03-25');
insert into employees values(10015,'e0003','1959-05-19','Bojan','Zallocco','M','1986-10-14');
insert into employees values(10016,'e0004','1960-08-21','Rajesh','Root','M','1986-11-13');
insert into employees values(10017,'e0001','1958-02-08','JiYoung','Crooks','M','1988-11-19');
insert into employees values(10018,'e0003','1960-01-23','Yoshinari','Eugenio','F','1987-01-25');
insert into employees values(10019,'e0003','1956-04-11','Toong','Bultermann','M','1983-10-12');
insert into employees values(10020,'e0004','1955-03-21','Kersti','Broomell','F','1984-11-10');
insert into employees values(10021,'e0001','1961-11-29','Tomofumi','Comte','F','1991-06-01');
insert into employees values(10022,'e0003','1950-01-26','Gudjon','Ghemri','F','1988-02-18');
insert into employees values(10023,'e0003','1959-05-30','Bojan','Swen','M','1980-03-17');
insert into employees values(10024,'e0004','1960-08-31','Feiyu','Deyuan','F','1982-05-30');
insert into employees values(10025,'e0001','1961-05-01','Siddarth','Oaver','M','1986-08-05');
insert into employees values(10026,'e0003','1964-02-15','Gaurav','Rouquie','M','1994-07-13');
insert into employees values(10027,'e0003','1959-07-11','Uno','Daescu','M','1986-03-25');
insert into employees values(10028,'e0004','1960-10-12','Tadanori','Suri','F','1987-02-08');
insert into employees values(10031,'e0001','1963-02-01','Susanne','Asser','F','1989-10-04');
insert into employees values(10032,'e0003','1953-08-18','Ekawit','Mellouli','M','1987-09-08');
insert into employees values(10033,'e0003','1953-03-01','Syozo','Sommen','M','1992-06-29');
insert into employees values(10034,'e0004','1960-05-30','Hideo','Salverda','M','1987-07-18');
insert into employees values(10035,'e0001','1955-10-25','Shaunak','Billingsley','M','1991-04-01');
insert into employees values(10036,'e0003','1952-12-22','Ashish','Ventosa','M','1986-08-14');
insert into employees values(10037,'e0003','1954-10-26','Sashi','Pearson','F','1994-12-04');
insert into employees values(10038,'e0004','1960-04-13','Ramalingam','Coombs','F','1992-01-31');
insert into employees values(110021,'m0001','1963-07-12','Bilhanan','Wuwongse','M','1993-10-06');
insert into employees values(110022,'m0001','1964-01-19','Venkatesan','Gilg','M','1993-06-28');
insert into employees values(110023,'m0001','1957-12-11','Naftali','Dulli','M','1993-06-06');
insert into employees values(110024,'m0001','1952-08-11','Roddy','Karnin','M','1985-05-29');
insert into employees values(110025,'m0001','1958-11-25','Nevio','Demizu','F','1986-05-18');
insert into employees values(110026,'m0001','1952-08-27','Ziya','Asmuth','M','1995-08-24');
insert into employees values(110027,'m0001','1963-01-15','Kellyn','Yoshizawa','F','1995-05-08');
insert into employees values(110028,'m0001','1959-02-09','Venkatesan','McAlpine','M','1989-03-31');
insert into employees values(110029,'m0001','1957-05-03','Feixiong','Poujol','F','1985-04-02');
insert into employees values(120000,'c0000','1960-05-01','Ralph','Stokes','M','1986-03-02');

insert into dept_emp values(10001,'d004');
insert into dept_emp values(10002,'d004');
insert into dept_emp values(10003,'d004');
insert into dept_emp values(10004,'d004');
insert into dept_emp values(10005,'d005');
insert into dept_emp values(10006,'d005');
insert into dept_emp values(10007,'d005');
insert into dept_emp values(10008,'d005');
insert into dept_emp values(10009,'d001');
insert into dept_emp values(10010,'d001');
insert into dept_emp values(10011,'d001');
insert into dept_emp values(10012,'d001');
insert into dept_emp values(10013,'d002');
insert into dept_emp values(10014,'d002');
insert into dept_emp values(10015,'d002');
insert into dept_emp values(10016,'d002');
insert into dept_emp values(10017,'d003');
insert into dept_emp values(10018,'d003');
insert into dept_emp values(10019,'d003');
insert into dept_emp values(10020,'d003');
insert into dept_emp values(10021,'d006');
insert into dept_emp values(10022,'d006');
insert into dept_emp values(10023,'d006');
insert into dept_emp values(10024,'d006');
insert into dept_emp values(10025,'d007');
insert into dept_emp values(10026,'d007');
insert into dept_emp values(10027,'d007');
insert into dept_emp values(10028,'d007');
insert into dept_emp values(10031,'d008');
insert into dept_emp values(10032,'d008');
insert into dept_emp values(10033,'d008');
insert into dept_emp values(10034,'d008');
insert into dept_emp values(10035,'d009');
insert into dept_emp values(10036,'d009');
insert into dept_emp values(10037,'d009');
insert into dept_emp values(10038,'d009');

insert into dept_manager values('d005',110025,40);
insert into dept_manager values('d002',110022,35);
insert into dept_manager values('d004',110024,30);
insert into dept_manager values('d001',110021,45);
insert into dept_manager values('d008',110028,50);
insert into dept_manager values('d009',110029,36);
insert into dept_manager values('d006',110026,40);
insert into dept_manager values('d007',110027,27);
insert into dept_manager values('d003',110023,42);

-- This IT_Rate_employee stored function

-- If Basicpay is > 100000, IT = 20%
-- If Basicpay is between 100000 and 50000 (inclusive), IT = 15%
-- If Basicpay is < 50000, IT = 10%

delimiter ##
create function IT_Rate_employee(salary decimal(12,3)) returns decimal(12,3)
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

-- Before Update Trigger (3)
-- The trigger calculate will be activated and it will calculate the HRA,DA,Gross Pay and Net Pay of an employee 
-- based on his Basic pay and result will be updated into the salaries table itself.

    -- HRA= 12% of BP and DA=10% of BP)
    -- GP = BP + HRA+DA
    -- NP = GP – IT
delimiter ##

create trigger calculate
before update
on salaries for each row
begin 
    declare GP_ decimal(12,3) default 0.00;
    declare NP_ decimal(12,3) default 0.00;
    declare BP_ decimal(12,3) default 0.00;
    declare HRA_ decimal(12,3) default 0.00;
    declare DA_ decimal(12,3) default 0.00;
    set BP_=new.basic_pay;
    set HRA_=(0.12)*BP_;
    set DA_=(0.1)*BP_;
    set GP_=(BP_+HRA_+DA_);
    set NP_=GP_ - IT_Rate_employee(BP_);
    
    set new.hra=HRA_;
    set new.da=DA_;
    set new.gross_pay=GP_;
    set new.net_pay=NP_;    
end ##

delimiter ;

update salaries set basic_pay=65117.0 where emp_no=10001;
update salaries set basic_pay=60828.0 where emp_no=10002;
update salaries set basic_pay=60006.0 where emp_no=10003;
update salaries set basic_pay=40054.0 where emp_no=10004;
update salaries set basic_pay=78228.0 where emp_no=10005;
update salaries set basic_pay=58058.0 where emp_no=10006;
update salaries set basic_pay=59597.0 where emp_no=10007;
update salaries set basic_pay=48707.0 where emp_no=10008;
update salaries set basic_pay=89000.0 where emp_no=10009;
update salaries set basic_pay=78979.0 where emp_no=10010;
update salaries set basic_pay=77000.0 where emp_no=10011;
update salaries set basic_pay=43948.0 where emp_no=10012;
update salaries set basic_pay=80348.0 where emp_no=10013;
update salaries set basic_pay=60365.0 where emp_no=10014;
update salaries set basic_pay=55636.0 where emp_no=10015;
update salaries set basic_pay=40625.0 where emp_no=10016;
update salaries set basic_pay=77348.0 where emp_no=10017;
update salaries set basic_pay=50365.0 where emp_no=10018;
update salaries set basic_pay=55636.0 where emp_no=10019;
update salaries set basic_pay=45625.0 where emp_no=10020;
update salaries set basic_pay=87625.0 where emp_no=10021;
update salaries set basic_pay=70625.0 where emp_no=10022;
update salaries set basic_pay=65625.0 where emp_no=10023;
update salaries set basic_pay=40625.0 where emp_no=10024;
update salaries set basic_pay=91625.0 where emp_no=10025;
update salaries set basic_pay=80625.0 where emp_no=10026;
update salaries set basic_pay=80625.0 where emp_no=10027;
update salaries set basic_pay=60625.0 where emp_no=10028;
update salaries set basic_pay=85625.0 where emp_no=10031;
update salaries set basic_pay=70625.0 where emp_no=10032;
update salaries set basic_pay=68625.0 where emp_no=10033;
update salaries set basic_pay=35625.0 where emp_no=10034;
update salaries set basic_pay=88642.0 where emp_no=10035;
update salaries set basic_pay=72234.0 where emp_no=10036;
update salaries set basic_pay=71244.0 where emp_no=10037;
update salaries set basic_pay=55124.0 where emp_no=10038;
update salaries set basic_pay=198363.0 where emp_no=110021;
update salaries set basic_pay=208463.0 where emp_no=110022;
update salaries set basic_pay=287464.0 where emp_no=110023;
update salaries set basic_pay=201932.0 where emp_no=110024;
update salaries set basic_pay=102020.0 where emp_no=110025;
update salaries set basic_pay=132344.0 where emp_no=110026;
update salaries set basic_pay=305747.0 where emp_no=110027;
update salaries set basic_pay=503474.0 where emp_no=110028;
update salaries set basic_pay=575653.0 where emp_no=110029;
update salaries set basic_pay=1000000.0 where emp_no=120000;

select * from building;
select * from building_rooms;
select * from departments;
select * from titles;
select * from employees;
select * from dept_emp;
select * from dept_manager;
select * from salaries;