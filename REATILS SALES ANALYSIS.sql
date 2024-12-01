DROP TABLE IF EXISTS Retail_Sales;
Create Table Retail_Sales
					(
							transactions_id Int primary Key,
							sale_date Date,
							sale_time Time,
							customer_id Int,	
							gender VARCHAR(15),	
							age	Int,
							category VARCHAR(15),	
							quantiy	Int,
							price_per_unit	Float,
							cogs Float,	
							total_sale Float
							
						);

--  SHOW RECORD 
SELECT * FROM Retail_Sales;

--  COUNT THE TOTAL ROWS OF TABLE  
SELECT COUNT(*) FROM Retail_Sales;

--  SHOW  FIRST 10 ROWS   OF TABLE  
SELECT * 
	FROM Retail_Sales 
ORDER BY transactions_id ASC  
LIMIT 10;

#
--  CHECK NULL ROWS IN SPECIFIC COLUMN OF TABLE  
SELECT *
	FROM Retail_Sales
WHERE TRANSACTIONS_ID IS NULL;

#
--  CHECK NULL ROWS IN EVERY COLUMN OF TABLE  
SELECT * FROM retail_sales
WHERE 
    transactions_id IS NULL
    OR
    sale_date IS NULL
    OR 
    sale_time IS NULL
    OR
    gender IS NULL
    OR
    category IS NULL
    OR
    quantiy IS NULL
    OR
    cogs IS NULL
    OR
    total_sale IS NULL;

#
--  To delete all the null containig rows 
Delete
	 FROM retail_sales
WHERE 
    transactions_id IS NULL
    OR
    sale_date IS NULL
    OR 
    sale_time IS NULL
    OR
    gender IS NULL
    OR
    category IS NULL
    OR
    quantiy IS NULL
    OR
    cogs IS NULL
    OR
    total_sale IS NULL;
		

-- Data Exploration 

-- How many sales transaction we have ?

select 
	count(transactions_id) as Total_Transactio_Count 
	from Retail_Sales;


-- How many sales transaction we have ?

select 
	count(transactions_id) as Total_Transactio_Count 	from Retail_Sales;

-- How many Unique Customers we have ?

select 
	count(Distinct customer_id) as Total_customer_Count 	from Retail_Sales;

-- How many Unique Category we have ?

select 
	count(Distinct category) as Total_category_Count 	from Retail_Sales;

select 
	Distinct category
from Retail_Sales;


-- #### Data Analysis & Business Key Problems & Answers 


-- Q.1 Write a SQL query to retrieve all columns for sales made on 2022-11-05

select * 
	from Retail_Sales
where
	sale_date='2022-11-05';

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022

Select *
	from retail_sales
where category='Clothing'
and to_char(sale_date,'YYYY-MM')= '2022-11'
and quantiy>=4;

-- .3 Write a SQL query to calculate the total sales (total_sale) for each category.
Select 
	category, sum(total_sale) as Total_Sales
from retail_sales
Group by  category;

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
Select 
	round(avg(age),2) as Customer_Avg_Age
from retail_sales
where
	category='Beauty';

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

Select *
	from retail_sales
where
	total_sale > 1000;

-- Total Transaction Count ..

Select count(*)
	from retail_sales
where
	total_sale > 1000;



-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
Select 
	Gender, category, count(transactions_id)
	from retail_sales
group by 
	Gender,category;

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
Select * from
			(
			Select 
				extract(Year from sale_date) as year,
				extract(Month from sale_date) as month,
				avg(total_sale) as avg_sales,
				rank() over(partition by extract(Year from sale_date) order by avg(total_sale) Desc ) rnk
				from retail_sales
			group by 
				year,month
			) tbl_tnk
where rnk=1;


-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 

Select 
	customer_id, 
	sum(total_sale) as total_sales
	from retail_sales
group by 
	customer_id
order by 
	total_sales desc 
limit 5;


-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
Select
	category,
	count( Distinct customer_id)
From retail_sales
group by 
	category;

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
Select *,
	case
		when extract(hour from sale_time) <12 then 'Morning'
		when extract(hour from sale_time) between 12 and 17 then 'Eveing'
		else 'eveining'
	end as shift
from retail_sales

select * from retail_sales;
	

	