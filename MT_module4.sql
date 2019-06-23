--1
select distinct c.custcity
from Customers c;

--2
select e.empfirstname, e.emplastname, e.empphonenumber
from Employees e;

--3
select  ct.categorydescription
from Categories ct
where ct.categoryid in 
(select categoryid
 from Products);

--4
select distinct p.productname, p.retailprice, ct.categorydescription
from Products p
inner join Categories ct on (p.categoryid = ct.categoryid);

--5
select v.vendname
from Vendors v
order by v.vendzipcode;

--6
select e.empfirstname, e.emplastname, e.empphonenumber, e.empareacode
from Employees e 
order by e.emplastname, e.empfirstname;

--7
select distinct v.vendname
from Vendors v;

--8
select distinct c.custstate
from Customers c;

--9
select p.productname, p.retailprice 
from Products p;

--10
select *
from Employees;

--11
select v.vendcity, v.vendname
from Vendors v
order by v.vendcity;

--12
select pv.productnumber, pv.daystodeliver
from Product_Vendors pv;

--13
select p.productnumber, p.productname, p.retailprice*p.quantityonhand as sum_value
from Products p;

--14
select ordernumber, shipdate, orderdate, datediff(day,orderdate,shipdate) as days_count
from Orders;

--tasks
--1
 WITH 
  E1(N) AS (
            SELECT 1 UNION ALL SELECT 1 UNION ALL SELECT 1 UNION ALL 
            SELECT 1 UNION ALL SELECT 1 UNION ALL SELECT 1 UNION ALL 
            SELECT 1 UNION ALL SELECT 1 UNION ALL SELECT 1 UNION ALL SELECT 1
           ),                          -- 1*10^1 or 10 rows
  E2(N) AS (SELECT 1 FROM E1 a, E1 b), -- 1*10^2 or 100 rows
  E4(N) AS (SELECT 1 FROM E2 a, E2 b)  -- 1*10^4 or 10,000 rows
  
 SELECT TOP (10000) ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) FROM E4 
;

--2
DECLARE @Year AS INT,
@FirstDateOfYear DATETIME,
@LastDateOfYear DATETIME
-- You can change @year to any year you desire
SELECT @year = 2019
SELECT @FirstDateOfYear = DATEADD(yyyy, @Year - 1900, 0)
SELECT @LastDateOfYear = DATEADD(yyyy, @Year - 1900 + 1, 0)
-- Creating Query to Prepare Year Data
;WITH cte AS (
SELECT 1 AS DayID,
@FirstDateOfYear AS FromDate,
DATENAME(dw, @FirstDateOfYear) AS Dayname
UNION ALL
SELECT cte.DayID + 1 AS DayID,
DATEADD(d, 1 ,cte.FromDate),
DATENAME(dw, DATEADD(d, 1 ,cte.FromDate)) AS Dayname
FROM cte
WHERE DATEADD(d,1,cte.FromDate) < @LastDateOfYear
)
SELECT count(*) --FromDate AS Date, Dayname
FROM CTE
--WHERE DayName LIKE 'Sunday'

WHERE DayName IN ('Saturday','Sunday') -- For Weekend
/*WHERE DayName NOT IN ('Saturday','Sunday') -- For Weekday
WHERE DayName LIKE 'Monday' -- For Monday
WHERE DayName LIKE 'Sunday' -- For Sunday
*/
OPTION (MaxRecursion 370);