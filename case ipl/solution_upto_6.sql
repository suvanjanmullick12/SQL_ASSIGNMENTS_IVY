create DATABASE CASE_IPL;

USE CASE_IPL;

create table deliveries(id int,inning int,`over` int,ball int,batsman varchar(50),non_striker varchar(50),bowler varchar(50) ,batsman_runs int,
extra_runs int,total_runs int,is_wicket int,dismissal_kind varchar(50),player_dismissed varchar(50),
fielder varchar(50),extras_type varchar(50),batting_team varchar(50),bowling_team varchar(50),venue varchar(50),match_date text);

create table matches(id int,city varchar(50),`date` text,player_of_match varchar(50),venue varchar(50),neutral_venue int,team1 varchar(50),
team2 varchar(50),toss_winner varchar(50),toss_decision varchar(50),winner varchar(50),result varchar(50),result_margin int,eliminator varchar(50),method varchar(50),
umpire1 varchar(50),umpire2 varchar(50));

/*5.Select the top 20 rows of the deliveries table.*/

select * from deliveries limit 20;

/*6. Select the top 20 rows of the matches table. */

select * from  matches limit 20;

/*7. Fetch data of all the matches played on 2nd May 2013*/

SET SQL_SAFE_UPDATES = 0;

Alter table deliveries add column matches_date_1 date;

select STR_TO_DATE(match_date,"%d-%m-%Y") as t1 from deliveries  # This is for viewing and testing 
select STR_TO_DATE(match_date,"%d/%m/%Y") as t2 from deliveries 

select match_date,if(match_date like "%/%",STR_TO_DATE(match_date,"%d/%m/%Y"),STR_TO_DATE(match_date,"%d-%m-%Y")) as formated from deliveries limit 800;

# Now its time to update after viewing and chekcing . 

update deliveries set matches_date_1 = if(match_date not like "%/%",STR_TO_DATE(match_date,"%d-%m-%Y"),STR_TO_DATE(match_date,"%d/%m/%Y")) limit 800;

select * from deliveries limit 50;

alter table matches add column NEW_DATE_1 date;

update matches set  NEW_DATE_1 = if(`date` like "%/%",STR_TO_DATE(`date`,"%d/%m/%Y"),STR_TO_DATE(`date`,"%d-%m-%Y"));

select * from matches limit 100;



/* 8. Fetch data of all the matches where the margin of victory is more than 100 runs.*/
select * from matches
select * 
from matches
where result="runs" and result_margin > 100;  

/*9. Fetch data of all the matches where the final scores of both teams tied and order it in descending order of the date. */

select * 
from matches
where result="tie" 
order by NEW_DATE_1 desc;
 
/* 10. Get the count of cities that have hosted an IPL match. */

select * from matches

select city,count(*)
from matches
group by city;

/*11.Create table deliveries_v02 with all the columns of deliveries and an additional column ball_result containing value boundary,
 dot or other depending on the total_run (boundary for >= 4, dot for 0 and other for any other number) */

create table deliveries_v02 (id int,inning int,`over` int,ball int,batsman varchar(50),non_striker varchar(50),bowler varchar(50) ,batsman_runs int,
extra_runs int,total_runs int,is_wicket int,dismissal_kind varchar(50),player_dismissed varchar(50),
fielder varchar(50),extras_type varchar(50),batting_team varchar(50),bowling_team varchar(50),venue varchar(50),match_date text,ball_result varchar(100));
 /*Again using command promt from the file name 'IPL_Ball.csv'*/
 
select * from deliveries_v02;

select *,case
when total_runs >= 4 then "boundary"
when total_runs = 0 then "dot"
else "other"
end as ball_result
from deliveries_v02;


/*12.Write a query to fetch the total number of boundaries and dot balls */

UPDATE deliveries_v02
SET ball_result = CASE
  WHEN total_runs >= 4 THEN 'boundary'
  WHEN total_runs = 0 THEN 'dot'
  ELSE 'other'
END
WHERE deliveries_v02.id = deliveries_v02.id;

select * from deliveries_v02;

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

select * from matches

alter table deliveries_v02 add column matches_date_1 date;

update deliveries_v02 set matches_date_1 = if(match_date like "%/%",STR_TO_DATE(match_date,"%d/%m/%Y"),STR_TO_DATE(match_date,"%d-%m-%Y")) limit 800;

select * from deliveries_v02;

create table deliveries_v03(id int,inning int,`over` int,ball int,batsman varchar(50),
non_striker varchar(50),bowler varchar(50),batsman_runs int,
extra_runs int,total_runs int,is_wicket int,dismissal_kind varchar(50),player_dismissed varchar(50),
fielder varchar(50),extras_type varchar(50),batting_team varchar(50),bowling_team varchar(50),venue varchar(50),
match_date text,ball_result varchar(100),matches_date_1 date,named_venue varchar(100),match_date_3 date);

alter table deliveries_v03 drop named_venue;

alter table deliveries_v03 drop match_date_3;

alter table deliveries_v03 drop matches_date_1;

select * from deliveries_v03;













 




