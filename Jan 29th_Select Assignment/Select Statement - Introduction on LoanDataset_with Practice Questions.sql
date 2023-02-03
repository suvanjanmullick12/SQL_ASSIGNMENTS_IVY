/*Select Statement: Detailed Introduction
Select helps you to extract data from the tables. 
Remember, it doesn't make any changes to data of the tables. 

SELECT <filed1>, <field2>
FROM <dbname>.<table>
WHERE <condition(s)>;

SQL Execution Sequence ->			
1 - From 
2 - Where (if specified); 
Last - SELECT						

Ideal steps to write Select statement: 
1. Visualize the output / report that you want to create
2. Think of the execution sequence (From which table, what conditions, what do we have to select) 
3. Write the Select Statement
*/

use loans_dataset;

select * from customers;

/*Where clause in the select statement helps you to filter rows.

All the loans that are approved and have loanamount more
than 200*/
select loan_ID, loan_status, LoanAmount
from loans_dataset.loans
where loan_status = "y" and loanAmount > 200;

select * 
from loans
where loan_status = "Y" and LoanAmount > 200;

/*How to handle different cell values in SQL. 
Text and date values are put under a pair of double quotes. Eg: Gender = "Female" or AppDate < "2019-10-25" 
Integer values are used without any quotes. Eg: ApplicantIncome > 90000
Binary values are mentioned like True / False. Eg: LoanStatus = False*/
SELECT custID, Gender, ApplicantIncome
FROM customers 
WHERE Gender = "Female" and ApplicantIncome > 3000 AND Credit_History = false;


/*All the loans with (loanamount > 300 and loan_amount_term > 300) Or 
(loanamount > 200 and loan_status = "y")*/
select Loan_id, loanamount, loan_amount_term, loan_status
from loans
where (loanAmount > 300 and loan_amount_term > 300) OR 
	(loanamount > 200 and loan_status = "y");
    
/*Practice Questionscustomers:
1. Find the loans that are rejected and with amount greater than 200.
2. Find the female customers from rural area
3. List the married customers with no credit history or 
un-married customers with income < 5000*/

select *
from customers
where (married = "yes" and credit_history = false) OR
	  (married = "no" and applicantIncome < 5000);

select *
from customers
where (married = "yes" and credit_history = 0) or 
       (married = "no" and applicantincome < 5000);


/*Mathematical Operators in SQL
+  Addition
-  Subtraction
*  Multipication
/  division
%  Remainder (Mod) 

Logical Operators in SQL 
> 
= 
<
>=
<= 
<> - Not Equals to 
*/
    
/*Column aliases using AS*/
select loan_id, loanamount, loanAmount * 14500.45 as NewLoanAmt /*NewLoanAmt is a column alias here*/
from loans;

/*Practice question:
CreditIndex = Credit_History * ApplicantIncome * (Dependent * 0.5)
Show this CreditIndex for all the customers.
*/
select *, Credit_History * ApplicantIncome * Dependents * 0.5  AS CreditIndex
from customers;

/*Functions in SQL - Help us in computing complex data

A function looks like -> funcName() 
It will always return something.
Some functions accept parameters or arguments. 
Eg. Round(8.89, 1)  -> 8.9
Please note – a function will have always have a pair of brackets as suffix  
There are functions for: 
1. Numeric Calculations 
2. Date / Time Calculations
3. String Cleaning / Manipulation 
4. Advanced functions  
 */

/*Round, Ceil, Floor*/
select loan_id, loanamount, round(loanAmount * 14500.45,1) as NewLoanAmt,
ceil(loanAmount * 14500.45) as NextWholeNumber, 
floor(loanAmount * 14500.45) as PrevWholeNumber
from loans;

/*Practice Question:
CreditIndex = Credit_History * ApplicantIncome * (Dependent * 0.5)
Round up the CreditIndex to the next whole number. 
Round down the CreditIndex to the previous whole number.
*/

/*How to find remainder and quotient in SQL
Mod clause helps to find the remainder. 
Div clause is used to find the quotient.*/
select 92 mod 10, 92 % 10; /*gives the remainder*/

select 92 div 10; /*gives the quotient*/


/*Common Date Functions
DateDiff(EndDate, StartDate) - Gives the difference  between two date in number of days.
Day(GivenDate) -> extracts the day portion of the date.
Month(GivenDate) -> extraacts the month portion of the date.
Year(GivenDate) -> extracts the year portion of the date
*/ 
SELECT loan_id, DateDiff(Current_date(), AppDate) as LoanAgeInDays
FROM loans; 

SELECT Loan_ID, AppDate, Day(AppDate) as Dy, Month(AppDate) as Mth, Year(AppDate) as Yr
FROM loans;

/*Weekday(givenDate) -> extracts the day of the week, and returns a number between 0 and 6. 
Here, 0 would represent Monday and 6 would represent Sunday.
DayName(givenDate) -> extracts the day of the week in full string. Eg: Monday, Wednesday*/
SELECT loan_Id, AppDate, WeekDay(AppDate) as WkDayinNumeric, 
DayName(AppDate) as WkDayName, Month(AppDate) as mthInNo, MonthName(AppDate) as MthName
FROM loans;

/*TimeStampDiff(Unit, StartDate, EndDate) -> Finds the difference between start and end dates in terms of the unit. 
Eg: TimeStampDiff(Month, DOB, Current_Date()) -> will give the age in number of months*/

/*How old is each loan in the loans table? Show the loan age in months.*/
SELECT loan_id, TimeStampDiff(Month, appdate, Current_Date()) as LoanAgeInMonths
FROM loans;

/*Practice Questions:
1. Find the loan's age for the approved loans.
2. Show the loan age in number of months. 
3. Show the loan age in number of years and extra months. Eg: 
   LoanID  | Yr | Month
   LP00011 | 3  | 9 
   */

/*How do we handle Null values in SQL*/
SELECT * From Student;

SELECT * 
FROM loans
WHERE LoanAmount IS Null; /*We use IS instead of an = sign to compare with NULL or NOT Null in the where clause.*/

SELECT *
FROM loans
WHERE LoanAmount IS NOT Null;

/*Distinct - Extract different values from a list (duplicates removed).
Remember there is a difference between a distinct 
list of values and unique list of values*/
SELECt Distinct loan_amount_term
FROM loans;

/*IfNull*/
Select loanID, IfNull(loanAmount, "Error in loan application")
FROM loans;
