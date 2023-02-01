/*How to convert date values stored as text into MySQL date format (YYYY-MM-DD) 
in SQL*/

/*Step 1: Import the two tables (in CSV format) in Loans_Dataset in a new database.
Use table data import wizard (right click on the tables and select "Table Data Import Wizard" 
under the database name in schemas list on the left hand side of the screen)
to import the following tables from CSV files:

1) customers_csv
2) loans_data_csv

To import CSV files using "Table Data Import Wizard", 
go to Schemas list under navigator in the left hand side of the screen. 
Right click on tables under the relevant database, 
and select "Table Data Import Wizard".*/


/*In the loan_db database, the loans_data table contain an ApplicationDate field.
This field's date format is not as per MySQL date format (YYYY-MM-DD).
Hence, we'll import this field as a text field (choose text data type while importing using Table Data Import Wizard).
Once imported into MySQL database, we'll transform this field from text to date
using a SQL function called Str_To_Date(). Read more on Str_To_Date() in this 
link: https://www.w3schools.com/mysql/func_mysql_str_to_date.asp*/

/*Import the loans_dataset case's two CSV files: customers_csv and loans_data_csv
into a new database (if you've not done yet). */

use loans_dataset;

select * from loans limit 10;

/*Tasks that we'll perform:
1. Add a new date column AppDate into the loans table
2. Extract the date which is stored as text in the ApplicationDate column
3. Convert this date (stored as text) into date by using Str_To_Date function
4. Update the new AppDate column with the converted date*/

/* Valid Date Format in MySQL - yyyy-mm-dd hh:mm:ss */
Alter table loans 
add column AppDate date;

/*Str_To_date(DateStoredAsString,"format")*/
/*Converts the date stored as text into date format. 
Str_To_Date(DateString, '%d-%m-%Y')
Used Y because the date is in yyyy format. 
Use small case y if the year is given in two digits*/


select Str_to_date(applicationdate,"%d-%m-%Y"), appdate
from loans; /*Remember - select statement doesn't update the data in the table.*/

/*4. Update the new AppDate column with the converted date*/
update loans
set AppDate = Str_to_date(applicationdate,"%d-%m-%Y");

/*You may get a Safe Update error while running the above update query 
without the where condition. You'll need to disable the SQL_Safe_Updates. */
SET SQL_SAFE_UPDATES = 0;

select * from loans;

/*Show the AppDate in dd-mm-yyyy format*/
select date_format(appdate, "%d-%m-%Y")
from loans;
