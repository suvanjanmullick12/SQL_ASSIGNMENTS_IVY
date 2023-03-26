create database case4_taxi;
use case4_taxi
/* Question 1.Find hour of 'pickup' and 'confirmed_at' time, and make a column of weekday as "Sun,Mon, etc"next to pickup_datetime	*/	
SELECT pickup_datetime,
       EXTRACT(hour FROM pickup_time) AS pickup_hour,
       EXTRACT(hour FROM confirmed_at) AS confirmed_hour,
       UPPER(SUBSTR(DATE_FORMAT(pickup_datetime, '%a'), 1, 3)) AS weekday
FROM Data; /* Why this code is not running? Please question yourself. */
describe data;
SELECT pickup_datetime,
       DATE_FORMAT(STR_TO_DATE(pickup_time, '%H:%i:%s'), '%H') AS pickup_hour,
       DATE_FORMAT(STR_TO_DATE(confirmed_at, '%d-%m-%Y %H:%i'), '%H') AS confirmed_hour,
       UPPER(SUBSTR(DATE_FORMAT(STR_TO_DATE(pickup_datetime, '%d-%m-%Y %H:%i'), '%a'), 1, 3)) AS weekday
FROM Data;
/*Question2. Make a table with count of bookings with booking_type = p2p catgorized by booking mode as 'phone', 'online','app',etc*/
SELECT Booking_mode, Count(*) as Cnt
FROM data 
WHERE booking_type = "p2p"
Group by Booking_mode;				
/*	Question 3.Create columns for pickup and drop ZONES (using Localities data containing Zone IDs against each area) 
and fill corresponding values against pick-area and drop_area, using Sheet'Localities'*/
select * from data;
select * from localities where Area='Airport Terminal 1';
------------------------------------------------/*Not Running Code*/-----------------------------------
SELECT d.*, p.zone_id AS pickup_zone_id, p.Area AS pickup_zone,
       drop.zone_id AS drop_zone_id, drop.Area AS drop_zone
FROM Data d
LEFT JOIN Localities p ON d.PickupArea = p.Area
LEFT JOIN Localities drop ON d.DropArea = drop.Area; 
/*Error Code: 1064. You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'drop ON d.DropArea = drop.Area' at line 5*/
/*The issue might be related to using "drop" as a table alias, which is a reserved keyword in SQL. You can try enclosing the alias in backticks to avoid this issue.*/
------------------------------------------------/*Running Code*/-----------------------------------
SELECT d.*, p.zone_id AS pickup_zone_id, p.Area AS pickup_zone,
       `drop`.zone_id AS drop_zone_id, `drop`.Area AS drop_zone
FROM Data d /*d.* means that we want to select all columns from the Data table, which is aliased as d in this query.*/
LEFT JOIN Localities p ON d.PickupArea = p.Area
LEFT JOIN Localities `drop` ON d.DropArea = `drop`.Area;
------------------------------------------------/*Running Code-Read for Explanation*/-----------------------------------
/*Read Me:Multiple joins is used here:: The LEFT JOIN clause is used to combine rows from two or more tables based on a related column between them. 
It returns all the rows from the left table (Data table in this case), and the matched rows from the right table (Localities table), 
and NULL values for the columns in the right table where there is no match.
In this query, we are using a LEFT JOIN to join the Data table with the Localities table based on the Area columns in both tables. 
Specifically, we are joining the Data table with the Localities table twice - once for the PickupArea column and once for the DropArea column.
The line LEFT JOIN Localities 'drop' ON d.DropArea = 'drop'.Area is joining the Data table with the Localities table on the DropArea column 
in the Data table and the Area column in the Localities table. We are aliasing the Localities table as drop to make the SQL code more readable.
This join is necessary because we want to retrieve the zone_id and Area values for the drop-off locations in the Data table, 
and this information is stored in the Localities table. By joining the two tables on the Area column, 
we can link the Data table rows with the corresponding zone_id and Area values from the Localities table.*/
/* Question4: Find top 5 drop zones in terms of  average revenue*/
SELECT
  `drop`.Area AS drop_zone,
  AVG(Fare) AS avg_revenue
FROM
  Data d
  LEFT JOIN Localities `drop` ON d.DropArea = `drop`.Area
GROUP BY
  `drop`.Area
ORDER BY
  avg_revenue DESC
LIMIT
  5;

/* Pseudo Version of Code */
SELECT
  drop_zone,
  AVG(revenue) AS avg_revenue
FROM
  (
    SELECT
      d.DropArea,
      l.Area AS drop_zone,
      d.Fare AS revenue
    FROM
      Data d
      LEFT JOIN Localities l ON d.DropArea = l.Area
  ) trips
GROUP BY
  drop_zone
ORDER BY
  avg_revenue DESC
LIMIT
  5;
/*Explanation:
Explanation:
We first join the Data and Localities tables on the DropArea and Area columns, respectively, to get the drop zone for each trip.
We use a subquery to calculate the revenue for each trip and include the drop zone as well.
We then group the trips by the drop zone and calculate the average revenue for each drop zone using the AVG() function.
We sort the result in descending order of the average revenue using the ORDER BY clause.
We limit the result to the top 5 rows using the LIMIT clause.*/
------------------------------------------
/*Question 5:Find all unique driver numbers grouped by top 5 pickzones*/

Create View Top5PickZones As
SELECT zone_id, Sum(fare) as SumRevenue
FROM Data as D, Localities as L
WHERE D.pickuparea = L.Area
Group By Zone_id
Order By 2 DESC
Limit 5;


SELECT Distinct zone_id, driver_number
FROM localities as L INNER JOIN Data as D ON L.Area = D.PickupArea
WHERE zone_id IN (Select Zone_id FROM Top5PickZones)
order by 1, 2;


SELECT Distinct Zone_id, driver_number
FROM (
SELECT DISTINCT Zone_id, pickuparea
FROM Localities as L INNER JOIN Data as D 
ON L.Area = d.pickuparea
Group by Zone_id
Order By Sum(Fare) DESC 
Limit 5) As TPZ, Data as d 
WHERE TPZ.pickuparea = d.pickuparea; 

/*Question 6. Make a list of top 10 driver by driver numbers in terms of fare collected where service_status is done, done-issue.*/
SELECT Driver_number, SUM(Fare) AS total_fare
FROM Data
WHERE Service_status IN ('done', 'done-issue')
GROUP BY Driver_number
ORDER BY total_fare DESC
LIMIT 10; /* Easy to Understand*/

/*Q7 - Make a hourwise table of bookings for week between Nov01-Nov-07 and highlight the hours with more than average no.of bookings day wise*/

/*Part 1*/
SELECT * FROM data;
/*Part 1 - Hour-wise no of bookings*/
SELECT Hour(str_To_date(pickup_time,"%H:%i:%s")) as Hr, Count(*) as TotalBookings
FROM Data 
WHERE str_to_date(pickup_date,"%d-%m-%Y") between '2013-11-01' and '2013-11-07'
Group By Hour(str_to_date(pickup_time,"%H:%i:%s"))
Order by 1;


/*Part 2 - Avge Daily Bookings*/

SELECT Avg(NoOfBookingsDaily)
FROM (
SELECT Day(str_to_date(pickup_date,"%d-%m-%Y")), count(*) as NoOfBookingsDaily
FROM data 
Group By Day(str_to_date(pickup_date,"%d-%m-%Y"))) as tt;

/*Combined - Part 1 & Part 2 - ANSWER*/
SELECT Hour(str_To_date(pickup_time,"%H:%i:%s")) as Hr, Count(*) as TotalBookings
FROM Data 
WHERE str_to_date(pickup_date,"%d-%m-%Y") between '2013-11-01' and '2013-11-07'
Group By Hour(str_to_date(pickup_time,"%H:%i:%s"))
HAVING Count(*) > (SELECT Avg(NoOfBookingsDaily)
FROM (
SELECT Day(str_to_date(pickup_date,"%d-%m-%Y")), count(*) as NoOfBookingsDaily
FROM data 
Group By Day(str_to_date(pickup_date,"%d-%m-%Y"))) as tt)
Order By 1 ASC;




Select Hour(Pickup_time), Count(*) as NoOfBookings
FROM data 
WHERE pickup_date between '2013-11-01' and '2013-11-07'
Group By Hour(pickup_time)
HAVING Count(*) > (SELECT Avg(Bookings) as AvgBookings
FROM (Select Pickup_date, Count(*) as Bookings
FROM data 
WHERE pickup_date between '2013-11-01' and '2013-11-07'
Group By pickup_date) as TempTable);
									







			


