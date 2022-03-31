﻿
--E-Commerce Project Solution


update prod_dimen
set Prod_id=replace(Prod_id,'Prod_','') 
where Prod_id is not null
​
update cust_dimen
set  cust_id=replace(cust_id,'Cust_','') 
where cust_id is not null
​

update market_fact
set  cust_id=replace(cust_id,'Cust_',''), 
	Prod_id=replace(Prod_id,'Prod_','') ,
	Ord_id=replace(Ord_id,'Ord_','') ,
	Ship_id=replace(Ship_id,'SHP_','') 
where cust_id is not null Prod_id is not null Ord_id is not null Ship_id  is not null
​
​
update orders_dimen
set  Ord_id=replace(Ord_id,'Ord_','') 
where Ord_id is not null
​
update shipping_dimen
set  Ship_id=replace(Ship_id,'SHP_','') 
where Ship_id is not null
​
​
--1. Join all the tables and create a new table called combined_table. (market_fact, cust_dimen, orders_dimen, prod_dimen, shipping_dimen)


select A.*, B.Customer_Name,B.Customer_Segment,B.Province,B.Region,
			C.Order_Date,C.Order_Priority,
			D.Product_Category,D.Product_Sub_Category,
			E.Order_ID,E.Ship_Date,E.Ship_Mode
into combined_table
from dbo.market_fact A, dbo.cust_dimen B,dbo.orders_dimen C , dbo.prod_dimen D,dbo.shipping_dimen E  
where A.Cust_id=B.Cust_id and
      A.Ord_id=C.Ord_id   and 
      A.Prod_id=D.Prod_id and
      A.Ship_id=E.Ship_id
		
select * 
from combined_table
order by Ord_id


--///////////////////////


--2. Find the top 3 customers who have the maximum count of orders.


select top 3 cust_id, Customer_Name, count(distinct Ord_id) as max_or_quantity



--/////////////////////////////////


--3.Create a new column at combined_table as DaysTakenForDelivery that contains the date difference of Order_Date and Ship_Date.
--Use "ALTER TABLE", "UPDATE" etc.

alter table combined_table 

update combined_table set DaysTakenForDelivery = datediff(day, Order_Date, Ship_Date);

select	distinct Cust_id, Order_Date, Ship_Date, DaysTakenForDelivery

select *
from combined_table

--////////////////////////////////////


--4. Find the customer whose order took the maximum time to get delivered.
--Use "MAX" or "TOP"


select top 1 Cust_id,Customer_Name, DaysTakenForDelivery
from combined_table
order by DaysTakenForDelivery desc


--////////////////////////////////


--5. Count the total number of unique customers in January and how many of 
--them came back every month over the entire year in 2011
--You can use date functions and subqueries


select	count(distinct Cust_id) as unique_customer_January_2011 

--////////////////////////////////////////////


--6. write a query to return for each user acording to the time elapsed between the first purchasing and the third purchasing, 
--in ascending order by Customer ID
--Use "MIN" with Window Functions


create view purchase_one as

--//////////////////////////////////////

--7. Write a query that returns customers who purchased both product 11 and product 14, 
--as well as the ratio of these products to the total number of products purchased by all customers.
--Use CASE Expression, CTE, CAST and/or Aggregate Functions

  select Cust_id, Customer_Name


from aa

with bb as (

select cust_id, p11, p14, total_product,


--/////////////////

--CUSTOMER SEGMENTATION

--1. Create a view that keeps visit logs of customers on a monthly basis. (For each log, three field is kept: Cust_id, Year, Month)
--Use such date functions. Don't forget to call up columns you might need later.

create view visit_log as 

select *
from visit_log

--//////////////////////////////////


  --2.Create a “view” that keeps the number of monthly visits by users. (Show separately all months from the beginning  business)
--Don't forget to call up columns you might need later.

create view monthly_visits as

select *
from monthly_visits

--//////////////////////////////////


--3. For each visit of customers, create the next month of the visit as a separate column.
--You can order the months using "DENSE_RANK" function.
--then create a new column for each month showing the next month using the order you have made above. (use "LEAD" function.)
--Don't forget to call up columns you might need later.





--/////////////////////////////////


--4. Calculate monthly time gap between two consecutive visits by each customer.
--Don't forget to call up columns you might need later.

create view gap as

select * 

--///////////////////////////////////


--5.Categorise customers using average time gaps. Choose the most fitted labeling model for you.
--For example: 
--Labeled as “churn” if the customer hasn't made another purchase for the months since they made their first purchase.
--Labeled as “regular” if the customer has made a purchase every month.
--Etc.
	
select	cust_id, avg_gap,

--/////////////////////////////////////

--MONTH-WISE RETENTÝON RATE


--Find month-by-month customer retention rate  since the start of the business.


--1. Find the number of customers retained month-wise. (You can use time gaps)
--Use Time Gaps

select distinct [Year],[Month],
 
 --//////////////////////
 
--2. Calculate the month-wise retention rate.

--Basic formula: o	Month-Wise Retention Rate = 1.0 * Number of Customers Retained in The Current Month / Total Number of Customers in the Current Month

--It is easier to divide the operations into parts rather than in a single ad-hoc query. It is recommended to use View. 
--You can also use CTE or Subquery if you want.

--You should pay attention to the join type and join columns between your views or tables.

select distinct cust_id, [Year], [Month], month_order, next_visit,

---///////////////////////////////////