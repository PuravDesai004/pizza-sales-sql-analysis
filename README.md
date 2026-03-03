# 🍕 Pizza Sales Data Analysis — SQL Project

A beginner SQL project analyzing pizza sales data to uncover business insights such as top-selling items, revenue trends, and customer order patterns.

---

## 📁 Files in This Repository

| File | Description |
|------|-------------|
| `pizza_sales_analysis.sql` | All SQL queries used in this project |
| `README.md` | Project overview and documentation |

---

## 🗄️ Dataset

**Table name:** `pizza_sales`

The dataset contains records of pizza orders including order date, pizza name, size, category, quantity, and price information.

| Column | Description |
|--------|-------------|
| `order_id` | Unique ID for each order |
| `order_date` | Date the order was placed |
| `pizza_name` | Name of the pizza |
| `pizza_id` | Unique pizza identifier |
| `pizza_category` | Category (e.g., Classic, Veggie) |
| `pizza_size` | Size (S, M, L, XL) |
| `quantity` | Number of pizzas ordered |
| `unit_price` | Price per pizza |
| `total_price` | Total price for that line item |

---

## 🔍 What This Project Covers

### ✅ Step 1 — Data Cleaning
- Converted the `order_date` column from a text format (`DD-MM-YYYY`) to a proper SQL `DATE` type using `STR_TO_DATE()`

### ✅ Step 2 — Data Exploration
- Viewed the full dataset
- Found the most expensive and cheapest pizzas
- Identified expensive pizzas that are still below the average price

### ✅ Step 3 — Business KPIs
- Top 5 best-selling pizzas by quantity
- Top 5 revenue-generating pizzas
- Revenue and quantity breakdown by pizza size
- Average order value
- Revenue by pizza category

### ✅ Step 4 — Time-Based Analysis
- Identified the highest revenue month
- Identified the highest revenue single day

### ✅ Step 5 — Advanced Analysis
- Top 3 best-selling pizzas within each category (using `RANK()` window function)
- Pizzas priced above their category's average (using `AVG() OVER PARTITION BY`)

---

## 🛠️ SQL Concepts Used

- `ALTER TABLE`, `UPDATE`, `STR_TO_DATE()` — data cleaning
- `GROUP BY`, `ORDER BY`, `LIMIT` — aggregation and sorting
- `SUM()`, `AVG()`, `COUNT()`, `ROUND()` — aggregate functions
- `WHERE` with subqueries — filtered lookups
- `WITH` (CTEs) — Common Table Expressions for readable queries
- `RANK() OVER (PARTITION BY ...)` — window functions for ranking within groups
- `AVG() OVER (PARTITION BY ...)` — window functions for category-level averages
- `DATE_FORMAT()` — formatting dates for time-based grouping

---

## 💡 Key Insights

- **Best-selling pizza:** Found by summing quantity across all orders grouped by pizza name
- **Highest revenue month:** Identified using a CTE with monthly grouping
- **Category leaders:** Used window functions to rank pizzas within each category independently
- **Above-average pricing:** Used partitioned window functions to compare each pizza's price to its category average

---

## 🚀 How to Run

1. Import the `pizza_sales` dataset into your MySQL database
2. Open `pizza_sales_analysis.sql` in MySQL Workbench (or any SQL client)
3. Run the queries step by step — each section is clearly labeled

> ⚠️ Run **Step 1 (Data Cleaning)** first before any other queries, since it converts the date column format that the rest of the queries depend on.

---

## 👤 About

This is a beginner-level data analytics project built to practice SQL skills including data cleaning, aggregation, time-series analysis, and window functions.

**Tool used:** MySQL  
**Author:** [Your Name]  
**LinkedIn:** [Your LinkedIn URL]
