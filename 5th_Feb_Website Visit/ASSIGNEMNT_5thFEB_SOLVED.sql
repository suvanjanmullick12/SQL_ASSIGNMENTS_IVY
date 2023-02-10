create database webanalytics_db_new;/*creating the data base*/
-------------------------------------------------------
use webanalytics_db_new; /*Using the database*/

describe visitdata /*describe of the table*/
select * from visitdata /*viewing the table with table name as visitdata  */
select * from visitorprofile_withdob/*viewing the table name as visitorprofile_withdob */
SET SQL_SAFE_UPDATES = 0;/*deactivating the safe update mode */
ALTER TABLE visitorprofile_withdob ADD COLUMN date_column date; /*Alter table code is used to make any changes in the exisiting table */ 
select STR_TO_DATE(DOB, "%d-%m-%Y") from visitorprofile_withdob/*viewing str to data functions the colunm with the new data*/
---------------------------------------------------------
UPDATE visitorprofile_withdob
SET date_column = STR_TO_DATE(DOB, "%d-%m-%Y") /*updating the colunm with the new data*/
-----------------------------------------------------
ALTER TABLE visitorprofile_withdob 
ADD DROP DOB; /* NOW DROPPING THE DOB COLUMN*/
--------------------------------------------

SELECT VistID,age FROM visitorprofile_withdob; /* Show the age of every visitor from visitorprofile table.*/

SELECT VistID,Time_Spent
FROM visitdata
ORDER BY Time_Spent DESC LIMIT 10; /*Show the list of top 10 longest visits on the weekends. */

SELECT VistID,Month,Clicked
FROM visitdata where Month="January" AND Clicked="Yes";/*Show the visits from January month where the visitor also clicked on the ad.*/

SELECT VistID,Country_Name
FROM visitorprofile_withdob WHERE Country_Name="Singapore"
ORDER BY VistID DESC LIMIT 5;/*List the top 5 visitors from Singapore. Hint: Use Order by*/
