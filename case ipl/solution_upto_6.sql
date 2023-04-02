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
 
























 




