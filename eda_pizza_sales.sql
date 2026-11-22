-- 1. Summary Main KPI
SELECT 
	COUNT(DISTINCT od.order_id) as total_orders, 
    SUM(od.quantity) AS total_pizzas_sold, 
    round(SUM(od.quantity*p.price),2) AS total_revenue, 
    round(SUM(od.quantity*p.price)/count(DISTINCT od.order_id), 2) AS avg_order_value 
FROM order_details_clean od 
JOIN pizzas_clean p ON od.pizza_id = p.pizza_id;

-- 2. Melihat jam operasional dengan jumlah pesanan tertinggi
SELECT 
    HOUR(o.time) AS order_hour,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(od.quantity) AS total_pizzas_sold
FROM orders_clean o
JOIN order_details_clean od ON o.order_id = od.order_id
GROUP BY HOUR(o.time)
ORDER BY total_orders DESC;

-- 3. Melihat hari dengan transaksi dan omzet tertinggi
SELECT 
    DAYNAME(o.date) AS day_of_week,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(od.quantity * p.price), 2) AS total_revenue
FROM orders_clean o
JOIN order_details_clean od ON o.order_id = od.order_id
JOIN pizzas_clean p ON od.pizza_id = p.pizza_id
GROUP BY DAYNAME(o.date)
ORDER BY total_revenue DESC;

-- 4. Melihat pergerakan pesanan dan pendapatan tiap bulan
SELECT 
    MONTH(o.date) AS month_num,
    MONTHNAME(o.date) AS month_name,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(od.quantity * p.price), 2) AS total_revenue
FROM orders_clean o
JOIN order_details_clean od ON o.order_id = od.order_id
JOIN pizzas_clean p ON od.pizza_id = p.pizza_id
GROUP BY MONTH(o.date), MONTHNAME(o.date)
ORDER BY month_num ASC;

-- 5. 5 varian pizza penyumbang pendapatan terbesar
SELECT 
    pt.name AS pizza_name,
    pt.category,
    SUM(od.quantity) AS total_sold,
    ROUND(SUM(od.quantity * p.price), 2) AS total_revenue
FROM order_details_clean od
JOIN pizzas_clean p ON od.pizza_id = p.pizza_id
JOIN pizza_types_clean pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.name, pt.category
ORDER BY total_revenue DESC
LIMIT 5;

-- 6. 5 varian pizza dengan pendapatan terendah (bahan evaluasi menu/promo)
SELECT 
    pt.name AS pizza_name,
    pt.category,
    SUM(od.quantity) AS total_sold,
    ROUND(SUM(od.quantity * p.price), 2) AS total_revenue
FROM order_details_clean od
JOIN pizzas_clean p ON od.pizza_id = p.pizza_id
JOIN pizza_types_clean pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.name, pt.category
ORDER BY total_revenue ASC
LIMIT 5;

-- 7a. Persentase pendapatan berdasarkan kategori pizza
SELECT 
    pt.category,
    SUM(od.quantity) AS total_sold,
    ROUND(SUM(od.quantity * p.price), 2) AS category_revenue,
    ROUND(SUM(od.quantity * p.price) * 100.0 / (
        SELECT SUM(od2.quantity * p2.price)
        FROM order_details_clean od2
        JOIN pizzas_clean p2 ON od2.pizza_id = p2.pizza_id
    ), 2) AS revenue_pct
FROM order_details_clean od
JOIN pizzas_clean p ON od.pizza_id = p.pizza_id
JOIN pizza_types_clean pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.category
ORDER BY category_revenue DESC;

-- 7b. Proporsi penjualan berdasarkan ukuran pizza (S, M, L, XL, XXL)
SELECT 
    p.size,
    SUM(od.quantity) AS total_sold,
    ROUND(SUM(od.quantity * p.price), 2) AS size_revenue
FROM order_details_clean od
JOIN pizzas_clean p ON od.pizza_id = p.pizza_id
GROUP BY p.size
ORDER BY total_sold DESC;