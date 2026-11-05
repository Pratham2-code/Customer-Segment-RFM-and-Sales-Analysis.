CREATE DATABASE ecommerce_analysis;
USE ecommerce_analysis;
CREATE TABLE ecommerce_data (
    order_id VARCHAR(30) PRIMARY KEY,
    customer_id VARCHAR(30),
    product_id VARCHAR(30),
    category VARCHAR(50),
    price DECIMAL(10,2),
    discount DECIMAL(5,2),
    quantity INT,
    payment_method VARCHAR(30),
    order_date DATE,
    delivery_time_days INT,
    region VARCHAR(30),
    returned VARCHAR(10),
    total_amount DECIMAL(10,2),
    shipping_cost DECIMAL(10,2),
    profit_margin DECIMAL(10,2),
    customer_age INT,
    customer_gender VARCHAR(20)
);

-- showing all the records
select * from ecommerce_data;

-- checking total records
select count(*) from ecommerce_data;

-- Checking unique orders
SELECT COUNT(DISTINCT order_id) AS unique_orders
FROM ecommerce_data;

-- Checking unique customers 
SELECT COUNT(DISTINCT customer_id) AS unique_customers
FROM ecommerce_data;

-- Checking date range
SELECT 
    MIN(order_date) AS earliest_date,
    MAX(order_date) AS latest_date
FROM ecommerce_data;

-- Checking NULL values
SELECT
    COUNT(*) - COUNT(order_id) AS missing_order_id,
    COUNT(*) - COUNT(customer_id) AS missing_customer_id,
    COUNT(*) - COUNT(product_id) AS missing_product_id,
    COUNT(*) - COUNT(order_date) AS missing_order_date,
    COUNT(*) - COUNT(total_amount) AS missing_total_amount
FROM ecommerce_data;

-- Business Query 1 — Overall Business Performance
-- 1) Business question: How much revenue did the e-commerce business generate, how many orders were placed, how many units were sold,and what was the average order value?
-- Query: Find the total revenue, total number of orders, total quantity sold, and average order value from the e-commerce dataset.
SELECT
SUM(total_amount) AS total_revenue, 
COUNT(order_id) AS total_orders, 
SUM(quantity) AS total_units_sold,
AVG(total_amount) AS average_order_value
FROM ecommerce_data;

-- Business Query 2 — Sales Trend Over Time
-- 2) Business question: How does the business's revenue and order volume change over time?
-- Query: Find the total revenue and number of orders for each month, sorted chronologically.
SELECT YEAR(order_date) AS order_year, MONTH(order_date) AS order_month,
SUM(total_amount) AS total_revenue,
COUNT(order_id) AS total_orders
FROM ecommerce_data
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY order_year, order_month;

-- Business Query 3 — Category Performance
-- 3) Business question: Which product categories generate the most revenue and receive the most orders?
-- Query: Find the total revenue, number of orders, and total units sold for each product category, and display the categories from highest to lowest revenue.
SELECT category, 
SUM(total_amount) AS total_revenue,
COUNT(order_id) AS total_orders,
SUM(quantity) AS total_units_sold
FROM ecommerce_data
GROUP BY category
ORDER BY total_revenue DESC;

-- Business Query 4 — Average Order Value by Category
-- 4) Business Question: Which product categories have the highest average order value?
-- Query: Calculate the average order value for each product category and display the categories from highest to lowest average order value.
SELECT category,
COUNT(order_id) AS total_orders,
SUM(total_amount) AS total_revenue,
AVG(total_amount) AS average_order_value
FROM ecommerce_data
GROUP BY category
ORDER BY average_order_value DESC;

-- Business Query 5 — Regional Performance
-- 5) Business question: Which regions generate the most revenue and receive the most orders?
-- Query: Calculate the total revenue, number of orders, and average order value for each region. Display the regions from highest to lowest total revenue.
SELECT region,
SUM(total_amount) AS total_revenue,
COUNT(order_id) AS total_orders,
AVG(total_amount) AS average_order_value
FROM ecommerce_data
GROUP BY region
ORDER BY total_revenue DESC;

-- Business Query 6 — Payment Method Analysis
-- 6) Business question: Which payment methods are most popular, and which generate the most revenue?
-- Calculate the total revenue, number of orders, and average order value for each payment method. Sort the results by order count, from highest to lowest.
SELECT payment_method,
COUNT(order_id) AS total_orders,
SUM(total_amount) AS total_revenue,
AVG(total_amount) AS average_order_value
FROM ecommerce_data GROUP BY payment_method 
ORDER BY total_orders DESC;

-- Business Query 7 — Return Rate Analysis
-- 7) Business question: What percentage of orders are returned, and which product categories have the highest return rates?
-- Query: Count the total orders and returned orders for each category, then calculate the return percentage.
SELECT category,
COUNT(*) AS total_orders,
SUM(returned = 'Yes') AS returned_orders,
ROUND(
	SUM(returned = 'Yes') * 100.0 / COUNT(*),
	2
) AS return_rate_percentage
FROM ecommerce_data
GROUP BY category
ORDER BY return_rate_percentage DESC;

-- Business Query 8 — Profitability by Product Category
-- 8) Business question: Which product categories generate the highest and lowest total profit?
-- Query: Calculate the total profit_margin for each category and sort the categories from highest to lowest.
SELECT category,
SUM(profit_margin) AS total_profit,
AVG(profit_margin) AS average_profit
FROM ecommerce_data
GROUP BY category
ORDER BY total_profit DESC;

-- Business Query 9 — Customer Purchase Frequency
-- 9) Business question: Which customers place the most orders?
-- Query: Count the orders for each customer and display the customers with the highest order counts first.
SELECT customer_id,
COUNT(order_id) AS total_orders,
SUM(total_amount) AS total_spent
FROM ecommerce_data
GROUP BY customer_id
ORDER BY total_orders DESC LIMIT 10;

-- Business Query 10 — Highest-Spending Customers
-- 10) Business question: Which customers generate the highest total revenue?
-- Query: Calculate the total spending and number of orders for each customer, then display the top 10 customers by total spending.
SELECT customer_id,
COUNT(order_id) AS total_orders,
SUM(total_amount) AS total_spent
FROM ecommerce_data
GROUP BY customer_id
ORDER BY total_spent DESC LIMIT 10;

-- Business Query 11 — Customer Spending by Region
-- 11) Business question: How does customer spending vary across regions, and which region has the highest average spending per customer?
-- Query: Calculate the number of unique customers, total revenue, and average revenue per customer in each region, then rank regions by average revenue per customer.
SELECT region,
COUNT(DISTINCT customer_id) AS total_customers,
SUM(total_amount) AS total_revenue,
ROUND(
	SUM(total_amount) / COUNT(DISTINCT customer_id),
	2
) AS revenue_per_customer
FROM ecommerce_data
GROUP BY region
ORDER BY revenue_per_customer DESC;

-- Business Query 12 — Customer Return Behavior
-- Business question: Do customers who return products have different spending patterns from customers who don't return products?
-- Query: Compare the number of orders, total revenue, and average order value for returned versus non-returned orders.
SELECT returned,
COUNT(order_id) AS total_orders,
SUM(total_amount) AS total_revenue,
ROUND(AVG(total_amount), 2) AS average_order_value
FROM ecommerce_data
GROUP BY returned
ORDER BY total_revenue DESC;

-- RFM Step 1: Build a customer-level summary
-- Which customers do we have, when did each customer last purchase, how many orders did each customer place, and how much did each customer spend?
SELECT customer_id,
MAX(order_date) AS last_purchase_date,
COUNT(DISTINCT order_id) AS total_orders,
SUM(total_amount) AS total_spent
FROM ecommerce_data
GROUP BY customer_id
ORDER BY total_spent DESC;

-- Simple validation before calculating RFM.
SELECT COUNT(*) AS customer_count
FROM (
    SELECT customer_id
    FROM ecommerce_data
    GROUP BY customer_id
) AS customer_summary;

-- RFM Step 2 — Calculate Recency
-- Business question: How many days has it been since each customer last purchased something?
SELECT customer_id,
MAX(order_date) AS last_purchase_date,
DATEDIFF('2025-09-11', MAX(order_date)) AS recency_days
FROM ecommerce_data
GROUP BY customer_id
ORDER BY recency_days ASC;

-- RFM Step 3 — Calculate Frequency
-- Business question: How many orders has each customer placed, and which customers have ordered most frequently?
SELECT customer_id,
COUNT(DISTINCT order_id) AS total_orders
FROM ecommerce_data
GROUP BY customer_id
ORDER BY total_orders DESC;

-- RFM Step 4 — Calculate Monetary Value
-- Business question: How much money has each customer spent in total?
SELECT customer_id,
ROUND(SUM(total_amount), 2) AS monetary
FROM ecommerce_data
GROUP BY customer_id
ORDER BY monetary DESC;

-- RFM Step 5: Combine R, F and M (Combine all three RFM metrics)
SELECT customer_id,
MAX(order_date) AS last_purchase_date,
DATEDIFF('2025-09-11', MAX(order_date)) AS recency_days,
COUNT(DISTINCT order_id) AS frequency,
ROUND(SUM(total_amount), 2) AS monetary
FROM ecommerce_data
GROUP BY customer_id
ORDER BY monetary DESC;

-- RFM Step 6: Calculate Recency Score.
-- Business question: Which customers have purchased most recently, and how should we score them?
SELECT customer_id,
DATEDIFF('2025-09-11', MAX(order_date)) AS recency_days,
    CASE
        WHEN DATEDIFF('2025-09-11', MAX(order_date)) <= 30 THEN 5
        WHEN DATEDIFF('2025-09-11', MAX(order_date)) <= 90 THEN 4
        WHEN DATEDIFF('2025-09-11', MAX(order_date)) <= 180 THEN 3
        WHEN DATEDIFF('2025-09-11', MAX(order_date)) <= 365 THEN 2
        ELSE 1
    END AS recency_score
FROM ecommerce_data
GROUP BY customer_id;

-- RFM Step 7: Calculate Frequency Score.
-- Business question: How frequently does each customer place orders, and which customers should receive the highest Frequency score?
SELECT customer_id,
COUNT(DISTINCT order_id) AS frequency,
CASE
	WHEN COUNT(DISTINCT order_id) >= 9 THEN 5
    WHEN COUNT(DISTINCT order_id) >= 7 THEN 4
	WHEN COUNT(DISTINCT order_id) >= 5 THEN 3
	WHEN COUNT(DISTINCT order_id) >= 3 THEN 2
	ELSE 1
END AS frequency_score
FROM ecommerce_data
GROUP BY customer_id
ORDER BY frequency DESC;

-- RFM Step 8: Calculate Monetary Score.
-- Business question: Which customers spend the most, and what Monetary score should each customer receive?
SELECT customer_id,
ROUND(SUM(total_amount), 2) AS monetary,
CASE
	WHEN SUM(total_amount) > 5000 THEN 5
	WHEN SUM(total_amount) > 3000 THEN 4
	WHEN SUM(total_amount) > 1500 THEN 3
	WHEN SUM(total_amount) > 500 THEN 2
	ELSE 1
END AS monetary_score
FROM ecommerce_data
GROUP BY customer_id
ORDER BY monetary DESC;

-- RFM Step 9: Combine all RFM metrics.
SELECT customer_id,
DATEDIFF('2025-09-11', MAX(order_date)) AS recency_days,
COUNT(DISTINCT order_id) AS frequency,
ROUND(SUM(total_amount), 2) AS monetary
FROM ecommerce_data
GROUP BY customer_id
ORDER BY monetary DESC;

-- RFM Step 10 — Calculate and combined all three RFM scores and metrics.
SELECT customer_id,
DATEDIFF('2025-09-11', MAX(order_date)) AS recency_days,
CASE
	WHEN DATEDIFF('2025-09-11', MAX(order_date)) <= 30 THEN 5
	WHEN DATEDIFF('2025-09-11', MAX(order_date)) <= 90 THEN 4
	WHEN DATEDIFF('2025-09-11', MAX(order_date)) <= 180 THEN 3
	WHEN DATEDIFF('2025-09-11', MAX(order_date)) <= 365 THEN 2
	ELSE 1
END AS recency_score,
COUNT(DISTINCT order_id) AS frequency,
CASE
	WHEN COUNT(DISTINCT order_id) >= 9 THEN 5
	WHEN COUNT(DISTINCT order_id) >= 7 THEN 4
	WHEN COUNT(DISTINCT order_id) >= 5 THEN 3
	WHEN COUNT(DISTINCT order_id) >= 3 THEN 2
	ELSE 1
END AS frequency_score,
ROUND(SUM(total_amount), 2) AS monetary,
CASE
	WHEN SUM(total_amount) > 5000 THEN 5
	WHEN SUM(total_amount) > 3000 THEN 4
	WHEN SUM(total_amount) > 1500 THEN 3
	WHEN SUM(total_amount) > 500 THEN 2
	ELSE 1
END AS monetary_score
FROM ecommerce_data
GROUP BY customer_id
ORDER BY monetary DESC;

-- RFM Step 11 — Create the combined RFM score.
SELECT customer_id,
CASE
	WHEN DATEDIFF('2025-09-11', MAX(order_date)) <= 30 THEN 5
	WHEN DATEDIFF('2025-09-11', MAX(order_date)) <= 90 THEN 4
	WHEN DATEDIFF('2025-09-11', MAX(order_date)) <= 180 THEN 3
	WHEN DATEDIFF('2025-09-11', MAX(order_date)) <= 365 THEN 2
	ELSE 1
END AS recency_score,
CASE
	WHEN COUNT(DISTINCT order_id) >= 9 THEN 5
	WHEN COUNT(DISTINCT order_id) >= 7 THEN 4
	WHEN COUNT(DISTINCT order_id) >= 5 THEN 3
	WHEN COUNT(DISTINCT order_id) >= 3 THEN 2
	ELSE 1
END AS frequency_score,
CASE
	WHEN SUM(total_amount) > 5000 THEN 5
	WHEN SUM(total_amount) > 3000 THEN 4
	WHEN SUM(total_amount) > 1500 THEN 3
	WHEN SUM(total_amount) > 500 THEN 2
	ELSE 1
END AS monetary_score
FROM ecommerce_data
GROUP BY customer_id;

-- Step 12 — combined and Create rfm_scores table.
CREATE TABLE rfm_scores AS
SELECT customer_id,
-- Recency --
DATEDIFF('2025-09-11', MAX(order_date)) AS recency_days,
CASE
	WHEN DATEDIFF('2025-09-11', MAX(order_date)) <= 30 THEN 5
	WHEN DATEDIFF('2025-09-11', MAX(order_date)) <= 90 THEN 4
	WHEN DATEDIFF('2025-09-11', MAX(order_date)) <= 180 THEN 3
	WHEN DATEDIFF('2025-09-11', MAX(order_date)) <= 365 THEN 2
	ELSE 1
END AS recency_score,
-- Frequency --
COUNT(DISTINCT order_id) AS frequency,
CASE
	WHEN COUNT(DISTINCT order_id) >= 9 THEN 5
	WHEN COUNT(DISTINCT order_id) >= 7 THEN 4
	WHEN COUNT(DISTINCT order_id) >= 5 THEN 3
	WHEN COUNT(DISTINCT order_id) >= 3 THEN 2
	ELSE 1
END AS frequency_score,
-- Monetary --
ROUND(SUM(total_amount), 2) AS monetary,
CASE
	WHEN SUM(total_amount) > 5000 THEN 5
	WHEN SUM(total_amount) > 3000 THEN 4
	WHEN SUM(total_amount) > 1500 THEN 3
	WHEN SUM(total_amount) > 500 THEN 2
	ELSE 1
END AS monetary_score
FROM ecommerce_data
GROUP BY customer_id
ORDER BY monetary DESC;

-- Step 1A — Create the customer segments table
CREATE TABLE customer_segments AS
SELECT customer_id, recency_score, frequency_score, monetary_score,
CASE
	WHEN recency_score >= 4
		AND frequency_score >= 4
		AND monetary_score >= 4
		   THEN 'Champions'

	WHEN recency_score <= 2
		AND frequency_score >= 3
		   THEN 'At Risk'

	WHEN recency_score >= 4
		AND frequency_score <= 2
		   THEN 'Potential Loyalists'
           
	WHEN frequency_score >= 4
		THEN 'Loyal Customers'

        ELSE 'Others'
    END AS customer_segment
FROM rfm_scores;

-- Step 1B — Verify the result
SELECT customer_segment,
COUNT(*) AS total_customers
FROM customer_segments
GROUP BY customer_segment
ORDER BY total_customers DESC;

-- Step 2 — Business Question 1: What percentage of customers belongs to each segment?
SELECT customer_segment,
COUNT(*) AS total_customers,
ROUND(
	COUNT(*) * 100.0 /
	(SELECT COUNT(*) FROM customer_segments),
	2
) AS customer_percentage
FROM customer_segments
GROUP BY customer_segment
ORDER BY total_customers DESC;

-- Business Question 2 — Which customer segments generate the most revenue?
SELECT cs.customer_segment,
COUNT(*) AS total_customers,
ROUND(SUM(r.monetary), 2) AS total_revenue,
ROUND(
	SUM(r.monetary) * 100.0 /
	(SELECT SUM(monetary) FROM rfm_scores),
	2
) AS revenue_percentage
FROM customer_segments cs
JOIN rfm_scores r
ON cs.customer_id = r.customer_id
GROUP BY cs.customer_segment
ORDER BY total_revenue DESC;

-- Business Question 3 - What is the average spending and purchase frequency of each customer segment?
SELECT cs.customer_segment,
COUNT(*) AS total_customers,
ROUND(AVG(r.monetary), 2) AS avg_spending,
ROUND(AVG(r.frequency), 2) AS avg_orders
FROM customer_segments AS cs
JOIN rfm_scores AS r
ON cs.customer_id = r.customer_id
GROUP BY cs.customer_segment
ORDER BY avg_spending DESC;

-- Business Question 4 — Who are the top 10 highest-spending customers, and how do they rank?
SELECT customer_id,
monetary AS total_spending,
RANK() OVER (ORDER BY monetary DESC) AS spending_rank
FROM rfm_scores
ORDER BY monetary DESC
LIMIT 10;

-- Business Question 5 — Which customers belong to the top 20% spending group?
SELECT customer_id,
monetary AS total_spending,
NTILE(5) OVER (ORDER BY monetary DESC) AS spending_group
FROM rfm_scores
ORDER BY monetary DESC
LIMIT 20;

-- Verifying the number of customers in each spending group.
SELECT
    spending_group,
    COUNT(*) AS total_customers
FROM (SELECT customer_id,
NTILE(5) OVER (ORDER BY monetary DESC) AS spending_group 
FROM rfm_scores) AS customer_groups
GROUP BY spending_group
ORDER BY spending_group;

-- exporting the important tables for dashboard.
select * from ecommerce_data;
select * from rfm_scores;
select * from customer_segments;










