Use loan_db_new
select * from customers_csv;
SELECT CustID, Loan_ID, ApplicantIncome,
SELECT CustID, Loan_ID, ApplicantIncome,
If(ApplicantIncome > 10000, "High Income","Low or Avg Income") as IncomeStatus
FROM customers_csv;
select custId, ApplicantIncome,
if(applicantIncome > 15000, "Ultra Rich",
    if(applicantIncome between 10000 and 14999, "Rich", "Low/Avg"))
from customers_csv;
select * from customers_csv;
select gender, count(*)
from customers
group by gender;

select custId, ApplicantIncome,
    case
        when applicantincome >= 15000 then "Ultra Rich"
        When applicantincome between 10000 and 14999 then "Rich"
        else "Avg / Low Income"
        end as IncomeStatus
from customers_csv;


select gender, count(*)
from customers_csv
group by gender;

select Sum(if(Gender = "female", 1, 0)) as TotalFemales,
        sum(if(gender = "male", 1, 0)) as TotalMales
from customers_csv;

select custId, Self_Employed, ApplicantIncome,
if((Self_Employed = "Yes" and ApplicantIncome > 7000)
    OR (Self_Employed = "NO" and ApplicantIncome > 6000),
    "Eligible", "Not Eligible") as Status
from customers_csv;

select custId, self_employed, ApplicantIncome,
case
    when self_employed = "Yes" and ApplicantIncome > 7000
        then "Eligible"
    when self_employed = "No" and ApplicantIncome > 6000
        then "Eligible"
    else "Not Eligible"
    End as Status
from customers_csv;
