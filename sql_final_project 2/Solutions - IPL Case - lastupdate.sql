/*Create a new database ipl*/
create database ipl;

use ipl; -- default it

-- create a new table ipl_ball
CREATE TABLE ipl_ball (
id int NOT NULL,
inning int,
`over` int,
ball int,
batsman text,
non_striker text,
bowler text,
batsman_runs int,
extra_runs int,
total_runs int, 
is_wicket bit,
dismissal_kind text,
player_dismissed text,
fielder text,
extras_type text,
batting_team text,
bowling_team text,
venue text,
match_date text
);

/* import the data ipl_ball csv data into the new table using command line prompt using the following LOAD command: 

LOAD DATA LOCAL INFILE 'D:\\_Ivy Professional School\\_Data Analytics\\Course Design
\\SQL - RDBMS\\Share With Students\\SQL Case Studies\\SQL Case Study\\SQL Case 9 - IPL Case\\IPL_Ball.csv' 
INTO TABLE ipl_ball 
FIELDS TERMINATED BY "," 
OPTIONALLY ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n' IGNORE 1 ROWS;

*Don't forget to replace the file path with your file path from your computer folder.
*/

select count(*) from ipl_ball; -- verify the total row count of the data imported

select * from ipl_ball limit 20;

-- Next, we'll convert the match_date column values from text to date data type
select match_date, if(match_date like "%/%", str_to_date(match_date,"%d/%m/%Y"), str_to_date(match_date,"%d-%m-%Y"))
from ipl_ball;

-- add a new column match_date_new with date data type
alter table ipl_ball
add column match_date_new date;

set sql_safe_updates = 0; -- disable the safe update mode to allow bulk update

-- update the match_date_new with the date values. We'll use two str_to_date functions as the match_date contains two types of dates
update ipl_ball 
set match_date_new = if(match_date like "%/%", str_to_date(match_date,"%d/%m/%Y"), str_to_date(match_date,"%d-%m-%Y"));

select match_date_new from ipl_ball limit 30; -- verify the new date column's values.

create table matches(id	INT, 
city	varchar(100), 
date	varchar(100), 
player_of_match	varchar(100),
venue	varchar(200), 
neutral_venue	bit, 
team1	varchar(100),
team2	varchar(100), 
toss_winner	varchar(100), 
toss_decision	varchar(100), 
winner	varchar(100), 
result	varchar(100), 
result_margin	INT, 
eliminator	char(10),
method	varchar(100), 
umpire1	varchar(100),
umpire2 varchar(100)
);

/*Import the data from csv file into the matches table: 

LOAD DATA LOCAL INFILE 'D:\\_Ivy Professional School\\_Data Analytics\\Course Design\\SQL - RDBMS\\Share With Students\\SQL Case Studies\\SQL Case Study\\SQL Case 9 - IPL Case\\IPL_matches.csv' 
INTO TABLE matches 
FIELDS TERMINATED BY "," 
OPTIONALLY ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n' IGNORE 1 ROWS;

*/
select count(*) from matches;

select * from matches limit 20;

-- Next, we'll convert the date column values from text to date data type
select date, if(date like "%/%", str_to_date(date,"%d/%m/%Y"), str_to_date(date,"%d-%m-%Y"))
from matches;

-- add a new column match_date_new with date data type
alter table matches
add column date_new date;

set sql_safe_updates = 0; -- disable the safe update mode to allow bulk update

-- update the match_date_new with the date values. We'll use two str_to_date functions as the match_date contains two types of dates
update matches
set date_new = if(date like "%/%", str_to_date(date,"%d/%m/%Y"), str_to_date(date,"%d-%m-%Y"));

select date_new from matches limit 30; -- verify the new date column's values.

-- q5
select *
from ipl_ball
limit 20;

-- q6
select *
from matches
limit 20;

-- q7
select * 
from matches
where date_new="2013-05-02";

/*8. Fetch data of all the matches where the margin of victory is more than 100 runs.*/
select *
from matches
where result="runs" and result_margin > 100;

/*9. Fetch data of all the matches where the final scores of both teams tied and order it 
in descending order of the date.*/
select *
from matches
where result="tie"
order by date_new desc;

/*10. Get the count of cities that have hosted an IPL match.*/
select city, count(*) as CityCount
from matches
group by city;

/*11. Create table deliveries_v02 with all the columns of deliveries and an additional 
column ball_result containing value boundary, dot or other depending on the total_run 
(boundary for >= 4, dot for 0 and other for any other number)*/
create table deliveries_v02
select *, case
when total_runs >= 4 then "boundary"
when total_runs = 0 then "dot"
else "other"
end as ball_result
from ipl_ball;
 
select ball_result from deliveries_v02;

/*12. Write a query to fetch the total number of boundaries and dot balls.*/
select ball_result, count(*) as Total
from deliveries_v02
where ball_result in ("boundary","dot")
group by ball_result;

/*13. Write a query to fetch the total number of boundaries scored by each team.*/
select distinct batting_team, count(*) as Total_Boundaries
from deliveries_v02
where ball_result="boundary"
group by batting_team;

/*14. Write a query to fetch the total number of dot balls bowled by each team.*/
select distinct bowling_team, count(*) as Total_Dots
from deliveries_v02
where ball_result="dot"
group by bowling_team;

/*15. Write a query to fetch the total number of dismissals by dismissal kinds.*/
select dismissal_kind, count(*) as Total_Dismissals
from deliveries_v02
where dismissal_kind <> "NA"
group by dismissal_kind;

select distinct extras_type from deliveries_v02;

/*16. Write a query to get the top 5 bowlers who conceded maximum extra runs.*/
select distinct bowler, sum(extra_runs) as ExtrasConceded
from deliveries_v02
where extras_type <> "NA"
group by bowler
order by sum(extra_runs) desc
limit 5;

/*17. Write a query to create a table named deliveries_v03 with all the columns of deliveries_v02 table 
and two additional column (named venue and match_date) of venue and date from table matches.*/
create table deliveries_v03
select dv2.id, inning, `over`, ball, batsman, non_striker, bowler, batsman_runs, extra_runs, total_runs, is_wicket, 
dismissal_kind, player_dismissed, fielder, extras_type, batting_team, bowling_team, ball_result,
m.venue, date_new
from deliveries_v02 dv2 inner join matches m using(id);                                             

/*18. Write a query to fetch the total runs scored for each venue and order it in the 
descending order of total runs scored.*/
select distinct venue, sum(total_runs) as TotalRuns
from deliveries_v03
group by venue
order by TotalRuns desc;

/*19. Write a query to fetch the year-wise total runs scored at Eden Gardens and order 
it in the descending order of total runs scored.*/
select year(date_new) as Years, sum(total_runs) as TotalRunsScored
from deliveries_v03
where venue = "Eden Gardens"
group by Years
order by TotalRunsScored desc;

/*20. Get unique team1 names from the matches table, you will notice that there are two 
entries for Rising Pune Supergiant one with Rising Pune Supergiant and another one with 
Rising Pune Supergiants. Your task is to create a matches_corrected table with two additional 
columns team1_corr and team2_corr containing team names with replacing Rising Pune Supergiants 
with Rising Pune Supergiant. Now analyse these newly created columns. */
select distinct team1
from ipl_matches;

create table matches_corrected
select * from matches;

alter table matches_corrected
add column team1_corr varchar(225),
add column team2_corr varchar(225);

set SQL_SAFE_UPDATES=0;

update matches_corrected
set team1_corr = if(team1 = "Rising Pune Supergiants", "Rising Pune Supergiant", team1),
        team2_corr = if(team2 = "Rising Pune Supergiants", "Rising Pune Supergiant", team2);

select distinct team1_corr
from matches_corrected;

select distinct team2_corr
from matches_corrected;

/*21. Create a new table deliveries_v04 with the first column as ball_id containing information 
of match_id, inning, over and ball separated by - (For ex. 335982-1-0-1 match_id-inning-over-ball) 
and rest of the columns same as deliveries_v03) */

create table deliveries_v04 
select *, concat(id, "-",inning,"-", `over`,"-", ball) as ball_id
from deliveries_v03;

select * from deliveries_v04;

/*22. Compare the total count of rows and total count of distinct ball_id in deliveries_v04; 
*/
select count(distinct id) as DitinctMatches, count(ball_id) as TotalRows
from deliveries_v04;

/*23. Create table deliveries_v05 with all columns of deliveries_v04 and an additional column for 
row number partition over ball_id. (HINT : row_number() over (partition by ball_id) as r_num) */
create table deliveries_v05
select *, row_number() over (partition by ball_id) as r_num
from deliveries_v04;

/*24. Use the r_num created in deliveries_v05 to identify instances where ball_id is repeating. 
(HINT : select * from deliveries_v05 WHERE r_num=2;) */
select *
from deliveries_v05
where r_num = 2;

/*25. Use subqueries to fetch data of all the ball_id which are repeating. 
(HINT: SELECT * FROM deliveries_v05 WHERE ball_id in (select BALL_ID from deliveries_v05 WHERE r_num=2); */
select *
from deliveries_v05
where ball_id in (select BALL_ID from deliveries_v05 WHERE r_num=2);
