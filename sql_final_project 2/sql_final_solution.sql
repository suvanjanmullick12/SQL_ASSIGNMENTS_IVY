create database SQL_PROJECT_1
/* Before Solving the Questions it is important to set the SQL Constranint which is mentioned in the Question 5. */
-----------------
/*Q1-Create a table “Station”  to store information about weather observation stations:
ID Number Primary Key 
CITY CHAR(20), 
STATE CHAR(2), 
LAT_N Number 
LONG_W Number*/
use SQL_PROJECT_1;
create table Station(ID int,CITY CHAR(20),STATE CHAR(2),LAT_N int,LONG_W int,PRIMARY KEY(ID));
describe Station;
-----------------------------
/*Q2-Insert the following records into the table:
ID CITY STATE LAT_N LONG_W 
13 Phoenix AZ 33 112 
44 Denver CO 40 105 
66 Caribou ME 47 68*/

insert into Station values (13,"Phoenix","AZ",33,112 ),(44,"Denver","CO",40,105),(66,"Caribou","ME",47,68);
--------------------------------------------------
/*Q3 Execute a query to look at table STATION in undefined order.*/
select * from  Station;
-----------------------------------------------------
/* 4. Execute a query to select Northern stations (Northern latitude > 39.7).*/
select * from  Station  where LAT_N > 39.7;
------------------------------------------------------
/* 5.Create another table, ‘STATS’, to store normalized temperature and precipitation data:
Column Data type Remark
ID Number must match some STATION table ID(so name & location
will be known).
MONTH Number Range between 1 and 12
TEMP_F Number in Fahrenheit degrees,Range between -80 and 150,
RAIN_I Number in inches, Range between 0 and 100,
There will be no Duplicate ID and MONTH combination.*/

create table STATS(ID int,MONTH int,TEMP_F float,RAIN_I float);
describe stats

------------------------------------------------------

/* 6.Populate the table STATS with some statistics for January and July:
ID MONTH TEMP_F RAIN_I
13 1 57.4 .31
13 7 91.7 5.15
44 1 27.3 .18
44 7 74.8 2.11
66 1 6.7 2.1
66 7 65.8 4.52*/

insert into STATS values(13,1,57.4,.31),(13,7,91.7,5.15),(44,1,27.3,.18),(44,7,74.8,2.11),(66,1,6.7,2.1),(66,7,65.8,4.52);
select * from STATS;
------------------------------------------------------
/*7.Execute a query to display temperature stats (from STATS table) for each city (from Station
table).*/
select * from Station Sn RIGHT JOIN STATS St ON Sn.id=St.id;
select St.TEMP_F,Sn.CITY from Station Sn RIGHT JOIN STATS St ON Sn.id=St.id;
--------------------------------------------
/*8.Execute a query to look at the table STATS, ordered by month and greatest rainfall, with
columns rearranged. It should also show the corresponding cities.*/
select St.MONTH, St.RAIN_I,Sn.City from Station Sn RIGHT JOIN STATS St ON Sn.id=St.id order by St.RAIN_I desc;
--------------------------------------------
/*9.Execute a query to look at temperatures for July from table STATS, lowest temperatures first,
picking up city name and latitude.*/
select St.TEMP_F,Sn.LAT_N,Sn.City,St.MONTH from Station Sn RIGHT JOIN STATS St ON Sn.id=St.id WHERE MONTH=7 order by St.TEMP_F Asc;
------------------------------------------------------------------------------------------------------
/*10.Execute a query to show MAX and MIN temperatures as well as average rainfall for each city.*/

select * from Station Sn RIGHT JOIN STATS St ON Sn.id=St.id; /* STEP 1: DEVELOPED THIS QUERY TO SOLVE THE ANSWER*/

select max(St.TEMP_F) as Max_Temp,min(St.TEMP_F) as Min_Temp,Avg(St.TEMP_F) as Avg_Temp,Sn.CITY  
from Station Sn RIGHT JOIN STATS St ON Sn.id=St.id 
group by Sn.CITY; 
---------------------------------------------------------------
/*11.Execute a query to display each city’s monthly temperature in Celcius and rainfall in
Centimeter.*/
 
 select Sn.CITY,TEMP_F,((st.temp_f- 32) * 5/9) as TEMP_C,(St.RAIN_I/0.39370) as RAIN_CM,St.RAIN_I 
from Station Sn RIGHT JOIN STATS St ON Sn.id=St.id; 

---------------------------------------------------------------
/*12.Update all rows of table STATS to compensate for faulty rain gauges known to read 0.01
inches low.*/
 select * from Stats
 SET SQL_SAFE_UPDATES = 0;
UPDATE STATS SET RAIN_I = RAIN_I + 0.01; /* UPDATING THE VALUE OF RAIN_I BY ADDING 0.01*/
 select * from Stats
 --------------------------------------------------------------
 /*13. Update Denver's July temperature reading as 74.9*/
UPDATE STATS SET TEMP_F = 74.9  /* Changed From TEMP_F 74.8 to 78.9*/
WHERE ID = 44
AND MONTH = 7;
select * from Stats
--------------------------------------------------------------

