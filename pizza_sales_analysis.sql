-- ============================================================
-- PIZZA SALES DATA ANALYSIS
-- Tool: MySQL
-- Dataset: pizza_sales
-- Author: [Your Name]
-- ============================================================


-- ============================================================
-- STEP 1: DATA CLEANING
-- Convert order_date column from text to proper DATE format
-- ============================================================

-- Add a new column to store the converted date
ALTER TABLE pizza_sales
ADD COLUMN order_date_new DATE;

-- Fill the new column using the original text column (format: DD-MM-YYYY)
UPDATE pizza_sales
SET order_date_new = STR_TO_DATE(order_date, '%d-%m-%Y');

-- Check the result before deleting the old column
SELECT order_date, order_date_new
FROM pizza_sales
LIMIT 10;

-- Remove the old text column
ALTER TABLE pizza_sales
DROP COLUMN order_date;

-- Rename the new column to 'order_date'
ALTER TABLE pizza_sales
CHANGE order_date_new order_date DATE;


-- ============================================================
-- STEP 2: EXPLORE THE DATA
-- ============================================================

-- View all records in the table
SELECT * FROM pizza_sales;

-- Find the 5 most expensive pizzas
SELECT DISTINCT pizza_name, unit_price, pizza_size
FROM pizza_sales
ORDER BY unit_price DESC
LIMIT 5;

-- Find the 5 cheapest pizzas
SELECT DISTINCT pizza_name, unit_price, pizza_size
FROM pizza_sales
ORDER BY unit_price ASC
LIMIT 5;

-- Find the top 5 expensive pizzas that are still below the average price
SELECT pizza_name, pizza_id, unit_price
FROM pizza_sales
WHERE unit_price < (SELECT AVG(unit_price) FROM pizza_sales)
ORDER BY unit_price DESC
LIMIT 5;


-- ============================================================
-- STEP 3: KEY BUSINESS METRICS (KPIs)
-- ============================================================

-- Which 5 pizzas sold the most units?
SELECT pizza_name,
       SUM(quantity) AS total_quantity_sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_quantity_sold DESC
LIMIT 5;

-- Which 5 pizzas made the most revenue?
SELECT pizza_name,
       SUM(total_price) AS total_revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_revenue DESC
LIMIT 5;

-- How much revenue did each pizza size generate?
SELECT pizza_size,
       ROUND(SUM(total_price), 2) AS total_revenue
FROM pizza_sales
GROUP BY pizza_size
ORDER BY total_revenue DESC;

-- Which pizza size was ordered the most?
SELECT pizza_size,
       SUM(quantity) AS total_quantity
FROM pizza_sales
GROUP BY pizza_size
ORDER BY total_quantity DESC;

-- What is the average amount spent per order?
SELECT ROUND(SUM(total_price) / COUNT(DISTINCT order_id), 2) AS avg_order_value
FROM pizza_sales;

-- How much revenue did each pizza category generate?
SELECT pizza_category,
       ROUND(SUM(total_price), 2) AS total_revenue
FROM pizza_sales
GROUP BY pizza_category
ORDER BY total_revenue DESC;


-- ============================================================
-- STEP 4: TIME-BASED ANALYSIS
-- ============================================================

-- Which month had the highest revenue?
WITH monthly_revenue AS (
    SELECT
        DATE_FORMAT(order_date, '%Y-%m') AS month,
        ROUND(SUM(total_price), 2) AS total_revenue
    FROM pizza_sales
    GROUP BY DATE_FORMAT(order_date, '%Y-%m')
)
SELECT month, total_revenue
FROM monthly_revenue
ORDER BY total_revenue DESC
LIMIT 1;

-- Which single day had the highest revenue?
WITH daily_revenue AS (
    SELECT
        DATE_FORMAT(order_date, '%Y-%m-%d') AS day,
        ROUND(SUM(total_price), 2) AS total_revenue
    FROM pizza_sales
    GROUP BY DATE_FORMAT(order_date, '%Y-%m-%d')
)
SELECT day, total_revenue
FROM daily_revenue
ORDER BY total_revenue DESC
LIMIT 1;


-- ============================================================
-- STEP 5: ADVANCED ANALYSIS
-- ============================================================

-- Top 3 best-selling pizzas in each category
WITH pizza_rank AS (
    SELECT
        pizza_category,
        pizza_name,
        SUM(quantity) AS total_quantity,
        RANK() OVER (
            PARTITION BY pizza_category
            ORDER BY SUM(quantity) DESC
        ) AS rank_in_category
    FROM pizza_sales
    GROUP BY pizza_category, pizza_name
)
SELECT pizza_category,
       pizza_name,
       total_quantity
FROM pizza_rank
WHERE rank_in_category <= 3
ORDER BY pizza_category, total_quantity DESC;

-- Pizzas priced above their category's average price
SELECT *
FROM (
    SELECT DISTINCT
        pizza_name,
        pizza_category,
        unit_price,
        ROUND(AVG(unit_price) OVER (PARTITION BY pizza_category), 2) AS category_avg
    FROM pizza_sales
) t
WHERE unit_price > category_avg
ORDER BY pizza_category, unit_price DESC;
