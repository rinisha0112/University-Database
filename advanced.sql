
#Query 1

drop view F_grade;
create view F_grade as 
select * from takes where grade like 'F';


# Query 2 (Unable to test due to presence of foreign key...but query is correct!!)

insert into f_grade values ('45678', 'CS-102', '1', 'Fall', '2009', 'A');
select ID from F_grade group by ID having count(ID)>=2;


#Query 3

drop table Grade_mapping;
create table Grade_mapping 
(Grade varchar(2),pointer numeric(2));

Insert into Grade_mapping values
('A', 10);

Insert into Grade_mapping values
('B', 8);

Insert into Grade_mapping values
('C', 6);

Insert into Grade_mapping values
('D', 4);

Insert into Grade_mapping values
('F', 0);

Insert into Grade_mapping values
('A+', 10);

Insert into Grade_mapping values
('A-', 9);

Insert into Grade_mapping values
('B+', 8);

Insert into Grade_mapping values
('B-', 7);

Insert into Grade_mapping values
('C+', 6);

Insert into Grade_mapping values
('C-', 5);

Insert into Grade_mapping values
('D+', 4);

Insert into Grade_mapping values
('D-', 3);




Select ID, avg(pointer) as CPI 
from takes, Grade_mapping
where takes.grade=Grade_mapping.Grade group by ID;


#Query 4

		#create view room_alloc as 
		#(select sec_id, room_num, time_slot_id from section);

		#create view time_alloc as
		#(select time_slot_id, start_hr, strat_min);


		#drop view slots;
		#create view slots as
		#(select distinct time_slot_id from time_slot);

drop view allocation;
create view allocation as
(select sec_id, room_number, section.time_slot_id, start_hr, start_min from section, time_slot where section.time_slot_id=time_slot.time_slot_id);

select room_number, sec_id from allocation as R where R.time_slot_id=allocation.time_slot_id and R.room_number=allocation.room_number  and R.sec_id <>allocation.sec_id; 

#Query 5

drop view faculty;
create view faculty as
( select ID, name, dept_name from instructor);


#Query 6
drop view CSinstructor;
create view CSinstructor as
(select * from instructor where dept_name='Comp. Sci.');

#Query 7

insert into faculty values('7430', 'Shawn Mendes','Comp. Sci.');

		# The tuple got inserted Successfully!
		# The above insertion is reflected in instructor table with value of Salary Attribute as null

insert into CSinstructor values('4730', 'Rinisha', 'Comp. Sci.', '100000');

		# The tuple got inserted Successfully in CSinstructor table;
		# the tuple ('7430', 'Shawn Mendes','Comp. Sci.') also got inserted in CSinstructor with salary=null
		#  The above insertion is reflected in instructor table with consistent values of all  Attributes 

		# Both the views faculty and CSinstructor are Updatable View as-
		# 1. from clause has only one database relation
		# 2. there are no aggregate functions
		# 3. Any attribute not selected by Select clause are valued as null
		# 4. group by and having clause are absent.

# Query 8

grant select on student to prachita;

GRANT ALL PRIVILEGES ON *.* TO ''@'localhost' IDENTIFIED BY 'PASSWORD' WITH GRANT OPTION;

SELECT * FROM SYSIBMADM.PRIVILEGES
 WHERE AUTHID = SESSION_USER AND AUTHIDTYPE = 'U';