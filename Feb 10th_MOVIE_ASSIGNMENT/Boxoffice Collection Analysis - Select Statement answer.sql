CREATE database boxoffice_db;
USE boxoffice_db
select *
from movie_details;

select *
from movie_commercials;

alter table movie_details
add column New_releasedate date;

set SQL_SAFE_UPDATES=0;


update movie_details
set New_releasedate =str_to_date(release_date,%d-%M-%y);

	
select movie_name,release_date
from  movie_details
where year(New_releasedate)=2020;/*Show the list of movies released in 2020.*/

SELECT movie_name,movie_total_worldwide
FROM movie_commercials
order by movie_total_worldwide desc
LIMIT 5; /*List the top 5 movies which grossed the highest collections across all years.*/
 
 SELECT  movie_name,producer,movie_genre
 from movie_details
 where producer="comedy";
 



                                     
