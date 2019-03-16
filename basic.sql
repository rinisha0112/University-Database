# Query 1
select name from instructor where dept_name ='Biology';

# Query 2
select title from course where dept_name='Comp. Sci.' and credits = 3;

# Query 3
select course_id, title from course where course_id in ( select course_id from takes where ID=12345);

#Query 4(notsure!)

select course_id, title, sum(credits) as total_credits from course  where course_id  in ( select course_id from takes where ID=12345) group by (course_id);

#create view course_credit as(select course_id, title, (credits)  from course where course_id in ( select course_id from takes where ID=12345));

#Query 5 

select ID,takes.course_id, title, sum(credits) as total_credits from course,takes  where course.course_id=takes.course_id group by (course_id);

#Query 6

select distinct name from student, takes where
( student.ID=takes.ID and
	takes.course_id like 'CS-%');


# Query 7

select ID from instructor where ID not in(select ID from teaches);
    
# Query 8

select ID, name from instructor where ID not in(select ID from teaches);

# Query 9 and Query 10, 11, 12, 13 in create_movie.sql






