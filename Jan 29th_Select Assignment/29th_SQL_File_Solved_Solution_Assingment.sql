/*---------------------------------------------*/ TASK 2
use loan_db_new; 
select loan_ID, loan_status, LoanAmount from loans_data_csv where Loan_Status = "Y" and loanAmount > 200; /*Reporting of Specific Where Loan Status is Yes and LoanAmount is more than 20(Conditional). */
select * from loans_data_csv; /* To View the Total Data Set Select * is applied */
SELECT custID, Gender, ApplicantIncome
FROM customers_csv
WHERE Gender = "Female" and ApplicantIncome > 3000 AND Credit_History = false;
select Loan_id, loanamount, loan_amount_term, loan_status
from loans_data_csv
where (loanAmount > 300 and loan_amount_term > 300) OR 
	(loanamount > 200 and loan_status = "y");
    
/*Practice Questionscustomers:
Q1: Find the loans that are rejected and with amount greater than 200. */
select loan_ID, loan_status, LoanAmount from loans_data_csv where Loan_Status = "N" and loanAmount > 200;
/* Q2:Find the female customers from rural area*/
select * from customers_csv;
select * from customers_csv where Property_Area="Rural" and Gender="Female"
/*Q3:List the married customers with no credit history or 
un-married customers with income < 5000*/
select *
from customers_csv
where (Married ="Yes" and Credit_History = False) OR 
	(Married ="No" and ApplicantIncome < 5000);
select loan_id, loanamount, loanAmount * 14500.45 as NewLoanAmt /*NewLoanAmt is a column alias here*/
from loans_data_csv;
select * from loans_data_csv
show columns from customers_csv
select *, Credit_History * ApplicantIncome * Dependents * 0.5  AS CreditIndex from customers_csv;
select loan_id, loanamount, round(loanAmount * 14500.45,1) as NewLoanAmt,
ceil(loanAmount * 14500.45) as NextWholeNumber, 
floor(loanAmount * 14500.45) as PrevWholeNumber
from loans_data_csv;
select 92 div 10; /*Remainder
select 92 mod 10; /*Remainder */
select DateDiff("1994-12-30", "1997-06-26")
SELECT loan_id, DateDiff(Current_date(), AppDate) as LoanAgeInDays
FROM loans_data_csv; 
SELECT Loan_ID, AppDate, Day(AppDate) as Dy, Month(AppDate) as Mth, Year(AppDate) as Yr
FROM loans_data_csv;
SELECT loan_id, TimeStampDiff(Month, appdate, Current_Date()) as LoanAgeInMonths
FROM loans_data_csv;
______________________________
/*Practice Questions:
1. Find the loan's age for the approved loans.*/
select * from loans_data_csv
SELECT loan_id, TimeStampDiff(Month, appdate, Current_Date()) as LoanAgeInMonths
FROM loans_data_csv where loan_status ="Y" ;
/*2. Show the loan age in number of months.*/
SELECT loan_id, TimeStampDiff(Month, appdate, Current_Date()) as LoanAgeInMonths,Month(appdate)
FROM loans_data_csv ;
/*3. Show the loan age in number of years and extra months..*/
SELECT Loan_id, TimeStampDiff(Month, appdate, Current_Date()) as Yr,TimeStampDiff(Year, appdate, Current_Date()) as Month
FROM loans_data_csv ;
_____________________________________
SELECT * 
FROM loans_data_csv
WHERE LoanAmount IS Null;
_____________________________________
SELECt Distinct loan_amount_term
FROM loans_data_csv;

_________________________________
Select Loan_id, IfNull(loanAmount, "Error in loan application")
FROM loans_data_csv;
______________________________