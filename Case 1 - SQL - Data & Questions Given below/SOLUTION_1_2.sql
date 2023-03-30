create database if exists STD;
USE STD;

/* 1a)List all the 2A students */

SELECT * FROM STUDENT;

SELECT * FROM STUDENT WHERE CLASS="2A" ;


/*b)	List the names and Math test scores of the 1B boys. */

select name,mtest FROM STUDENT WHERE class ="1B" and sex="M";


/*2.	a) 	List the classes, names of students whose names contain the letter "e" as the third letter.*/

SELECT class, name FROM student WHERE name LIKE '__e%';

/*b)	List the classes, names of students whose names start with "T" and do not contain "y". */
 
SELECT class, name FROM student WHERE name LIKE 'T%' AND name NOT LIKE '%y%';

/*c)	List the names of 1A students whose Math test score is not 51, 61, 71, 81, or 91. */

SELECT class, name FROM STUDENT WHERE CLASS='1A' AND MTEST NOT IN (51,61,71,81,91);

 
/*d)	List the students who were born between 22 March 1986 and 21 April 1986 */

SELECT * FROM STUDENT WHERE dob  between '22 March 1986' AND '21 April 1986';


/*3.	a) 	Find the number of girls living in TST.*/

SELECT COUNT(*)FROM STUDENT WHERE DCODE='TST'; 

/*b)	List the number of pass in the Math test of each class. (passing mark = 50)*/ 

SELECT name,class,MTEST FROM STUDENT WHERE MTEST>'50';

/*c)	List the number of girls grouped by each class */

SELECT COUNT(*) AS NUM_OF_STUDENT,CLASS FROM STUDENT WHERE SEX='F' GROUP BY CLASS

/*d)	List the number of girls grouped by the year of birth. */

SELECT COUNT(*) AS NUM_OF_STUDENT,DOB FROM STUDENT WHERE SEX='F' GROUP BY DOB;

/*e)	Find the average age of Form 1 boys. */

SET SQL_SAFE_UPDATES = 0;

Alter table student  add column AGE INT;

update student set AGE=timestampdiff(Year,birthdate,Current_Date()) 

select timestampdiff(Year,birthdate,Current_Date()) as Age_In_Years from student;

select avg(age) from student where sex="m";

/*4 a Find the average mark of mtest for each class. */

select class,avg(mtest)from student group by class

/*4 b)	Find the maximum mark of mtest for each sex. */

select sex,max(mtest)from student group by sex;

/*4 c)	Find the average mark of mtest for all students.*/

select avg(mtest) from student

/*5 a) List the students who are common members of the Physics Club and the Chemistry Club.*/ 

SELECT FullName
FROM phy 
WHERE FullName IN (SELECT FullName FROM chem)

/*5 b) 	b) 	List the students who are common members of the Chemistry Club and Biology Club but not of the Physics Club.*//
SELECT * FROM std.bio;
SELECT * FROM STD.CHEM;
SELECT * FROM std.PHY;


SELECT c.ID, c.FullName, c.Sex, c.Class
FROM chem c
JOIN bio b ON c.ID = b.ID
LEFT JOIN phy p ON c.ID = p.ID
WHERE p.ID IS NULL;



/*6  a)	Produce a list of parts in ascending order of quantity.*/

SELECT Descript,Qty
FROM client
ORDER BY Qty ASC


/* 6 b)	Produce a list of parts that consist of the keyword ‘Shaft’ in the description.*/

SELECT Descript,Qty
FROM client
WHERE Descript LIKE '%Shaft%';

/* 6 c)	Produce a list of parts that have a quantity more than 20 and are supplied by ‘China Metals Co.’*/ 
 	 	 
SELECT Descript,Qty,Supplier
FROM client
WHERE Qty > 20 AND Supplier = 'China Metals Co.';

/*6 d)	List all the suppliers without duplication.*/

select distinct Supplier
from client

/*6) e)	Increase the quantity by 10 for those parts with quantity less than 10.*/

SET SQL_SAFE_UPDATES = 0; 

UPDATE client
SET Qty = Qty + 10
WHERE qty < 10;

select *
from client

/*6 f)Delete records with part_no equal to 879, 654, 231 and 234 */

DELETE FROM client
WHERE part_no IN (879, 654, 231, 234);

select *
from client

/*6 g)	Add a field “Date_purchase” to record the date of purchase.*/

ALTER TABLE client
ADD Date_purchase date;

select *
from client
