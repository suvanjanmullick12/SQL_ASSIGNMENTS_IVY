create database sql_case_8;
use sql_case_8;
create table deliveries(id int,inning int,`over` int,ball int,batsman varchar(50), # Using `over` because over is a reserved keyword for telling SQL know about the over as column name with integram as data type.
non_striker varchar(50),bowler varchar(50),
batsman_runs int,extra_runs int,total_runs int,is_wicket int,
dismissal_kind varchar(50),player_dismissed varchar(50),fielder varchar(50),extras_type varchar(50),
batting_team varchar(50),bowling_team varchar(50),venue varchar(50),match_date text);

/*5. Select the top 20 rows of the deliveries table. */
select * from deliveries limit 20;

/*6. Select the top 20 rows of the matches table. */
select * from matches limit 20;

/*7. Fetch data of all the matches played on 2nd May 2013.*/
# Intinally we have to convert the data column into the formatted SQL format in order to fetch the data of 2nd May 2013.
SET SQL_SAFE_UPDATES = 0;/*deactivating the safe update mode */

select match_date from deliveries;

select * from deliveries limit 30;
select STR_TO_DATE(match_date, "%d-%m-%Y") as t1 from deliveries
select STR_TO_DATE(match_date, "%d/%m/%Y") as t2  from deliveries 

select if(match_date like "%/%", str_to_date(match_date,"%d/%m/%Y"), str_to_date(match_date,"%d-%m-%Y")) from matches limit 15,35

select * from matches;
select match_date, if(match_date like "%/%", str_to_date(match_date,"%d/%m/%Y"), str_to_date(match_date,"%d-%m-%Y")) as formated
from deliveries limit 800; # This is just used for testing. 

# if statment er contion -- if(<condition>,TRUE,FALSE)

ALTER TABLE deliveries add column NEW_DATE date;
update deliveries set NEW_DATE = if(match_date like "%/%", str_to_date(match_date,"%d/%m/%Y"), str_to_date(match_date,"%d-%m-%Y")) limit 800;
ALTER TABLE matches add column NEW_DATE_1 date;
update matches set NEW_DATE_1 = if(`date` like "%/%", str_to_date(`date`,"%d/%m/%Y"), str_to_date(`date`,"%d-%m-%Y"));
select * from matches limit 100;
select * from deliveries limit 100;
 
/* 8. Fetch data of all the matches where the margin of victory is more than 100 runs. */
select * from matches;

select *
from matches
where result="runs" and result_margin > 100;

/*9. Fetch data of all the matches where the final scores of both teams tied and order it in descending order of the date. */
select * from matches;
select *
from matches
where result='tie' order by NEW_DATE_1 desc;

----------------------------------------------ENOUGH IS ENOUGH

/*10. Get the count of cities that have hosted an IPL match.*/
select city, count(*) as CityCount
from matches
group by city;

/*11. Create table deliveries_v02 with all the columns of deliveries and an additional 
column ball_result containing value boundary, dot or other depending on the total_run 
(boundary for >= 4, dot for 0 and other for any other number)*/

select * from deliveries;

CREATE TABLE deliveries_v02deliveries_v02 AS
SELECT *
FROM deliveries; # Copy Process Has Been Complete with the Create Table and Select Stement. 
SET SQL_SAFE_UPDATES = 0;

UPDATE deliveries_v02
SET ball_result = CASE
  WHEN total_runs >= 4 THEN 'boundary'
  WHEN total_runs = 0 THEN 'dot'
  ELSE 'other'
END
WHERE deliveries_v02.id = deliveries_v02.id;

select * from deliveries_v02;

Alter table deliveries_v02 add ball_result varchar(10);

select * from deliveries_v02;

/*12.Write a query to fetch the total number of boundaries and dot balls */

select ball_result,count(*) as no_of_balls
from deliveries_v02
where ball_result in ("boundary","dot")
group by ball_result limit 800;

/*13.Write a query to fetch the total number of boundaries scored by each team */

select batting_team,count(*) as number_of_boundaries
from deliveries_v02
where ball_result like "boundary"
group by batting_team limit 800;

/*14.Write a query to fetch the total number of dot balls bowled by each team*/

select bowling_team,count(*) as no_of_balls
from deliveries_v02
where ball_result in ("dot")
group by bowling_team limit 800;

/*15.Write a query to fetch the total number of dismissals by dismissal kinds*/

select * from deliveries_v02;

select dismissal_kind,count(*) as number_of_dismissals
from deliveries_v02
group by dismissal_kind limit 1,800;

/*16.Write a query to get the top 5 bowlers who conceded maximum extra runs*/

select * from deliveries_v02;

select distinct bowler, sum(extra_runs) as ExtrasConceded
from deliveries_v02
where extras_type <> "NA"
group by bowler
order by sum(extra_runs) desc
limit 5;

/*17.  Write a query to create a table named deliveries_v03 with all the columns of deliveries_v02 table 
and two additional column (named venue and match_date) of venue and date from table matches.*/

create table deliveries_v03 as select * from deliveries_v02; # Copy Done From deliveries_02 table to deliveries_03 with new column name. 
select 
alter table deliveries_v03 add column named_venue varchar(50) ,add column date_new_01 date;

select * from deliveries_v03;


update deliveries_v02 set matches_date_1 = if(match_date like "%/%",STR_TO_DATE(match_date,"%d/%m/%Y"),STR_TO_DATE(match_date,"%d-%m-%Y")) limit 800;

select * from deliveries_v02;

alter table deliveries_v03 drop named_venue;

alter table deliveries_v03 drop match_date_3;

alter table deliveries_v03 drop matches_date_1;

select * from deliveries_v03;

update deliveries_v03 set named_venue = venue 
where deliveries_v03.id=deliveries_v03.id;

update deliveries_v03 set date_new_01 = NEW_DATE
where deliveries_v03.id=deliveries_v03.id;

create table deliveries_v02
select *, case
when total_runs >= 4 then "boundary"
when total_runs = 0 then "dot"
else "other"
end as ball_result
from ipl_ball;
 
select ball_result from deliveries_v02;

/*18. Write a query to fetch the total runs scored for each venue and order it in the 
descending order of total runs scored.*/

select distinct named_venue,sum(total_runs) as TotalRuns 
from deliveries_v03
group by named_venue
order by TotalRuns desc LIMIT 1,800;

select distinct venue, sum(total_runs) as TotalRuns
from deliveries_v03
group by venue
order by TotalRuns desc;

/*19. Write a query to fetch the year-wise total runs scored at Eden Gardens and order 
it in the descending order of total runs scored.*/

SELECT YEAR(NEW_DATE) AS YEARS,sum(total_runs) as TotalRuns
FROM  deliveries_v03
WHERE named_venue="Eden Gardens"
GROUP BY YEARS
order by TotalRuns desc;


/*20. Get unique team1 names from the matches table, you will notice that there are two 
entries for Rising Pune Supergiant one with Rising Pune Supergiant and another one with 
Rising Pune Supergiants. Your task is to create a matches_corrected table with two additional 
columns team1_corr and team2_corr containing team names with replacing Rising Pune Supergiants 
with Rising Pune Supergiant. Now analyse these newly created columns. */


alter table matches add column team1_corr varchar(50),add column team2_corr varchar(50);
select * from matches;
CREATE VIEW corr_2 as
select if(team1="Rising Pune Supergiant","Rising Pune Supergiants",team1)
from matches
where team1=team1;
 #if(<Condition>,"OUTPUT" if <condition> is true,"OUTPUT" if <condition> is false) - Correct Answer. 
select if(team1="Rising Pune Supergiant","Rising Pune Supergiants",team1) from matches;# code written 

update matches set team1_corr=if(team1="Rising Pune Supergiant","Rising Pune Supergiants",team1) 
update matches
set team1_corr = if(team1 = "Rising Pune Supergiants", "Rising Pune Supergiant", team1),
        team2_corr = if(team2 = "Rising Pune Supergiants", "Rising Pune Supergiant", team2);
select * from matches;
alter table matches drop team1_corr,drop team2_corr;
select * from matches; # back to the original form 

create table matches_corrected as select * from matches; 

drop table matches_corrected;


alter tables matches_corrected 
select * from matches_corrected;


create table matches_corrected as select * from matches;

alter table matches_corrected add column team1_corr varchar(50),add column team2_corr varchar(50);

select * from matches_corrected;

update  matches_corrected
set team1_corr = if(team1 = "Rising Pune Supergiants", "Rising Pune Supergiant", team1),
        team2_corr = if(team2 = "Rising Pune Supergiants", "Rising Pune Supergiant", team2);

select * from matches_corrected;



# Drop the team1 old and team2 old. 
# display matchess_corrected 
# Now it time to run the if statement loop from which table ???? 

# QueryError Will be found regarding missing team1 and team2 
#as if statement condition opeation of team 1 _old and team2 old. 
# first update from old team we will need the older version. 
# then drop it. 
 
/*21. Compare the total count of rows and total count of distinct ball_id in deliveries_v04;*/

select count(distinct id) as DitinctMatches, count(id) as TotalRows
from matches_corrected;
                                                                                                      
                                                                                                      
/*																							
22.Create table deliveries_v05 with all columns of deliveries_v04 and an additional column for 
row number partition over ball_id. (HINT : row_number() over (partition by ball_id) as r_num) */

