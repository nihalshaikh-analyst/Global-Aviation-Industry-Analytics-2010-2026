-------------------------------------------------------------------
-- Exploratory Data Analysis (EDA) Using SQL
-------------------------------------------------------------------
-- Answer real business questions using SQL before building Power BI dashboards.

-- Basic Exploration
-- 1. Total Airlines
SELECT COUNT(DISTINCT airline_name) AS total_airlines
FROM airline_financials;

-- 2. Total Regions
SELECT DISTINCT region
FROM airline_financials;

-- 3. Year Range
SELECT
    MIN(year) AS start_year,
    MAX(year) AS end_year
FROM airline_financials;

-- 4. Total Revenue
SELECT
    ROUND(SUM(revenue_usd_bn),2) AS total_revenue
FROM airline_financials;

-- 5. Total Passengers
SELECT
    ROUND(SUM(passengers_carried_m),2) AS total_passengers
FROM airline_financials;

-- Business Questions

-- Q1. Which airlines generated the highest total revenue?
SELECT
    airline_name,
    ROUND(SUM(revenue_usd_bn),2) AS total_revenue
FROM airline_financials
GROUP BY airline_name
ORDER BY total_revenue DESC;

-- Q2. Top 10 Airlines by Revenue
SELECT
    airline_name,
    ROUND(SUM(revenue_usd_bn),2) AS total_revenue
FROM airline_financials
GROUP BY airline_name
ORDER BY total_revenue DESC
LIMIT 10;

-- Q3. Revenue Trend by Year
SELECT
    year,
    ROUND(SUM(revenue_usd_bn),2) AS revenue
FROM airline_financials
GROUP BY year
ORDER BY year;

-- Q4. COVID Revenue Impact
SELECT
    airline_name,
    MAX(CASE WHEN year=2019 THEN revenue_usd_bn END) AS revenue_2019,
    MAX(CASE WHEN year=2020 THEN revenue_usd_bn END) AS revenue_2020
FROM airline_financials
GROUP BY airline_name;

-- Q5. Best Operating Margin
SELECT
    airline_name,
    ROUND(AVG(operating_margin_pct),2) AS avg_margin
FROM airline_financials
GROUP BY airline_name
ORDER BY avg_margin DESC;

-- Q6. Business Model Performance
SELECT
    business_model,
    ROUND(AVG(revenue_usd_bn),2) AS avg_revenue,
    ROUND(AVG(operating_margin_pct),2) AS avg_margin
FROM airline_financials
GROUP BY business_model;

-- Q7. Passenger Growth
SELECT
    airline_name,
    ROUND(SUM(passengers_carried_m),2) AS passengers
FROM airline_financials
GROUP BY airline_name
ORDER BY passengers DESC;

-- Q8. Average Load Factor by Region
SELECT
    region,
    ROUND(AVG(load_factor_pct),2) AS avg_load_factor
FROM passenger_traffic
GROUP BY region
ORDER BY avg_load_factor DESC;

-- Q9. Manufacturer Comparison
SELECT
    manufacturer,
    SUM(orders_net) AS total_orders,
    SUM(deliveries) AS total_deliveries
FROM fleet_orders
GROUP BY manufacturer
ORDER BY total_orders DESC;

-- Q10. Most Profitable Routes
SELECT
    route,
    ROUND(SUM(annual_revenue_usd_m),2) AS revenue
FROM route_performance
GROUP BY route
ORDER BY revenue DESC
LIMIT 10;