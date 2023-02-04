/*Post import data transformation examples using 
customer_profiling_cc dataset.

In this case, we'll learn how to do basic transformations 
after importing the data using table data import wizard. We'll perform the following tasks:

a) string to integer transformation
b) rename a column to remove spaces in the column name

Let's create a new database - customer_profiling_cc*/

create database customer_profiling_cc;

use customer_profiling_cc; /*makes this database default*/

show tables; /*fetches all the tables from the default database.*/

/*Use table data import wizard (right click on the tables and select "Table Data Import Wizard" under the database name in schemas list on the left hand side of the screen).
 to import the following tables from CSV files:

1) cc_profile
2) customer_region
3) region

To import CSV files using "Table Data Import Wizard", 
go to Schemas list under navigator in the left hand side of the screen. 
Right click on tables under the relevant database, 
and select "Table Data Import Wizard".*/

select * from cc_profile;

/*Transformations - clean the data or make the ready for analysis. 

1. Change AnnualSalary from text to Integer
2. Rename No of credit card to NoOfCC*/

select * 
from cc_profile
limit 10; /*limits to ten records from top*/

select annualsalary
from cc_profile;

/*In AnnualSalary column, replace comma with null string (replace "," with "")
using Replace function in SQL.
Replace(String,"CharsToReplace","NewChars")

Once done, convert the annualsalary without the commas into number.
We can either multiple the converted annualsalary by 1 or use 
CAST() sql function. Read more about CAST() in this link https://www.w3schools.com/mysql/func_mysql_cast.asp*/
/*Cast("1234" as unsigned)*/

select replace(annualsalary, ",","") * 1, 
cast(replace(annualsalary, ",","") as unsigned)
from cc_profile;

/*Alter the table cc_profile, and add a new annualSalary_new 
column with INTEGER data type. Then, update this new column 
with the casted annualsalary values*/

ALTER TABLE cc_profile
ADD column Salary INT;

/*Update the Salary with the transformed annualsalary*/
update cc_profile
SET salary = cast(replace(annualsalary, ",","") as unsigned);

select salary
from cc_profile;

/*Drop the annualsalary column from cc_profile table*/
alter table cc_profile
drop column annualsalary;


/*Change the column name, from Number of Credit Cards to 
NoOfCC - basically, remove the spaces in Number of Credit Cards column name*/

Alter table cc_profile
rename column `Number of Credit cards` to NoOfCC;