create database if not exists sql_case_5;
use sql_case_5;
/*We'll create a view as step1 with the following columns:
ID | Age | Coins_Needed | Power

This view should have the data sorted in descending order by
Power first and then by Age in desc order in SQL. IDeally, it should
show 14 rows.*/
select * from wands;
select * from wands_property;
CREATE VIEW step1 AS
SELECT w.ID, wp.age, w.coins_needed, w.power,wp.code
FROM Wands w
JOIN Wands_Property wp ON w.code = wp.code # Here we are trying to join from a smaller table with a largers table for optimization purpose. 
WHERE wp.is_evil = 0 # wp.is_evil=0 filter has been used because in the Harry Poter Universe is_evil=0 indicates that wands is not associated with evil or black magic. 
/*Thus using wands which are is.evil = 0 might have a negative impact. Therefore database design wants to exclude black magic wands.*/
ORDER BY w.power DESC, wp.age DESC
LIMIT 14;

/*Q1. We'll create a view as step1 with the following columns:*/
create view step1 as
(     select w.id, wp.age, w.coins_needed, w.power
    from wands w inner join wands_property wp on w.code = wp.code
    where is_evil = 0
    order by w.power desc, wp.age desc, w.coins_needed asc
);

/*Q2.Step2: Only show those wands that require the minimum coins_needed
-- among the wands that have same power and age.*/
select *
from step1 as a
where not exists (
        select * from step1 as b
        where b.power = a.power and b.age = a.age and
                b.coins_needed < a.coins_needed);
# Different Approach
# It has also been found that wands which are old are more power and is consided to be the demand for someone in the harry potter world.
SELECT w.id, age, w.coins_needed, w.power
FROM wands_property AS wp inner join Wands AS w on wp.code = w.code
WHERE wp.is_evil=0 and w.coins_needed=(select min(w1.coins_needed) from wands w1 where
w.power=w1.power and w.code=w1.code) # While purchasing wands it is necessary to buy it as lowest coins_needed or gold gallons( which is used to purcahse good and service) with maximum power 
ORDER BY power DESC , age DESC; # This is an approach where View has not been used. View is used in order to save the table.