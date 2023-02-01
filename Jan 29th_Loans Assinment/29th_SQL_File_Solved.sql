create database if not EXISTS loan_db_new /*new database in MySQL by using the CREATE DATABASE*/
use loan_db_new;
SELECT * FROM loan_db_new.loans_data_csv;
Alter table loans_data_csv add column AppDate date;    /*------------.Add a new date column AppDate into the loans table with format as data*/
select Str_to_date(ApplicationDate,"%d-%m-%Y")  /*STR TO DATE FUNCTION IS USED TO CHANGE THE TEXT OF APPLICATION DATA TO SQL FORMAT*/
from loans_data_csv;
SET SQL_SAFE_UPDATES = 0;
Update loans_data_csv set AppDate = Str_To_Date(ApplicationDate, "%d-%m-%Y")  /*Updating the new appdate with updated SQL data and time format*/
Describe loans_data_csv; /* un
SELECT * FROM loan_db_new.loans_data_csv /* used to view the table by using the select query statement. 
