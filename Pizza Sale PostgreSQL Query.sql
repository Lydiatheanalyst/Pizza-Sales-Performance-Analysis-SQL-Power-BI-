CREATE TABLE pizza_sales (
    pizza_id INTEGER PRIMARY KEY,
    order_id INTEGER NOT NULL,
    pizza_name_id VARCHAR(50) NOT NULL,
    quantity SMALLINT NOT NULL,
    order_date DATE NOT NULL,
    order_time TIME NOT NULL,
    unit_price NUMERIC(6,2) NOT NULL,
    total_price NUMERIC(6,2) NOT NULL,
    pizza_size CHAR(1) NOT NULL,
    pizza_category VARCHAR(20) NOT NULL,
    pizza_ingredients TEXT,
    pizza_name VARCHAR(100) NOT NULL
);

CREATE VIEW all_table AS
SELECT
    pizza_id,
    order_id,
    pizza_name_id,
    quantity,
    order_date,
    order_time,
    unit_price,
    total_price,
    pizza_size,
    pizza_category,
    pizza_ingredients,
    pizza_name
FROM pizza_sales;

--1. What is the total revenue on all pizza orders. 

SELECT SUM (total_price) AS total_pizza_revenue
FROM  pizza_sales;

--The total sales price is $802777.45


--2. What is the Average Order Value?

SELECT  ROUND (SUM(total_price) / COUNT(DISTINCT order_id),2) AS avg_order_value
FROM pizza_sales;

--Average order is 37.81

--3. Total pizza sold

SELECT SUM (quantity) AS pizza_sold
FROM pizza_sales;

--Pizza sold is 48,994

--4. Total orders

SELECT COUNT (DISTINCT order_id) AS total_orders
FROM pizza_sales;

--21,231 Pizza order

--5. Average pizza per order

SELECT SUM (Quantity)/COUNT (DISTINCT Order_id) AS avg_pizza_order
FROM pizza_sales;

--The average pizza order per pizza is 2

--6. Trend of sales through out the week?

SELECT 
    TO_CHAR(order_date, 'Day') AS order_day,
    COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY TO_CHAR(order_date, 'Day')
ORDER BY  total_orders DESC ;

/*
Friday has the highest sales with a total number of 3515 pizza sold
Thursday has the second highest with 3223 pizza sold
Saturday is third on the list with 3136
Wednesday is fourth with 3007
Tuesday is fifth wit 2957
Monday is sixth with 2781
Sunday is seventh with 2612 pizza solde
*/

--7. Trend of sales through out the month

SELECT 
    TO_CHAR(order_date, 'Month') AS order_month,
    COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY TO_CHAR(order_date, 'Month')
ORDER BY  total_orders DESC ;

/*

"July     "	1924
"May      "	1843
"January  "	1835
"March    "	1833
"August   "	1830
"April    "	1784
"November "	1781
"June     "	1757
"February "	1675
"December "	1671
"September"	1656
"October  "	1642

*/


--8. Percentage of sales by pizza category

SELECT 
    pizza_category,
    ROUND(SUM(total_price), 2) AS total_revenue,
    ROUND(SUM(total_price) * 100.0 / (SELECT SUM(total_price) FROM pizza_sales), 2) AS pct
FROM pizza_sales
GROUP BY pizza_category;

/*
"Supreme"	208197.00	25.93
"Chicken"	195919.50	24.41
"Veggie"	193690.45	24.13
"Classic"	204970.50	25.53

*/


--9. percentage of sales by pizza sizes
SELECT *
FROM pizza_sales;

SELECT 
    pizza_size,
    ROUND(SUM(total_price), 2) AS total_revenue,
    ROUND(SUM(total_price) * 100.0 / (SELECT SUM(total_price) FROM pizza_sales), 2) AS ps
FROM pizza_sales
GROUP BY pizza_size;

/*

"S"	178076.50	22.18
"M"	249382.25	31.06
"L"	375318.70	46.75

*/

--10. Total pizza sold by category

SELECT  pizza_category, SUM (quantity) AS total_quantity_sold
FROM pizza_sales
GROUP BY pizza_category
ORDER BY total_quantity_sold;
/*
"Chicken"	11050
"Veggie"	11649
"Supreme"	11987
"Classic"	14308

*/

--11. orders sold in February

-- Orders sold in February
SELECT pizza_category,SUM(quantity) AS total_quantity_sold
FROM pizza_sales
WHERE EXTRACT(MONTH FROM order_date) = 2
GROUP BY pizza_category
ORDER BY total_quantity_sold DESC;
/*
"Classic"	1137
"Supreme"	964
"Veggie"	944
"Chicken"	875
*/

--12. Top 5 pizza by revenue

SELECT pizza_name, SUM (total_price) AS pizza_revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY pizza_revenue DESC
LIMIT 5;
/*
"The Thai Chicken Pizza"	43434.25
"The Barbecue Chicken Pizza"	42768.00
"The California Chicken Pizza"	41409.50
"The Classic Deluxe Pizza"	38180.50
"The Spicy Italian Pizza"	34831.25

*/

--13. Bottom performing pizza

SELECT pizza_name, SUM (total_price) AS pizza_revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY pizza_revenue ASC
LIMIT 5;

/*
"The Brie Carre Pizza"	11588.50
"The Greek Pizza"	13371.50
"The Green Garden Pizza"	13955.75
"The Spinach Supreme Pizza"	15277.75
"The Mediterranean Pizza"	15360.50
*/

--14. Top 5 pizza by quantity

SELECT pizza_name, SUM(quantity) AS top_pizza_quantity_sold
FROM pizza_sales
GROUP BY pizza_name 
ORDER BY top_pizza_quantity_sold DESC
LIMIT 5;

/*
"The Classic Deluxe Pizza"	2453
"The Barbecue Chicken Pizza"	2432
"The Hawaiian Pizza"	2422
"The Pepperoni Pizza"	2418
"The Thai Chicken Pizza"	2371
*/

--15.Least pizza sold
SELECT pizza_name, SUM(quantity) AS least_pizza_quantity_sold
FROM pizza_sales
GROUP BY pizza_name 
ORDER BY least_pizza_quantity_sold ASC
LIMIT 5;

/*

"The Brie Carre Pizza"	490
"The Greek Pizza"	840
"The Mediterranean Pizza"	934
"The Calabrese Pizza"	937
"The Spinach Supreme Pizza"	950

*/

--16. Top 5 Pizzas by Total Orders

SELECT pizza_name, COUNT(DISTINCT order_id) AS Top_pizza_orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_pizza_orders DESC
LIMIT 5;

/*
"The Classic Deluxe Pizza"	2329
"The Hawaiian Pizza"	2280
"The Pepperoni Pizza"	2278
"The Barbecue Chicken Pizza"	2273
"The Thai Chicken Pizza"	2225
*/


--17. Bottom 5 Pizzas by Total Orders

SELECT pizza_name, COUNT(DISTINCT order_id) AS bottom_pizza_orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Bottom_pizza_orders ASC
LIMIT 5;

/*
"The Brie Carre Pizza"	480
"The Greek Pizza"	823
"The Mediterranean Pizza"	912
"The Calabrese Pizza"	918
"The Spinach Supreme Pizza"	918

*/