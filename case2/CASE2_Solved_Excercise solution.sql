select state,count(*) as Num_people 
from customers
group by state
having Num_people>1;

select item,max(price),min(price) from items_ordered group by item having max(price)>190; 


SELECT customerid, count(*), Sum(quantity)
FROM items_ordered
Group By customerid
HAVING sum(quantity) > 1;

select customerid,sum(quantity) from items_ordered Group By customerid
select distinct(customerid) from items_ordered 

SELECT customerid, count(*)as Num_Quantities, Sum(quantity) as Total_Quantities
FROM items_ordered
Group By customerid
HAVING Total_Quantities > 1;
/*Q-5-P1*/
select lastname,firstname,city from customers order by lastname asc
/*Q-5-P2*/
select lastname,firstname,city from customers order by lastname desc
/*Q-5-P3*/
select item,price from items_ordered where price>10 order by price asc
/*Q-6-P1*/
select customerid,order_date,item
from items_ordered
where item not like "Snow Shoes" and item not like "Ear Muffs";

/*Q-6-P2*/
select item,price
from items_ordered
where item like "s%" or 
item like "p%" or 
item like "f%" ;

/*Q-7-P1*/
select date_column,item,price
from items_ordered 
where 10<price<80 

/*Q-7-P2*/
select firstname,city,state 
from customers
where state IN ("arizona","washington","oklahoma","colorado","hawaii")

/*Q-8-1*/
select item,sum(price)/Sum(quantity) as PricePerUnit 
from items_ordered 
group by item

/*Q-9-1*/
SELECT c.customerid, c.firstname, c.lastname, io.order_date, io.item, io.price
FROM customers c
JOIN items_ordered io
ON c.customerid = io.customerid
ORDER BY c.customerid, io.order_date;
/*Q-9-2*/
SELECT c.customerid, c.firstname, c.lastname, io.order_date, io.item, io.price
FROM customers c
JOIN items_ordered io
ON c.customerid = io.customerid
ORDER BY c.firstname DESC;

