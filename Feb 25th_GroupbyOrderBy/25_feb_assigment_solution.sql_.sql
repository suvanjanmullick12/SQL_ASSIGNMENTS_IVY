use school_db
/*Q1*/
select count(*) as num_girl from student_blank sb 
join music mc 
on sb.ID=mc.ID 
where sex="f" and type="piano";
/*Q2 : Find the total number of house 
having females with average Maths testscore more>test*/
select 
select avg(mtest) into @avgmarks from student_blank

select count(*)as num_house 
from student_blank 
where sex="F" and @avgmarks > mtest /*Common Table Expression*/

select * from student_blank 
/*Q4 :List down the Districts codes from table student_blank*/
select Dcode from student_blank
/*Q4 :List down the Unique Districts codes from table student_blank*/
select DISTINCT Dcode from student_blank where Dcode is not null
/*Q4 :List down the district having more than 3 students?*/
select Dcode,count(*) from student_blank group by Dcode 
select * from student_blank

select distinct Mtest,count(*) as no_of_students
from student_blank group by fullname order by Mtest desc LIMIT 2

/*Q4 :How many districts have more than 5 students?*/
with NoofDistricts as
			(
			select count(*) as No_Count,Dcode 
			from student_blank group by Dcode 
			having No_Count>5)

select count(*) from NoofDistricts; /*Common Table Expression*/
 
 SELECT COUNT(*) AS DUMB_STUDENT FROM STUDENT_blank where Mtest < 95 
 SELECT COUNT(*) AS Scholar_STUDENT FROM STUDENT_blank where Mtest > 95
 /*how many Dumb and scholar students are there
 (scholar criteria- mtest >95. everyone else is dumb)*/
 
SELECT fullname,MTest,if(mtest> 95,"scholar","physco")as status from student_blank
 
 
 with Scholar_status as
			(
			SELECT fullname,MTest,
            if(mtest> 95,"scholar","physco")as status 
            from student_blank)
                          
select count(*)as Num_of_student,status from Scholar_status group by status;
 
 /*12.	Find the 4th lowest scorer in Maths and Phy test scores combined. */
 
 select fullname,sex,class,mtest from student_blank where 
mtest=(select distinct mtest from student_blank order by mtest desc limit 3,1) 

 select fullname,sex,class,PTest from student_blank where 
PTest=(select distinct PTest from student_blank order by PTest desc limit 3,1)

/*13.	Assign a roll number to each student after sorting their name alphabetically within each class. discused in next class 27/03/23*/


/*14.	Categorize the students into 3 categories: 
Scholars - Students who have scored more than 95 in Maths
Average - Students who have scored between 90 and 94 in Maths
Dumbs - Students who have scored less than 90 */

SELECT fullname,sex,class,mtest,
CASE
	WHEN mtest > 95 THEN 'Scholars'
	WHEN mtest BETWEEN 90 AND 94 then 'Average'
	ELSE 'dumbs'
END as Category
FROM student_blank;
---------------------------------------

---------------------------------------
SELECT ID, FullName, MTest,
  CASE 
    WHEN MTest > 95 THEN 'Scholars'
    WHEN MTest BETWEEN 90 AND 94 THEN 'Average'
    ELSE 'Dumbs'
  END AS Category
FROM student_blank;
--------------------------------------
/*15.	Use user defined variable to find the total number of girls in the student table. Then, show 10% of total no. of girls.*/

-- Find the total number of girls in the student_blank table
SET @total_girls := (SELECT COUNT(*) FROM student_blank WHERE Sex = 'F');

-- Show 10% of total number of girls
SELECT 0.1 * @total_girls AS Ten_Percent_Girls;

/*16.	Please refer to the table below as reference and do the questions listed as 1 and 2: 
	FullName	Mtest	Ptest	Higher of Mtest / Ptest 
	Kaushal	93	96	96	
	Prateek	99	92	99	
					
1	Higher of Mtest and Ptest for each student
2	Among the higher values, find the highest scorer */

select FullName,Mtest,ptest,
case 
   when mtest>ptest then  mtest
   else ptest
   end as Higher
   FROM student_blank;
   
   








