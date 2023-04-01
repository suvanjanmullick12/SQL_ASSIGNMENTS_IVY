create database sql_case_7
use sql_case_7;
/*Q1: In the school one teacher might be teaching more than one calss. 
Write a query to identitify how many classes each teacher is taking.*/

select teacher_id,count(*) as N0_OF_CLASSES from teacher_allocation group by teacher_id order by teacher_id asc;

/*Q2. It is interesting for teachers to come across students with names 
similar to their. John is one of the teahcer who finds this fascinating and 
wants to find out how many student 
in each class have names similar to his. Write a query to help find this data. */


SELECT c.class_id, COUNT(*) AS num_similar_names
FROM Class c
INNER JOIN Student s ON s.class_id = c.class_id
WHERE s.student_name LIKE '%John%'
GROUP BY c.class_id;

/* Q3. Every class teacher assigns unique roll number to their class students based 
on the alphabetical order of their names.
Can you help by writing a query that 
will assign roll number to each student in a class".*/

-- Generate unique roll numbers based on full name and class using row_number() function
-- Partition by class and order by full name to ensure alphabetical ordering
select row_number() over (partition by class_id order by student_name) as roll_number,student_id, student_name,class_id
from student;

/*Q4. The principal of the school want to understand the diversity of student in his school.
One of the important aspects is gender diversity. Provide a query that computes the male o female 
gender ratio in each class*/

SELECT 
  class_id, 
  SUM(CASE WHEN gender = 'M' THEN 1 ELSE 0 END) AS num_male_students,
  SUM(CASE WHEN gender = 'F' THEN 1 ELSE 0 END) AS num_female_students,
  ROUND(SUM(CASE WHEN gender = 'M' THEN 1 ELSE 0 END) / 
    SUM(CASE WHEN gender = 'F' THEN 1 ELSE 0 END), 2) AS gender_ratio
FROM student
GROUP BY class_id;

/* Q5. Every school has teacheer with different years of experience working in that school.
The principal wants to know the average experince of teachers at this school.*/
select YEAR(CURDATE())
SELECT AVG(YEAR(CURDATE()) - YEAR(date_of_joining)) AS avg_experience
FROM teacher;

/* Q6. At the end of the every year class teachers must provide students with 
their marks sheet for the whole year. The marks sheet of a student consists of exam(Quartery,half-yearly,etc)
wise makes obtained out of the total marks. Help them by writing a query that gives the student 
wise marks sheet.*/


SELECT student_name, exam_name, exam_subject, marks, marks/total_marks as MarksVsTotalMarks
FROM student st, exam_paper ept, exam et
WHERE st.student_id = ept.student_id and ept.exam_id = et.exam_id
order by 1, 2, 3

/* Q7.Every teacher has certain group of favourite students and keep track of their performance in exams.
A teacher approached you to find out the percentage attained by student with ids 1,4,9,16,25 in the "Quaterly"exam. Write a query to obtain
this data for each student.*/

SELECT st.student_id, et.exam_id, 
Format("Percent",marks/total_marks) as performance 
FROM student st, exam_paper ept, exam et
WHERE st.student_id = ept.student_id and
ept.exam_id = et.exam_id 
and st.student_id IN (1,4,9,16,25) and exam_name = "Quarterly"
order by 1, 2, 3;

/*Q8.Class Teacher assigns ranks to their student based on their marks obtained in each exam. 
Write a query to assign ranks(continuous) to students in each class for "Half-yearsly"exam */
select * from class;
select * from class_curriculum;
select * from exam;
select * from exam_paper;
select * from student;
select * from teacher;
select * from teacher_allocation;
SELECT ct.class_id, st.student_id, 
dense_rank() over (partition by ct.class_id order by sum(marks) DESC) as DRank  
FROM student st, exam_paper ept, exam et, class ct
WHERE ct.class_id = st.class_id AND st.student_id = ept.student_id AND ept.exam_id = et.exam_id AND exam_name = 'Half-yearly'
GROUP BY ct.class_id,st.student_id 
ORDER BY 1, 3 DESC;



