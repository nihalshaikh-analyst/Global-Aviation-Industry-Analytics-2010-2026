```sql
-------------------------------------------------------------
-- Advanced SQL Analysis
-------------------------------------------------------------
-- Solve complex business problems using advanced SQL concepts

-- Business Scenario 1: Year-over-Year Revenue Growth
-- Question: Which airlines had the highest YoY revenue growth?

WITH revenue_growth AS (
    SELECT
        airline_name,
        year,
        revenue_usd_bn,
        LAG(revenue_usd_bn) OVER (PARTITION BY airline_name ORDER BY year) AS previous_revenue
    FROM airline_financials
)
SELECT
    airline_name,
    year,
    revenue_usd_bn,
    previous_revenue,
    ROUND(((revenue_usd_bn - previous_revenue) / previous_revenue), 2) AS growth_percent
FROM revenue_growth
WHERE previous_revenue IS NOT NULL
ORDER BY growth_percent DESC;

-- Business Scenario 2: Rank Airlines by Revenue
SELECT
    airline_name,
    year,
    revenue_usd_bn,
    RANK() OVER (PARTITION BY year ORDER BY revenue_usd_bn DESC) AS revenue_rank
FROM airline_financials;

-- Business Scenario 3: Top Airline in Each Region
WITH regional_revenue AS (
    SELECT
        region,
        airline_name,
        SUM(revenue_usd_bn) AS total_revenue,
        RANK() OVER (PARTITION BY region ORDER BY SUM(revenue_usd_bn) DESC) AS rnk
    FROM airline_financials
    GROUP BY region, airline_name
)
SELECT *
FROM regional_revenue
WHERE rnk = 1;

-- Business Scenario 4: Running Total Revenue
SELECT
    year,
    SUM(revenue_usd_bn) AS yearly_revenue,
    SUM(SUM(revenue_usd_bn))OVER (ORDER BY year) AS cumulative_revenue
FROM airline_financials
GROUP BY year
ORDER BY year;

-- Business Scenario 5: Compare with Industry Average
SELECT
    airline_name,
    year,
    revenue_usd_bn,
    (
        SELECT AVG(revenue_usd_bn)
        FROM airline_financials af2
        WHERE af2.year = af1.year
    ) AS industry_avg
FROM airline_financials af1;

-- Business Scenario 6: Airlines Above Average Margin
SELECT
    airline_name,
    operating_margin_pct
FROM airline_financials
WHERE operating_margin_pct >
(
    SELECT AVG(operating_margin_pct)
    FROM airline_financials
);

-- Business Scenario 7: Revenue Category
SELECT
    airline_name,
    revenue_usd_bn,
    CASE
        WHEN revenue_usd_bn >= 40 THEN 'High Revenue'
        WHEN revenue_usd_bn >= 20 THEN 'Medium Revenue'
        ELSE 'Low Revenue'
    END AS revenue_category
FROM airline_financials;

-- Business Scenario 8: Create a View
CREATE OR REPLACE VIEW vw_airline_summary AS
SELECT
    airline_name,
    SUM(revenue_usd_bn) AS total_revenue,
    AVG(operating_margin_pct) AS avg_margin,
    SUM(passengers_carried_m) AS total_passengers
FROM airline_financials
GROUP BY airline_name
ORDER BY total_revenue DESC;

-- Business Scenario 9: Top 3 Routes by Revenue
SELECT *
FROM
(
    SELECT
        year,
        route,
        annual_revenue_usd_m,
        ROW_NUMBER() OVER (PARTITION BY year ORDER BY annual_revenue_usd_m DESC) AS rn
    FROM route_performance
) 
WHERE rn <= 3;

-- Business Scenario 10: Boeing vs Airbus Trend
SELECT
    year,
    manufacturer,
    SUM(orders_net) AS net_orders
FROM fleet_orders
WHERE manufacturer IN ('Boeing','Airbus')
GROUP BY year, manufacturer
ORDER BY year, manufacturer;

---------------------------------------------------------------------

-- Business Question:
-- 1.Which airlines recovered fastest after COVID?

WITH revenue AS (
SELECT
    airline_name,
    year,
    revenue_usd_bn,
    MAX(CASE WHEN year=2019 THEN revenue_usd_bn END) OVER(PARTITION BY airline_name) AS revenue_2019
FROM airline_financials
)
SELECT *
FROM revenue
WHERE year>2019
AND revenue_usd_bn>=revenue_2019
ORDER BY year;

-- 2. Rank Airlines by Revenue Every Year
SELECT
    year,
    airline_name,
    revenue_usd_bn,
    DENSE_RANK() OVER(PARTITION BY year ORDER BY revenue_usd_bn DESC) AS revenue_rank
FROM airline_financials;

-- 3. Revenue Growth Compared to Previous Year
SELECT
    airline_name,
    year,
    revenue_usd_bn,
    LAG(revenue_usd_bn) OVER(PARTITION BY airline_name ORDER BY year) AS previous_year,
	ROUND(((revenue_usd_bn - LAG(revenue_usd_bn) OVER(PARTITION BY airline_name ORDER BY year))
	/
	LAG(revenue_usd_bn) OVER(PARTITION BY airline_name ORDER BY year))*100,2) AS growth_percentage
FROM airline_financials;

-- 4. Airlines with Continuous Revenue Growth
WITH cte AS (
	SELECT
		*,
		LAG(revenue_usd_bn)OVER(PARTITION BY airline_name ORDER BY year) AS prev
	FROM airline_financials
)
SELECT airline_name
FROM cte
GROUP BY airline_name
HAVING BOOL_AND(revenue_usd_bn>=prev);

-- 5. Highest Revenue Airline in Every Region
WITH cte AS (
	SELECT
		region,
		airline_name,
		SUM(revenue_usd_bn) revenue,
		RANK() OVER(PARTITION BY region ORDER BY SUM(revenue_usd_bn) DESC) AS rnk
	FROM airline_financials
	GROUP BY region,airline_name
	ORDER BY revenue DESC
)
SELECT *
FROM cte
WHERE rnk=1;

-- 6. Market Share of Every Airline
SELECT
	airline_name,
	SUM(revenue_usd_bn) revenue,
	ROUND(SUM(revenue_usd_bn)*100 / SUM(SUM(revenue_usd_bn)) OVER(), 2) AS market_share
FROM airline_financials
GROUP BY airline_name
ORDER BY market_share DESC;

-- 7. Which Airline Lost the Most Revenue During COVID?
SELECT
	airline_name,
	MAX(CASE WHEN year=2019 THEN revenue_usd_bn END) rev2019,
	MAX(CASE WHEN year=2020 THEN revenue_usd_bn END) rev2020,
	ROUND(MAX(CASE WHEN year=2019 THEN revenue_usd_bn END) - MAX(CASE WHEN year=2020 THEN revenue_usd_bn END), 2) AS loss
FROM airline_financials
GROUP BY airline_name
ORDER BY loss DESC;

-- 8. Running Revenue
SELECT
	year,
	SUM(revenue_usd_bn) revenue,
	SUM(SUM(revenue_usd_bn)) OVER(ORDER BY year) AS running_total
FROM airline_financials
GROUP BY year;

-- 9. Revenue vs Industry Average
SELECT
	airline_name,
	year,
	revenue_usd_bn,
	AVG(revenue_usd_bn) OVER(PARTITION BY year) AS industry_average
FROM airline_financials;

-- 10. Airlines Performing Better than Industry Average
WITH cte AS(
	SELECT
	*,
	AVG(revenue_usd_bn) OVER(PARTITION BY year) industry_avg
	FROM airline_financials
)
SELECT *
FROM cte
WHERE revenue_usd_bn>industry_avg;

-- 11. Boeing vs Airbus Market Share
SELECT
	manufacturer,
	SUM(orders_net) total_orders,
	ROUND(SUM(orders_net)*100/SUM(SUM(orders_net)) OVER(),2) market_share
FROM fleet_orders
GROUP BY manufacturer;

-- 12. Route Revenue Ranking
SELECT
	route,
	annual_revenue_usd_m,
	RANK() OVER(ORDER BY annual_revenue_usd_m DESC) route_rank
FROM route_performance;

-- 13. Top 5 Routes Every Year
SELECT *
FROM (
	SELECT
		year,
		route,
		annual_revenue_usd_m,
		ROW_NUMBER() OVER(PARTITION BY year ORDER BY annual_revenue_usd_m DESC) rn
	FROM route_performance
)
WHERE rn<=5;

-- 14. Passenger Growth by Region
SELECT
	region,
	year,
	SUM(rpk_billions),
	LAG(SUM(rpk_billions)) OVER(PARTITION BY region ORDER BY year)
FROM passenger_traffic
GROUP BY region,year;

-- 15. Best Performing Business Model
SELECT
	business_model,
	AVG(operating_margin_pct) AS average_margin,
	RANK() OVER(ORDER BY AVG(operating_margin_pct) DESC) ranking
FROM airline_financials
GROUP BY business_model;

-- 16. Airlines with Above Average Load Factor
SELECT *
FROM airline_financials
WHERE load_factor_pct >
	(
	SELECT AVG(load_factor_pct)
	FROM airline_financials
);

-- 17. Cumulative Passenger Growth
SELECT
	year,
	SUM(passengers_carried_m),
	SUM(SUM(passengers_carried_m)) OVER(ORDER BY year)
FROM airline_financials
GROUP BY year;

-- 18. Incident Analysis
SELECT
	year,
	COUNT(*) AS incidents,
	SUM(fatalities) AS fatalities
FROM aviation_incidents
GROUP BY year
ORDER BY year;

-- 19. Which Manufacturer Had More Safety Incidents?
SELECT
	CASE
		WHEN is_boeing THEN 'Boeing'
		WHEN is_airbus THEN 'Airbus'
		ELSE 'Other'
	END manufacturer,
	COUNT(*) incidents
FROM aviation_incidents
GROUP BY manufacturer;

-- 20. Five-Year Moving Average Revenue
SELECT
	year,
	SUM(revenue_usd_bn),
	AVG(SUM(revenue_usd_bn)) OVER(ORDER BY year ROWS BETWEEN 4 PRECEDING AND CURRENT ROW) moving_average
FROM airline_financials
GROUP BY year;
```

--------------------------------------------------------------------------------

