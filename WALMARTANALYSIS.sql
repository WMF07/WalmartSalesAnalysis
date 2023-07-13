SELECT * FROM walmartdb.sales;

-- Feature Engineering --
-- time_of_day --

SELECT time,
	(CASE
		WHEN `time` BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
        WHEN `time` BETWEEN "12:01:00" AND "16:00:00" THEN "Afternoon"
        ELSE "Evening"
    END
    ) AS time_of_date
from sales;

ALTER TABLE sales ADD column time_of_day VARCHAR(20);

SET SQL_SAFE_UPDATES = 0

update sales
SET time_of_day = (
CASE
		WHEN `time` BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
        WHEN `time` BETWEEN "12:01:00" AND "16:00:00" THEN "Afternoon"
        ELSE "Evening"
    END
);
-- -- ------------------------------------------------------------------------------------------- --
-- day name --

SELECT date, dayname(date)
FROM sales;

ALTER TABLE sales 
ADD COLUMN day_name varchar(10);

update sales
set day_name = dayname(date);

-- ---------------------------------------------------------------- --
-- month_name --
select date, monthname(date)
FROM sales;

ALTER TABLE sales
ADD COLUMN month_name varchar(10)

UPDATE sales
SET month_name = monthname(date);

-- --------------------------------------------------------------------------------------------- --
-- Unique Cities present in data --
SELECT distinct(city)
FROM sales

-- Unique branches present in data --
SELECT distinct(branch)
FROM SALES

-- Which branch belongs to which city --
SELECT DISTINCT city , branch
FROM sales

-- Product Analysis --
-- Unqiue Product Lines in the data -- 

SELECT COUNT(DISTINCT product_line)
FROM sales

-- Most common payment moethod --
SELECT payment_method, COUNT(payment_method) as count
FROM sales
GROUP BY payment_method
ORDER BY count DESC

-- Most selling product line --
SELECT product_line,count(product_line) as count
FROM sales
GROUP BY product_line
ORDER BY count DESC;

-- Total Revenue by Month --
SELECT month_name as month , SUM(total) as total_revenue
FROM SALES
GROUP BY month_name
ORDER BY total_revenue DESC;

-- Which month had the highest COGS --
SELECT month_name as month, sum(cogs) as COGS
FROM sales
group by month_name
ORDER BY COGS DESC;

-- Product Line with the Highest revenue --
SELECT product_line, SUM(total) as total_revenue
FROM sales
GROUP BY product_line
ORDER BY total_revenue DESC;

-- City with the highest revenue --
SELECT city, SUM(total) as total_revenue
FROM sales
GROUP BY city
ORDER BY total_revenue desc;

-- Product line with the highest VAT --
SELECT product_line, AVG(VAT) as avg_tax
FROM sales
group by product_line
ORDER BY avg_tax DESC;

-- Branch with the most products sold --
SELECT branch,SUM(quantity) as qty
FROM SALES
group by branch
HAVING sum(quantity) > (SELECT AVG(quantity) FROM sales);

-- Most common product line by gender --
SELECT gender, product_line, count(gender) as total_count
FROM sales
GROUP BY gender,product_line
ORDER BY total_count DESC;

-- Average rating of each product line --
SELECT avg(rating) as avg_rating, product_line
FROM SALES
GROUP BY product_line
ORDER BY avg_rating DESC;

-- -- 
SELECT avg(quantity) as avg_qty,
	(CASE
		WHEN AVG(quantity) > 6 THEN "Good"
        ELSE "Bad"
    END
    ) AS remark
from sales
group by product_line;

-- Sales Analysis --
-- No.of sales made in each time of the day per weekday  --
SELECT time_of_day,count(*) as total_sales
FROM SALES
WHERE day_name ='Sunday'
GROUP BY time_of_day
ORDER BY total_sales DESC

-- Which type of customer brings in the most revenue --
SELECT customer_type, sum(total) as total_revenue
FROM SALES
GROUP BY customer_type
ORDER BY total_revenue DESC;

-- Which City has the highest VAT--
SELECT city , avg(VAT) as avg_vat
FROM SALES
GROUP BY city
ORDER BY avg_vat DESC;

-- Which customer type pays the most vat --
SELECT customer_type,AVG(VAT) as VAT
FROM SALES
GROUP BY customer_type
ORDER BY VAT DESC;

-- Customer Analysis --
-- Types of Customers --
SELECT distinct(customer_type) as customer
from sales

-- Unique Payment Methods -- 
SELECT DISTINCT payment_method
FROM SALES

-- Most common customer--
SELECT customer_type,count(customer_type) as count
from sales
group by customer_type
order by count desc;

-- Gender --
select gender, count(gender) as count
FROM SALES
group by gender
order by count desc;

-- Gender Distribution per branch --
SELECT gender , count(gender) as count
FROM sales
WHERE branch = 'A'
GROUP BY gender
ORDER BY count DESC

-- Which time of the day do customer give the most ratings  --
SELECT time_of_day, avg(rating) as avg_rating
FROM sales
GROUP BY time_of_day
ORDER BY avg_rating DESC;

-- Which time of the day do customer give the most ratings per branch  --
SELECT time_of_day, avg(rating) as avg_rating
FROM sales
WHERE branch = 'C'
GROUP BY time_of_day
ORDER BY avg_rating DESC;

-- Which day of the week has the best avg.ratings -- 
SELECT day_name, avg(rating) as avg_rating
FROM SALES
GROUP BY day_name
ORDER BY avg_rating DESC;

-- Which day of the week has the best avg.ratings per branch -- 
SELECT day_name, avg(rating) as avg_rating
FROM SALES
WHERE branch = 'A'
GROUP BY day_name
ORDER BY avg_rating DESC;