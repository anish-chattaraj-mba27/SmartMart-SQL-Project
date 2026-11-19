-- SmartMart analytical queries | Run after 01_schema.sql and 02_sample_data.sql

-- A. SQL fundamentals: SELECT, WHERE, ORDER BY, DISTINCT, LIMIT
-- Q1. Display all active products with selling price.
SELECT product_id, product_name, unit_price
FROM products
WHERE is_active = TRUE
ORDER BY unit_price DESC;

-- Q2. List distinct customer cities.
SELECT DISTINCT city FROM customers ORDER BY city;

-- Q3. Find products priced between Rs. 100 and Rs. 300.
SELECT product_name, unit_price
FROM products
WHERE unit_price BETWEEN 100 AND 300
ORDER BY unit_price;

-- B. Joins
-- Q4. Product, category and supplier details (3-table join).
SELECT p.product_name, c.category_name, s.supplier_name, p.unit_price
FROM products p
INNER JOIN categories c ON p.category_id = c.category_id
INNER JOIN suppliers s ON p.supplier_id = s.supplier_id
ORDER BY c.category_name, p.product_name;

-- Q5. Order details with customer and employee.
SELECT o.order_id, o.order_date,
       CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
       CONCAT(e.first_name, ' ', e.last_name) AS handled_by,
       o.order_status
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
LEFT JOIN employees e ON o.employee_id = e.employee_id
ORDER BY o.order_date, o.order_id;

-- Q6. Completed order line items with product and customer.
SELECT o.order_id, o.order_date, c.first_name || ' ' || c.last_name AS customer,
       p.product_name, oi.quantity, oi.unit_price,
       ROUND((oi.quantity * oi.unit_price * (1 - oi.discount_pct/100.0))::numeric, 2) AS line_revenue
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
WHERE o.order_status = 'Completed'
ORDER BY o.order_id;

-- C. Aggregation and GROUP BY / HAVING
-- Q7. Total revenue by month (completed orders only).
SELECT TO_CHAR(o.order_date, 'YYYY-MM') AS sales_month,
       ROUND(SUM(oi.quantity * oi.unit_price * (1 - oi.discount_pct/100.0))::numeric, 2) AS revenue
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.order_status = 'Completed'
GROUP BY TO_CHAR(o.order_date, 'YYYY-MM')
ORDER BY sales_month;

-- Q8. Revenue by product category.
SELECT c.category_name,
       SUM(oi.quantity) AS units_sold,
       ROUND(SUM(oi.quantity * oi.unit_price * (1 - oi.discount_pct/100.0))::numeric, 2) AS revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
JOIN categories c ON p.category_id = c.category_id
JOIN orders o ON oi.order_id = o.order_id
WHERE o.order_status = 'Completed'
GROUP BY c.category_name
ORDER BY revenue DESC;

-- Q9. Customers with at least two completed orders.
SELECT c.customer_id, c.first_name || ' ' || c.last_name AS customer_name,
       COUNT(o.order_id) AS completed_orders
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_status = 'Completed'
GROUP BY c.customer_id, customer_name
HAVING COUNT(o.order_id) >= 2
ORDER BY completed_orders DESC;

-- D. Subqueries
-- Q10. Products priced above the overall average product price.
SELECT product_name, unit_price
FROM products
WHERE unit_price > (SELECT AVG(unit_price) FROM products)
ORDER BY unit_price DESC;

-- Q11. Customers whose completed spending is above average customer spending.
WITH customer_spend AS (
    SELECT o.customer_id,
           SUM(oi.quantity * oi.unit_price * (1 - oi.discount_pct/100.0)) AS spend
    FROM orders o JOIN order_items oi ON o.order_id = oi.order_id
    WHERE o.order_status = 'Completed'
    GROUP BY o.customer_id
)
SELECT c.customer_id, c.first_name || ' ' || c.last_name AS customer_name,
       ROUND(cs.spend::numeric, 2) AS total_spend
FROM customer_spend cs JOIN customers c ON c.customer_id = cs.customer_id
WHERE cs.spend > (SELECT AVG(spend) FROM customer_spend)
ORDER BY cs.spend DESC;

-- E. Inventory and supplier analysis
-- Q12. Products at or below their reorder level.
SELECT p.product_name, i.quantity_on_hand, i.reorder_level,
       s.supplier_name
FROM inventory i
JOIN products p ON i.product_id = p.product_id
JOIN suppliers s ON p.supplier_id = s.supplier_id
WHERE i.quantity_on_hand <= i.reorder_level
ORDER BY i.quantity_on_hand;

-- Q13. Supplier-level product count and average rating.
SELECT s.supplier_name, COUNT(p.product_id) AS products_supplied,
       s.rating
FROM suppliers s
LEFT JOIN products p ON s.supplier_id = p.supplier_id
GROUP BY s.supplier_id, s.supplier_name, s.rating
ORDER BY products_supplied DESC;

-- F. Advanced SQL: CTE and window functions
-- Q14. Rank products by completed sales revenue.
WITH product_revenue AS (
    SELECT p.product_id, p.product_name,
           SUM(oi.quantity * oi.unit_price * (1 - oi.discount_pct/100.0)) AS revenue
    FROM products p
    JOIN order_items oi ON p.product_id = oi.product_id
    JOIN orders o ON oi.order_id = o.order_id
    WHERE o.order_status = 'Completed'
    GROUP BY p.product_id, p.product_name
)
SELECT product_name, ROUND(revenue::numeric, 2) AS revenue,
       DENSE_RANK() OVER (ORDER BY revenue DESC) AS revenue_rank
FROM product_revenue
ORDER BY revenue_rank, product_name;

-- Q15. Running monthly revenue.
WITH monthly_sales AS (
    SELECT DATE_TRUNC('month', o.order_date)::date AS month_start,
           SUM(oi.quantity * oi.unit_price * (1 - oi.discount_pct/100.0)) AS revenue
    FROM orders o JOIN order_items oi ON o.order_id = oi.order_id
    WHERE o.order_status = 'Completed'
    GROUP BY DATE_TRUNC('month', o.order_date)::date
)
SELECT TO_CHAR(month_start, 'YYYY-MM') AS sales_month,
       ROUND(revenue::numeric, 2) AS monthly_revenue,
       ROUND(SUM(revenue) OVER (ORDER BY month_start)::numeric, 2) AS running_revenue
FROM monthly_sales
ORDER BY month_start;

-- Q16. Each customer's most recent order using ROW_NUMBER.
SELECT customer_id, order_id, order_date
FROM (
    SELECT customer_id, order_id, order_date,
           ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY order_date DESC, order_id DESC) AS rn
    FROM orders
) ranked_orders
WHERE rn = 1
ORDER BY customer_id;

-- G. Data quality checks / cleaning demonstrations
-- Q17. Find duplicate customer email values (should return no rows due to UNIQUE constraint).
SELECT LOWER(TRIM(email)) AS normalized_email, COUNT(*)
FROM customers
WHERE email IS NOT NULL
GROUP BY LOWER(TRIM(email))
HAVING COUNT(*) > 1;

-- Q18. Find blank or whitespace-only product names (should return no rows due to NOT NULL and input quality).
SELECT product_id, product_name
FROM products
WHERE product_name IS NULL OR BTRIM(product_name) = '';

-- Q19. Standardize customer city text in a safe SELECT preview.
SELECT customer_id, city AS original_city, INITCAP(BTRIM(city)) AS standardized_city
FROM customers
ORDER BY customer_id;

-- H. Business KPIs
-- Q20. Overall sales KPIs (completed orders).
SELECT COUNT(DISTINCT o.order_id) AS completed_orders,
       COUNT(DISTINCT o.customer_id) AS purchasing_customers,
       SUM(oi.quantity) AS units_sold,
       ROUND(SUM(oi.quantity * oi.unit_price * (1 - oi.discount_pct/100.0))::numeric, 2) AS gross_sales_after_discount,
       ROUND(AVG(order_total)::numeric, 2) AS average_order_value
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN (
    SELECT o2.order_id,
           SUM(oi2.quantity * oi2.unit_price * (1 - oi2.discount_pct/100.0)) AS order_total
    FROM orders o2 JOIN order_items oi2 ON o2.order_id = oi2.order_id
    WHERE o2.order_status = 'Completed'
    GROUP BY o2.order_id
) totals ON totals.order_id = o.order_id
WHERE o.order_status = 'Completed';

-- I. Transaction management demonstration
-- Run this block separately to see ROLLBACK; quantity should remain unchanged.
BEGIN;
UPDATE inventory SET quantity_on_hand = quantity_on_hand - 1 WHERE product_id = 101;
SELECT product_id, quantity_on_hand FROM inventory WHERE product_id = 101;
ROLLBACK;
SELECT product_id, quantity_on_hand FROM inventory WHERE product_id = 101;

-- COMMIT demonstration: this example creates a savepoint and then commits a valid stock note.
-- Run separately; the update is intentionally small and can be reset by re-running seed data.
BEGIN;
UPDATE inventory SET last_updated = CURRENT_TIMESTAMP WHERE product_id = 102;
SAVEPOINT before_commit;
UPDATE inventory SET quantity_on_hand = quantity_on_hand + 1 WHERE product_id = 102;
COMMIT;
