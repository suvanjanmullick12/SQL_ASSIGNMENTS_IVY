create database customer_profiling_cc;
use customer_profiling_cc;
show tables
select * from cc_profile;
describe cc_profile /* CHECKING THE TYPE OF ALL THE FIELDS"*/ 
select annualsalary
from cc_profile;

SELECT CAST(age AS VARCHAR) from cc_profile;
describe cc_profile
_______________________________________
/*Transformations - clean the data or make the ready for analysis. 

1. Change AnnualSalary from text to Integer
2. Rename No of credit card to NoOfCC*/

select replace(annualsalary, ",","") * 1, 
cast(replace(annualsalary, ",","") as unsigned)
from cc_profile;
______________________________________________
/*In AnnualSalary column, replace comma with null string (replace "," with "")
using Replace function in SQL.
Replace(String,"CharsToReplace","NewChars")

Once done, convert the annualsalary without the commas into number.
We can either multiple the converted annualsalary by 1 or use 
CAST() sql function. Read more about CAST() in this link https://www.w3schools.com/mysql/func_mysql_cast.asp*/

ALTER TABLE cc_profile ADD annualSalary_new int;
______________________________________________
/*Alter the table cc_profile, and add a new annualSalary_new 
column with INTEGER data type. Then, update this new column 
with the casted annualsalary values*/

SET SQL_SAFE_UPDATES = 0;
UPDATE cc_profile set annualSalary_new = cast(replace(annualsalary, ",","") as unsigned);
-----------------------------
/*adding new column the Salary */
ALTER TABLE cc_profile
ADD column Salary INT;
---------------------------------
/*Update the Salary with the transformed annualsalary*/
update cc_profile
SET salary = cast(replace(annualsalary, ",","") as unsigned);

select salary
from cc_profile;
---------------------------------
alter table cc_profile
drop column annualsalary;
------------------------------
/*Change the column name, from Number of Credit Cards to 
NoOfCC - basically, remove the spaces in Number of Credit Cards column name*/

Alter table cc_profile
rename column `Number of Credit cards` to NoOfCC;