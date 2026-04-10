# Pizza Sales Analysis — SQL Project

SQL analysis of pizza sales data covering revenue trends, best-selling items,
category performance, and time-based patterns.

---

## Dashboard

![Pizza Dashboard](dashboard_screenshot.png)

---

## Dataset

Single table `pizza_sales` with order-level records including pizza name, size,
category, quantity, and pricing.

| Column | Description |
|---|---|
| order_id | Unique ID for each order |
| order_date | Date the order was placed |
| pizza_name | Name of the pizza |
| pizza_category | Category (Classic, Veggie, etc.) |
| pizza_size | Size (S, M, L, XL) |
| quantity | Number of pizzas ordered |
| unit_price | Price per pizza |
| total_price | Total price for that line item |

---

## Tools

| Tool | Purpose |
|---|---|
| MySQL Workbench | Data cleaning and SQL analysis |

---

## Key Findings

### 1. A small number of pizzas drive most revenue
The top 5 pizzas by revenue account for a disproportionate share of total sales.
Classic and premium categories consistently outperform others, suggesting menu
simplification could improve margins without impacting revenue significantly.

### 2. Size drives revenue more than quantity
Large pizzas generate more revenue per order despite not always being the
most ordered size. This points to an upselling opportunity — nudging customers
toward larger sizes at checkout could meaningfully increase average order value.

### 3. Revenue is concentrated in specific months and days
Analysis of order dates reveals clear peaks in monthly and daily revenue.
The highest revenue day and month are identifiable with simple time-based
queries, giving the business a basis for targeted promotions.

---

## SQL Concepts Used

- `ALTER TABLE`, `UPDATE`, `STR_TO_DATE()` — data type conversion
- `GROUP BY`, `ORDER BY`, `LIMIT` — aggregation and sorting
- `SUM()`, `AVG()`, `COUNT()`, `ROUND()` — aggregate functions
- `WHERE` with subqueries — filtered lookups
- `WITH` (CTEs) — breaking complex queries into readable steps
- `RANK() OVER (PARTITION BY ...)` — ranking within category groups
- `AVG() OVER (PARTITION BY ...)` — category-level average comparisons
- `DATE_FORMAT()` — time-based grouping

---

## Sample Query

```sql
-- top 3 best-selling pizzas per category using rank()
WITH ranked AS (
    SELECT pizza_category, pizza_name,
        SUM(quantity) AS total_qty,
        RANK() OVER (PARTITION BY pizza_category ORDER BY SUM(quantity) DESC) AS rnk
    FROM pizza_sales
    GROUP BY pizza_category, pizza_name
)
SELECT * FROM ranked WHERE rnk <= 3
ORDER BY pizza_category, rnk;
```

Full query file: [pizza_sales_analysis.sql](pizza_sales_analysis.sql)

---

## Files

```
├── pizza_sales_analysis.sql    
└── README.md
```

---

## How to Run

1. Import the pizza_sales dataset into your MySQL database
2. Open `pizza_sales_analysis.sql` in MySQL Workbench
3. Run Step 1 (data cleaning) first — it converts the date column format
4. Run remaining queries in order

---

## Author

Purav Desai
B.Tech IT — Semester 6 | SCET, Surat

GitHub: [PuravDesai004](https://github.com/PuravDesai004)
LinkedIn: https://www.linkedin.com/in/puravdesai41
