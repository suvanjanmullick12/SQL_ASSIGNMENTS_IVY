SELECT STR_TO_DATE("Aug 10 2017", "%M %d %Y");





CREATE database boxoffice_db;
USE boxoffice_db
select *
from movie_details;

select *
from movie_commercials;

alter table movie_details
add column New_releasedate date;

set SQL_SAFE_UPDATES=0;
-----------------------

----------------------------
update movie_details
set New_releasedate = str_to_date(release_date,"%d-%M-%y");
	
select movie_name,release_date
from  movie_details
where year(New_releasedate)=2020;/*Q1:Show the list of movies released in 2020.*/

SELECT movie_name,movie_total_worldwide
FROM movie_commercials
order by movie_total_worldwide desc
LIMIT 5; /*Q2:List the top 5 movies which grossed the highest collections across all years.*/
 
select producer,movie_genre,movie_name,release_date
from movie_details 
where year(New_releasedate)=2019 AND movie_genre="Comedy";
/*Q3:List the name of the producers who has produced comedy movies in 2019.*/
------------------------------------------------
SELECT movie_name, runtime
FROM movie_details
WHERE year(New_releasedate) = 2020
order by runtime asc
limit 1;/*Q4:Which movie in 2020 had the shortest duration?*/
---------------------------------------------------

select movie_name,movie_opening,movie_weekend 
from movie_commercials 
order by movie_weekend desc limit 1
/*Q5:List the movie with the highest opening weekend. 
Is this the same movie which had the highest overall collection?*/
select movie_name,movie_opening,movie_weekend 
from movie_commercials 
order by movie_total_worldwide desc limit 1 
/*Ans:By analysing both results are not similar. movie with the high was War and in the other part it is Padmavat.*/
-----------------------------------------------------------------------------------
select movie_name,movie_weekend,movie_firstweek
from movie_commercials where  movie_weekend=movie_firstweek;
/*Q6:List the movies which had the weekend collectio same as the first week collection*/
----------------------------------------------------------------
/*Q7:List the top 3 movies with the highest foreign collection.*/
select movie_name,movie_total_worldwide
from movie_commercials 
order by movie_total_worldwide desc limit 3
----------------------------------------------------------------
/*Q8:List the movies that were released on a non-weekend day.*/
select movie_name,DAYNAME(New_releasedate),New_releasedate 
from movie_details 
where DAYNAME(New_releasedate) IN ('Monday','Tuesday','Wednesday','Thursday','Friday')
------------------------------------------------------
/*Q9:List the movies by Reliance Entertainment which were non comedy.*/
select *
from movie_details 
where banner="Reliance Entertainment" AND movie_genre <>"Comedy";
-------------------------------------------------------
/*10:List the movies produced in the month of October, November,and December that were released on the weekends.*/
SELECT movie_name, release_date, DAYNAME(New_releasedate) as release_day
FROM movie_details
WHERE month(New_releasedate) IN (10, 11, 12)
AND DAYNAME(New_releasedate) IN ('Wednesday', 'Thursday');

