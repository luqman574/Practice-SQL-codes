---Inspecting Data
select * from [dbo].[sales_data_sample]


---checking for unique values

select distinct status from [dbo].[sales_data_sample]			-- Plotworthy
select distinct YEAR_ID from [dbo].[sales_data_sample]
select distinct PRODUCTLINE from [dbo].[sales_data_sample]		--Plotworthy
select distinct COUNTRY from [dbo].[sales_data_sample]			--Plotworthy
select distinct DEALSIZE from [dbo].[sales_data_sample]			--Plotworthy
select distinct TERRITORY from [dbo].[sales_data_sample]		--Plotworthy

---Anlaysis
---  Grouping sales by Productline
select  PRODUCTLINE,SUM(sales) Revenue
from [dbo].[sales_data_sample]
group by PRODUCTLINE
order by 2 desc

select  YEAR_ID,SUM(sales) Revenue
from [dbo].[sales_data_sample]
group by YEAR_ID 
order by 2 desc

select DEALSIZE,SUM(sales) Revenue
from [dbo].[sales_data_sample]
group by DEALSIZE
order by 2 desc

select  YEAR_ID,SUM(sales) Revenue
from [dbo].[sales_data_sample]
group by YEAR_ID 
order by 2 desc

---Finding out Best month for sales in a perticular year

select MONTH_ID,sum(sales) revenue,COUNT(ORDERNUMBER) frequency
from [dbo].[sales_data_sample]
where YEAR_ID =2003 --- can change year to see correspounding results
group by MONTH_ID
order by 2 desc

--- November is the month with most sales
---Finding out which product they sell in November

select MONTH_ID,PRODUCTLINE, sum(sales) revenue,COUNT(ORDERNUMBER) frequency
from [dbo].[sales_data_sample]
where YEAR_ID =2004 and MONTH_ID = 11 
group by MONTH_ID,PRODUCTLINE
order by 3 desc

--- Finding  Out BEST CUSTOMER -- RFM ANALYSYS
;with rfm as
(
select
CUSTOMERNAME,
sum(sales) MonetaryValue,
avg(sales)AverageMonetaryValue,
COUNT(ORDERNUMBER) Frequency,
max(ORDERDATE) last_order_date,

(select max (ORDERDATE) from [dbo].[sales_data_sample]) max_order_date,
DATEDIFF (DD,max(ORDERDATE),(select max (ORDERDATE) from [dbo].[sales_data_sample])) Recency
from [dbo].[sales_data_sample]
group by CUSTOMERNAME
)

rfm_calc as 
(
	select r.*,
			NTILE(4) OVER (order by Recency ) rfm_recency,
			NTILE(4) OVER (order by Frequency) rfm_frequency,
			NTILE(4) OVER (order by MonetaryValue) rfm_monetary

	from rfm r
)

select c.*
from rfm_calc c










