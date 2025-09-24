-- Pizza Sales SQL Analysis Project
-- Database creation and table definitions

CREATE DATABASE d_manoj_pizza;
USE d_manoj_pizza;

-- Table: orders
CREATE TABLE orders (
    order_id INT NOT NULL PRIMARY KEY,
    order_date DATE NOT NULL,
    order_time TIME NOT NULL
);

-- Table: order_details
CREATE TABLE order_details (
    order_details_id INT NOT NULL PRIMARY KEY,
    order_id INT NOT NULL,
    pizza_id TEXT NOT NULL,
    quantity INT NOT NULL
);

-- Note: Tables pizzas and pizza_types are assumed preloaded with data.

-- ===============================
-- Basic Analysis
-- ===============================

-- 1. Total number of orders
SELECT COUNT(order_id) AS total_orders
FROM orders;

-- 2. Total revenue generated
SELECT SUM(order_details.quantity * pizzas.price) AS total_revenue
FROM order_details
JOIN pizzas ON order_details.pizza_id = pizzas.pizza_id;

-- 3. Highest-priced pizza
SELECT pizza_types.name, pizzas.price
FROM pizza_types
JOIN pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
ORDER BY pizzas.price DESC
LIMIT 1;

-- 4. Most common pizza size ordered
SELECT pizzas.size, COUNT(pizzas.size) AS most_common
FROM order_details
JOIN pizzas ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizzas.size
ORDER BY most_common DESC
LIMIT 1;

-- 5. Top 5 most ordered pizza types
SELECT pizza_types.name, SUM(order_details.quantity) AS total_quantity
FROM order_details
JOIN pizzas ON order_details.pizza_id = pizzas.pizza_id
JOIN pizza_types ON pizzas.pizza_type_id = pizza_types.pizza_type_id
GROUP BY pizza_types.name
ORDER BY total_quantity DESC
LIMIT 5;

-- ===============================
-- Intermediate Analysis
-- ===============================

-- 6. Total quantity of each pizza type ordered
SELECT pizza_types.name, SUM(order_details.quantity) AS total_quantity
FROM order_details
JOIN pizzas ON order_details.pizza_id = pizzas.pizza_id
JOIN pizza_types ON pizzas.pizza_type_id = pizza_types.pizza_type_id
GROUP BY pizza_types.name
ORDER BY total_quantity DESC;

-- 7. Total quantity of each pizza category
SELECT pizza_types.category, SUM(order_details.quantity) AS total_quantity
FROM order_details
JOIN pizzas ON order_details.pizza_id = pizzas.pizza_id
JOIN pizza_types ON pizzas.pizza_type_id = pizza_types.pizza_type_id
GROUP BY pizza_types.category
ORDER BY total_quantity DESC;

-- 8. Distribution of orders by hour of the day (per date)
SELECT COUNT(orders.order_id) AS order_count,
       orders.order_date,
       HOUR(order_time) AS order_hour
FROM orders
GROUP BY orders.order_date, order_hour
ORDER BY orders.order_date ASC, order_count DESC;

-- 9. Distribution of orders by hour (overall)
SELECT COUNT(order_id) AS order_count,
       HOUR(order_time) AS order_hour
FROM orders
GROUP BY order_hour
ORDER BY order_count DESC;

-- 10. Category-wise distribution of pizzas
SELECT pizza_types.category, COUNT(pizza_types.name) AS type_count
FROM pizza_types
GROUP BY pizza_types.category;

-- 11. Average number of pizzas ordered per day
SELECT ROUND(AVG(quantity), 2) AS avg_pizza_per_day
FROM (
    SELECT SUM(order_details.quantity) AS quantity,
           orders.order_date
    FROM order_details
    JOIN orders ON order_details.order_id = orders.order_id
    GROUP BY orders.order_date
) AS order_quantity;

-- 12. Top 3 most ordered pizza types based on revenue
SELECT pizza_types.name,
       SUM(pizzas.price * order_details.quantity) AS total_revenue
FROM order_details
JOIN pizzas ON order_details.pizza_id = pizzas.pizza_id
JOIN pizza_types ON pizzas.pizza_type_id = pizza_types.pizza_type_id
GROUP BY pizza_types.name
ORDER BY total_revenue DESC
LIMIT 3;

-- ===============================
-- Advanced Analysis
-- ===============================

-- 13. Percentage contribution of each pizza type to total revenue
SELECT pizza_types.name,
       ROUND(SUM(pizzas.price * order_details.quantity), 2) AS total_revenue,
       CONCAT(
           ROUND(
               ROUND(SUM(pizzas.price * order_details.quantity), 2) /
               (SELECT ROUND(SUM(pizzas.price * order_details.quantity), 2)
                FROM order_details
                JOIN pizzas ON order_details.pizza_id = pizzas.pizza_id), 4
           ) * 100, '%'
       ) AS revenue_percentage
FROM order_details
JOIN pizzas ON order_details.pizza_id = pizzas.pizza_id
JOIN pizza_types ON pizzas.pizza_type_id = pizza_types.pizza_type_id
GROUP BY pizza_types.name
ORDER BY total_revenue DESC;

-- 14. Cumulative revenue generated over time
SELECT order_date,
       SUM(revenue) OVER (ORDER BY order_date) AS cumulative_revenue
FROM (
    SELECT orders.order_date,
           SUM(order_details.quantity * pizzas.price) AS revenue
    FROM order_details
    JOIN orders ON orders.order_id = order_details.order_id
    JOIN pizzas ON order_details.pizza_id = pizzas.pizza_id
    GROUP BY orders.order_date
) AS sales
ORDER BY order_date;

-- 15. Top 3 most ordered pizza types by revenue for each category
SELECT name, total_revenue, category
FROM (
    SELECT category, name, total_revenue,
           RANK() OVER (PARTITION BY category ORDER BY total_revenue DESC) AS rn
    FROM (
        SELECT pizza_types.name,
               pizza_types.category,
               SUM(pizzas.price * order_details.quantity) AS total_revenue
        FROM order_details
        JOIN pizzas ON order_details.pizza_id = pizzas.pizza_id
        JOIN pizza_types ON pizzas.pizza_type_id = pizza_types.pizza_type_id
        GROUP BY pizza_types.name, pizza_types.category
    ) AS a
) AS b
WHERE b.rn <= 3
ORDER BY category, total_revenue DESC;
