drop view count_sec1;
drop view id_print;
drop view sec_take;
drop view original_creds;
drop view x;
drop view y;


#Query 1
create view count_sec1 as select section.sec_id, section.course_id, takes.ID from section,takes, student 
where section.course_id=takes.course_id and section.sec_id=takes.sec_id 
and student.ID=takes.ID and section.semester=takes.semester and section.year=takes.year;

select 1 as minn ,count(ID) as maxx, sec_id, course_id from count_sec1 group by sec_id,course_id;


#Query 2


create view id_print as select 1 as minn ,count(ID) as maxx, sec_id, course_id from count_sec1 group by sec_id,course_id;

select sec_id, course_id from id_print as t1 where t1.maxx>=all(select t2.maxx from id_print as t2);

select id from takes where 
takes.course_id in (select course_id from id_print as t1 where t1.maxx>=all(select t2.maxx from id_print as t2)) 
and 
takes.sec_id in(select sec_id from id_print as t1 where t1.maxx>=all(select t2.maxx from id_print as t2));


#Query3

select sec_id,course_id, semester, year from section
where not exists
(select sec_id,course_id, semester, year from takes);

create view sec_take as
select sec_id,course_id, semester, year from section
where not exists
(select sec_id,course_id, semester, year from takes);

select 0 as minn , 0 as maxx, sec_id, course_id from sec_take
union select 1 as minn ,count(ID) as maxx, sec_id, course_id from count_sec1 group by sec_id,course_id;

#Query 4

select course_id from course where course_id like 'CS-1%';

#Query 5

select instructor.ID from instructor, teaches 
where not exists (select course_id from course where course_id not in (select course_id from course where course_id like 'CS-1%'))
and teaches.ID=instructor.ID; 

#Query 6

#insert into student values (select ID, name, dept_name,0 from instructor);

#Query 6
set autocommit =0;
start transaction;
commit;

insert into student(ID,name,dept_name,tot_cred) 
select instructor.ID,instructor.name,instructor.dept_name,0
from instructor
where instructor.ID not in (select student.ID from student) ;
rollback;


commit;

select * from student;
select * from instructor;
#Query 7

rollback;



#Query 8
create view original_creds as
select student.ID, sum(credits) as creds from student, takes, course 
where student.ID=takes.ID and takes.course_id=course.course_id group by student.ID;

update student,original_creds set student.tot_cred=original_creds.creds where student.ID=original_creds.ID;

commit;


#Query 9

create view x as select ID , section.course_id ,section.sec_id from teaches , section 
where teaches.sec_id = section.sec_id and teaches.course_id = section.course_id ;

create view y as select ID , count(course_id) as c from x group by ID;

update instructor,y set salary = y.c * 10000+salary where instructor.ID = y.ID;


