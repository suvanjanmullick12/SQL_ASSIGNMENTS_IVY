use sql_case_3;

/*1.a From the TransactionMaster table, select a list of all items purchased for
Customer_Number 296053. Display the Customer_Number,
Product_Number, and Sales_Amount for this customer.*/

SELECT Customer_Number, Product_Number, Sales_Amount
FROM TransactionMaster
WHERE Customer_Number = 296053;

/*1.b Select all columns from the LocationMaster table for transactions made in
the Region = NORTH.*/

SELECT *
FROM LocationMaster
WHERE Region = 'NORTH';

/*1.c.Select the distinct products in the TransactionMaster table. In other
words, display a listing of each of the unique products from the
TransactionMaster table.*/

SELECT DISTINCT Product_Number
FROM TransactionMaster;

/*1.d List all the Customers without duplication.*/

SELECT DISTINCT Customer_Number
FROM TransactionMaster;

/*2.a Find the average Sales Amount for Product Number 30300 in Sales Period
P03.*/

SELECT AVG(Sales_Amount) AS AverageSalesAmount
FROM TransactionMaster
WHERE Product_Number = '30300'
AND Sales_Period = 'P03';

/*2.bFind the maximum Sales Amount amongst all the transactions.*/

SELECT MAX(Sales_Amount) AS MaximumSalesAmount
FROM TransactionMaster;

/*2c.Count the total number of transactions for each Product Number and
display in descending order*/

SELECT Product_Number, COUNT(*) AS TotalTransactions
FROM TransactionMaster
GROUP BY Product_Number

/*2.d.List the total number of transactions in Sales Period P02 and P03*/

SELECT Sales_Period, COUNT(*) AS TotalTransactions
FROM TransactionMaster
WHERE Sales_Period IN ('P02', 'P03')
GROUP BY Sales_Period;

/*2.e  What is the total number of rows in the TransactionMaster table?*/

SELECT COUNT(*) AS TotalRows
FROM TransactionMaster;

/*2.F Look into the PriceMaster table to find the price of the cheapest product
that was ordered.*/

SELECT MIN(Price) AS CheapestPrice
FROM PriceMaster;

/*3.a Select all Employees where Employee-Status = “A”*/

SELECT *
FROM Employee_Master
WHERE Employee_Status = 'A';

/*3.b 	Select all Employees where Job Description is “TEAMLEAD 1”.*/

SELECT Employee_Number, First_Name, Job_Title
FROM employee_master
WHERE Job_Title = 'TEAMLEAD 1';

/*3 c.List the Last name, Employee Status and Job Title of all employees whose
names contain the letter "o" as the second letter.*/

SELECT Last_Name, Employee_Status, Job_Title,First_Name
FROM Employee_master 
WHERE First_Name LIKE '_o%';

/*3.d. List the Last name, Employee Status and Job Title of all employees whose
First names start with the letter "A" and does not contain the letter "i".*/

SELECT Last_Name, First_Name, Job_Title
FROM employee_master
WHERE First_Name LIKE 'A%' AND First_Name NOT LIKE '%i%';

/*3.e.List the First name and Last names of employees with Employee Status “I”
whose Job Code is not SR2 and SR3.*/

SELECT First_Name, Last_Name,Job_Code
FROM employee_master
WHERE Employee_Status = 'I' AND Job_Code NOT IN ('SR2', 'SR3');

/*3.f.Find out details of employees whose last name ends with “N” and first
name begins with “A” or “D”.*/

SELECT *
FROM employee_master
WHERE Last_Name LIKE '%N' AND (First_Name LIKE 'A%' OR First_Name LIKE 'D%');

/*3.g.Find the list of products with the word “Maintenance” in their product
description.*/

SELECT Product_number,Product_Description
FROM productmaster
WHERE Product_Description LIKE '%Maintenance%';

/*4.a.List the employees who were hired before 01/01/2000 (hint: use # for
date values).*/

SELECT *
FROM employee_master
WHERE Hire_Date < '2000-01-01';

/*4.b. Find the total number years of employment for all the employees who
have retired.*/

SELECT SUM(DATEDIFF('yyyy', Hire_Date,TerminationDate)) as TotalYearsOfEmployment
FROM employee_master
WHERE Employee_Status = 'Retired';

/*4.c List the transactions, which were performed on Wednesday or Saturdays.*//*(?????)*/

SELECT *
FROM transactionmaster
WHERE DATEPART(dw, TransactionDate) IN (3, 7);

/*4.d Find the list of employees who are still working at the present.*/

select employee_number, hire_date
from employee_master
where Last_Date_Worked like "";

/*5.1. List the number of Customers from each City and State.*/

SELECT FirstOfState, FirstOfCity, Count(*) as NoOfcustomers
FROM customermaster
group by FirstOfState,FirstOfCity;

/*5.2. For each Sales Period find the average Sales Amount.*/

SELECT Sales_Period, AVG(Sales_Amount) AS AverageSales
FROM transactionmaster
GROUP BY Sales_Period;

/*5.3 Find the total number of customers in each Market.*/

SELECT Customer_Number, COUNT(Branch_Number) AS TotalCustomers
FROM transactionmaster
GROUP BY Customer_Number;

/*5.4. List the number of customers and the average Sales Amount in each
Region.(??????)*/





/*5.5From the TransactionMaster table, select the Product number, maximum
price, and minimum price for each specific item in the table. Hint: The
products will need to be broken up into separate groups.*/

select Product_Number,max(Sales_Amount) as MAX_AMOUNT,MIN(SALES_AMOUNT) AS MIN_AMOUNT
FROM transactionmaster
group by Product_Number


/*6.1 Select the Name of customer companies, city, and state for all customers
in the CustomerMaster table. Display the results in Ascending Order
based on the Customer Name (company name).*/

SELECT FirstOfCustomer_Name,FirstOfCity,FirstOfState 
FROM customermaster
ORDER BY FirstOfCustomer_Name ASC

/*6.2 Same thing as question #1, but display the results in descending order.*/

SELECT FirstOfCustomer_Name,FirstOfCity,FirstOfState 
FROM customermaster
ORDER BY FirstOfCustomer_Name DESC


/*6.3 Select the product number and sales amount for all of the items in the
TransactionMaster table that the sales amount is greater than 100.00.
Display the results in descending order based on the price.*/

SELECT Product_Number,Sales_Amount
FROM TransactionMaster
WHERE Sales_Amount > 100.00
ORDER BY Sales_Amount DESC;

/*7.1  How many branches are in each unique region in the LocationMaster
table that has more than one branch in the region? Select the region and
display the number of branches are in each if it's greater than 1.*/

SELECT Region, COUNT(Branch_Number) AS NumBranches
FROM LocationMaster
GROUP BY Region
HAVING COUNT(Branch_Number) > 1;


/*7.2. From the TransactionMaster table, select the item, maximum sales
amount, and minimum sales amount for each product number in the
table. Only display the results if the maximum price for one of the items is
greater than 390.00.*/

SELECT Product_Number,  MAX(Sales_Amount) AS MaxSalesAmount, MIN(Sales_Amount) AS MinSalesAmount
FROM TransactionMaster
GROUP BY Product_Number
HAVING MAX(Sales_Amount) > 390.00;

/* 7.3 How many orders did each customer company make? Use the
TransactionMaster table. Select the Customer_Number, count the number
of orders they made, and the sum of their orders if they purchased more
than 1 item.(?????)*/

SELECT Customer_Number, Count(*) as NoOfOrders
FROM TransactionMaster
Group by Customer_Number
HAVING Count(Invoice_Number) > 1;

/*8.1 List all the employees who have worked between 22 March 2004 and 21
April 2004.*/

SELECT *
FROM employee_master
WHERE Hire_Date BETWEEN '2004-03-22' AND '2004-04-21';

/*8.2 List the names of Employees whose Job Code is in SR1,SR2 or SR3.*/

SELECT First_Name,Job_Code
FROM employee_master
WHERE Job_Code IN ('SR1', 'SR2', 'SR3');

/*8.3Select the Invoice date, Product number and Branch number of all
transactions, which have Sales amount ranging from 150.00 to 200.00.*/

SELECT Invoice_Number, Product_Number,Branch_Number,Sales_Amount
FROM transactionmaster
WHERE Sales_Amount between 150.00 AND  200.00

/*8.4 Select the Branch Number, Market and Region from the LocationMaster
table for all of the rows where the Market value is either: Dallas, Denver,
Tulsa, or Canada.*/

SELECT Branch_Number,Market,Region 
FROM locationmaster
where Market in('Dallas', 'Denver', 'Tulsa', 'Canada');


/*10.1 Write a query using a join to determine which products were ordered by
each of the customers in the CustomerMaster table. Select the
Customer_Number, FirstOfCustomer_Name, FirstOfCity, Product_Number,
Invoice_Number, Invoice_date, and Sales_Amount for everything each
customer purchased in the TransactionsMaster table.*/

SELECT CustomerMaster.Customer_Number, CustomerMaster.FirstOfCustomer_Name, CustomerMaster.FirstOfCity, TransactionMaster.Product_Number, TransactionMaster.Invoice_Number, TransactionMaster.Invoice_Date, TransactionMaster.Sales_Amount
FROM CustomerMaster
JOIN TransactionMaster
ON CustomerMaster.Customer_Number = TransactionMaster.Customer_Number;

/*10.2Repeat question #1, however display the results sorted by City in
descending order.*/

SELECT cm.Customer_Number, cm.FirstOfCustomer_Name, cm.FirstOfCity, tm.Product_Number, tm.Invoice_Number, tm.Invoice_Date, tm.Sales_Amount
FROM CustomerMaster cm
JOIN TransactionMaster tm
ON cm.Customer_Number = tm.Customer_Number
ORDER BY cm.FirstOfCity DESC;





