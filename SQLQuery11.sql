
---Practise SQL-Basics

select* from [dbo].[TR_OrderDetails];

--1 Find the  Maximum quantity sold in a transaction 

select MAX(Quantity) as Quantity ,COUNT(*) as Count
from [dbo].[TR_OrderDetails];

--2 Find the unique products in all transacitions

select distinct ProductID 
from [dbo].[TR_OrderDetails];

--checking if maximum of 3 quantity is sold.

select distinct ProductID,Quantity 
from [dbo].[TR_OrderDetails]
 where Quantity=3
 order by productid asc,Quantity desc;

 --Find Unique Property
 select distinct 
 propertyID
 from [dbo].[TR_OrderDetails]

 ---Find the product Category which has maximum products.

 select ProductCategory,
 count(*) as count
 from [dbo].[TR_Products]
 group by  ProductCategory
 order by 2 desc;

 --- find the states where most stores are present

 select PropertyState,
 COUNT(*) as count
 from [dbo].[TR_PropertyInfo]
 group by PropertyState
 order by 2 desc;

 --- Find Top 5 product IDs that did maximum sales in terms of quantity
SELECT top 5 ProductID, SUM(Quantity) AS total_Quantity
FROM [dbo].[TR_OrderDetails]
GROUP BY ProductID
order by 2 desc;

 --- Find Top 5 Proporty IDs that did maximum sales in terms of quantity
 SELECT top 5 PropertyID, SUM(Quantity) AS total_Quantity
FROM  [dbo].[TR_OrderDetails] 
GROUP BY PropertyID
order by 2 desc;


--Find TOP 5 product names that did maximum sales in terms of quantity
SELECT
  o.*,
  p.ProductName,
  p.ProductCategory,
  p.Price
FROM [dbo].[TR_OrderDetails] AS o
LEFT JOIN [dbo].[TR_Products] AS p ON o.ProductID = p.ProductID;


SELECT
  top 5 p.ProductName,SUM(Quantity) AS total_Quantity

FROM [dbo].[TR_OrderDetails] AS o
LEFT JOIN [dbo].[TR_Products] AS p ON o.ProductID = p.ProductID
group by p.ProductName
order by 2 desc

---
--- Top 5 product which did maximum in terms of sales

SELECT
  top 5 p.ProductName,
  SUM(o.Quantity * p.Price) AS Sales
FROM [dbo].[TR_OrderDetails] AS o
LEFT JOIN [dbo].[TR_Products] AS p ON o.ProductID = p.ProductID
GROUP BY p.ProductName
ORDER BY Sales DESC;

--- Top 5 cities  which did maximum in terms of sales

SELECT top 5
  pi.PropertyCity,
  SUM(o.Quantity * p.Price) AS Sales
FROM [dbo].[TR_OrderDetails] AS o
LEFT JOIN [dbo].[TR_Products] AS p ON o.ProductID = p.ProductID
LEFT JOIN [dbo].[TR_PropertyInfo] AS pi ON o.PropertyID = pi.Prop_ID

GROUP BY pi.PropertyCity
ORDER BY Sales DESC;

---find top 5 products in each cities
--for city name : Arlington

SELECT TOP 5
  pi.PropertyCity,
  p.ProductName,
  SUM(o.Quantity * p.Price) AS Sales
FROM [dbo].[TR_OrderDetails] AS o
LEFT JOIN [dbo].[TR_Products] AS p ON o.ProductID = p.ProductID
LEFT JOIN [dbo].[TR_PropertyInfo] AS pi ON o.PropertyID = pi.Prop_ID
GROUP BY pi.PropertyCity, p.ProductName
ORDER BY Sales DESC;










