create database web;

use web;


create table superstore(
   ShipMode varchar(50),
   Segment varchar(50),
   Country varchar(50),
   City varchar(50),
   States varchar(50),
   Postalcode int,
   Region varchar(50),
   Category varchar(50),
   SubCategory varchar(50),
   Sales Float,
   Quantity int,
   Discount float,
   Profit float
);
select * from superstore;


--***import the CSV file***

SET FMTONLY OFF;
SET NOCOUNT OFF;


SELECT COUNT(*) AS Total_Records
FROM dbo.Superstore1;

select top 5 * from dbo.superstore1

SELECT DISTINCT Region
FROM dbo.Superstore1;


select *
from superstore1
where Region = 'West';

--Region-wise Sales
SELECT 
Region,
SUM(Sales) AS Total_Sales
FROM superstore1
GROUP BY Region;

--Top selling category
select 
Segment,
sum(Sales) AS total_sales
from superstore1
where Region = 'East'
Group BY Segment

--Loss Products
select
    Sub_Category,
    SUM(Profit) AS Total_Profit
from superstore1
group by Sub_Category
having SUM(Profit) < 0;


select * from superstore1
where Discount > 0.2
order by Sales desc;

select 
AVG(Sales) AS avg_sales,
MAX(Sales) AS max_sales,
MIN(Sales) AS min_sales
from superstore1

--join

create table region_manager(
   Region varchar(50),
   Manager varchar(50)
);

select s.Region,r.Manager,
sum(s.Sales) AS total_sales
from superstore1 s
JOIN region_manager r
ON s.Region = r.Region
group by s.Region,r.Manager;




