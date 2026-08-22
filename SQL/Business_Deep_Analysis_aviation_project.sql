-----------------------------------------------------------------------------
-- ** Business_Scenarios Deep Analysis ** --
-----------------------------------------------------------------------------

-- ** Revenue & Financial Analysis ** --
-- airline_financials
-- 1. Which airline generated the highest total revenue from 2010–2026?
SELECT
    airline_name,
    ROUND(SUM(revenue_usd_bn), 2) AS total_revenue
FROM airline_financials
GROUP BY airline_name
ORDER BY total_revenue DESC
LIMIT 1;

-- 2. What was the year-over-year revenue growth for each airline?
WITH revenue_growth AS (
	SELECT
    	airline_name,
    	year,
    	revenue_usd_bn,
    	LAG(revenue_usd_bn) OVER(PARTITION BY airline_name ORDER BY year) AS previous_revenue
	FROM airline_financials
)
SELECT
    airline_name,
    year,
    revenue_usd_bn,
    previous_revenue,
    ROUND(((revenue_usd_bn - previous_revenue) / previous_revenue) * 100, 2) AS yoy_growth_percent
FROM revenue_growth
WHERE previous_revenue IS NOT NULL
ORDER BY airline_name, year;

-- 3. Which airlines experienced the largest revenue decline during COVID-19 (2019 → 2020)?
SELECT
    airline_name,
    MAX(CASE WHEN year = 2019 THEN revenue_usd_bn END) AS revenue_2019,
    MAX(CASE WHEN year = 2020 THEN revenue_usd_bn END) AS revenue_2020,
    ROUND((MAX(CASE WHEN year = 2020 THEN revenue_usd_bn END)
            - MAX(CASE WHEN year = 2019 THEN revenue_usd_bn END)), 2) AS revenue_change
FROM airline_financials
GROUP BY airline_name
ORDER BY revenue_change;

-- 4. Which airlines recovered to pre-COVID (2019) revenue levels the fastest?
WITH revenue_2019 AS (
	SELECT
    	airline_name,
    	revenue_usd_bn AS revenue_2019
	FROM airline_financials
	WHERE year = 2019
)
SELECT
    af.airline_name,
    MIN(af.year) AS recovery_year
FROM airline_financials af JOIN revenue_2019 r
ON af.airline_name = r.airline_name
WHERE af.year > 2020 AND af.revenue_usd_bn >= r.revenue_2019
GROUP BY af.airline_name
ORDER BY recovery_year;

-- 5. What is the average annual revenue by airline?
SELECT
    airline_name,
    ROUND(AVG(revenue_usd_bn),2) AS average_annual_revenue
FROM airline_financials
GROUP BY airline_name
ORDER BY average_annual_revenue DESC;

-- 6. Which region generated the highest airline revenue?
SELECT
    region,
    ROUND(SUM(revenue_usd_bn),2) AS total_revenue
FROM airline_financials
GROUP BY region
ORDER BY total_revenue DESC;

-- 7. Which airline had the highest operating income over the study period?
SELECT
    airline_name,
    ROUND(SUM(operating_income_usd_bn),2) AS total_operating_income
FROM airline_financials
GROUP BY airline_name
ORDER BY total_operating_income DESC
LIMIT 1;

-- 8. Which airlines reported negative operating margins, and in which years?
SELECT
    airline_name,
    year,
    operating_margin_pct
FROM airline_financials
WHERE operating_margin_pct < 0
ORDER BY airline_name, year;

-- 9. What percentage of total industry revenue did the Top 5 airlines contribute?
WITH top5 AS (
	SELECT
    	airline_name,
    	SUM(revenue_usd_bn) AS revenue
	FROM airline_financials
	GROUP BY airline_name
	ORDER BY revenue DESC
	LIMIT 5
),
industry AS (
	SELECT
    	SUM(revenue_usd_bn) AS total_revenue
	FROM airline_financials
)
SELECT
    ROUND((SUM(top5.revenue) / industry.total_revenue) * 100, 2) AS top5_revenue_percentage
FROM top5
CROSS JOIN industry;

-- 10. Which years had the highest and lowest industry revenue?
SELECT
    year,
    ROUND(SUM(revenue_usd_bn),2) AS industry_revenue
FROM airline_financials
GROUP BY year
ORDER BY industry_revenue DESC;

-- To see only the highest revenue year
SELECT
    year,
    ROUND(SUM(revenue_usd_bn),2) AS industry_revenue
FROM airline_financials
GROUP BY year
ORDER BY industry_revenue DESC
LIMIT 1;

-- To see only the lowest revenue year
SELECT
    year,
    ROUND(SUM(revenue_usd_bn),2) AS industry_revenue
FROM airline_financials
GROUP BY year
ORDER BY industry_revenue ASC
LIMIT 1;

----------------------------------------------------------------

-- ** Passenger & Demand Analysis ** --
-- airline_financials and passenger_traffic
-- 11. Which airline carried the most passengers?
SELECT
    airline_name,
    ROUND(SUM(passengers_carried_m),2) AS total_passengers
FROM airline_financials
GROUP BY airline_name
ORDER BY total_passengers DESC
LIMIT 1;

-- 12. How did passenger traffic change year over year?
WITH yearly_passengers AS (
    SELECT
        year,
        SUM(passengers_carried_m) AS total_passengers
    FROM airline_financials
    GROUP BY year
)

SELECT
    year,
    total_passengers,
    LAG(total_passengers) OVER(ORDER BY year) AS previous_year,
    ROUND(((total_passengers - LAG(total_passengers) OVER(ORDER BY year))
        /  LAG(total_passengers) OVER(ORDER BY year))*100, 2) AS yoy_growth_pct
FROM yearly_passengers;

-- 13. Which region experienced the highest passenger demand?
SELECT
    region,
    ROUND(SUM(rpk_billions),2) AS total_rpk
FROM passenger_traffic
GROUP BY region
ORDER BY total_rpk DESC;

-- 14. Which region had the fastest post-COVID recovery?
-- (Compare 2019 vs 2024 RPK Recovery)
-- SELECT
    region,
    SUM(CASE WHEN year=2019 THEN rpk_billions END) AS rpk_2019,
    SUM(CASE WHEN year=2024 THEN rpk_billions END) AS rpk_2024,
    ROUND((SUM(CASE WHEN year=2024 THEN rpk_billions END)
        / SUM(CASE WHEN year=2019 THEN rpk_billions END))*100, 2) AS recovery_pct
FROM passenger_traffic
GROUP BY region
ORDER BY recovery_pct DESC;

-- 15. Which region had the highest average load factor?
SELECT
    region,
    ROUND(AVG(load_factor_pct),2) AS avg_load_factor
FROM passenger_traffic
GROUP BY region
ORDER BY avg_load_factor DESC;

-- 16. Which airlines consistently maintained a load factor above 85%?
SELECT
    airline_name,
    ROUND(AVG(load_factor_pct),2) AS avg_load_factor
FROM airline_financials
GROUP BY airline_name
HAVING MIN(load_factor_pct) > 85
ORDER BY avg_load_factor DESC;
-- Alternative (Average > 85%)
SELECT
    airline_name,
    ROUND(AVG(load_factor_pct),2) AS avg_load_factor
FROM airline_financials
GROUP BY airline_name
HAVING AVG(load_factor_pct) > 85
ORDER BY avg_load_factor DESC;

-- 17. Which month has the highest passenger demand across all regions?
SELECT
    month,
    ROUND(SUM(rpk_billions),2) AS total_rpk
FROM passenger_traffic
GROUP BY month
ORDER BY total_rpk DESC;

-- 18. Which region had the steepest decline in RPK during COVID?
-- (2019 -> 2020)
SELECT
    region,
    SUM(CASE WHEN year=2019 THEN rpk_billions END) AS rpk_2019,
    SUM(CASE WHEN year=2020 THEN rpk_billions END) AS rpk_2020,
    ROUND(((SUM(CASE WHEN year=2020 THEN rpk_billions END) 
		- SUM(CASE WHEN year=2019 THEN rpk_billions END))
        / SUM(CASE WHEN year=2019 THEN rpk_billions END))*100 ,2) AS decline_pct
FROM passenger_traffic
GROUP BY region
ORDER BY decline_pct;

-- 19. Compare RPK vs ASK for each region
SELECT
    region,
    ROUND(SUM(rpk_billions),2) AS total_rpk,
    ROUND(SUM(ask_billions),2) AS total_ask,
    ROUND(AVG(load_factor_pct),2) AS avg_load_factor
FROM passenger_traffic
GROUP BY region
ORDER BY total_rpk DESC;

-- 20. Which airlines improved their load factor the most after COVID?
-- (Compare 2020 vs 2024)
SELECT
    airline_name,
    MAX(CASE WHEN year=2020 THEN load_factor_pct END) AS load_factor_2020,
    MAX(CASE WHEN year=2024 THEN load_factor_pct END) AS load_factor_2024,
    ROUND(MAX(CASE WHEN year=2024 THEN load_factor_pct END) -
        MAX(CASE WHEN year=2020 THEN load_factor_pct END) ,2) AS improvement
FROM airline_financials
GROUP BY airline_name
ORDER BY improvement DESC;

--------------------------------------------------------------------------------

-- ** Fleet & Manufacturer Analysis ** -- 
-- fleet_orders
-- 21. Which manufacturer received the highest gross orders?
SELECT
    manufacturer,
    SUM(orders_gross) AS total_gross_orders
FROM fleet_orders
GROUP BY manufacturer
ORDER BY total_gross_orders DESC;

-- 22. Which manufacturer had the highest net orders?
SELECT
    manufacturer,
    SUM(orders_net) AS total_net_orders
FROM fleet_orders
GROUP BY manufacturer
ORDER BY total_net_orders DESC;

-- 23. How did Boeing orders change after the 737 MAX crisis?
SELECT
    year,
    orders_gross,
    orders_net,
    deliveries
FROM fleet_orders
WHERE manufacturer = 'Boeing'
ORDER BY year;
Growth Analysis using LAG()
SELECT
    year,
    orders_net,
    LAG(orders_net) OVER(ORDER BY year) AS previous_year,
    ROUND(
        ((orders_net - LAG(orders_net) OVER(ORDER BY year))
        *100.0 /
        LAG(orders_net) OVER(ORDER BY year)),2
    ) AS growth_percent
FROM fleet_orders
WHERE manufacturer='Boeing'
ORDER BY year;

-- 24. Compare Boeing and Airbus deliveries by year
SELECT
    year,
    manufacturer,
    SUM(deliveries) AS total_deliveries
FROM fleet_orders
WHERE manufacturer IN ('Boeing','Airbus')
GROUP BY year, manufacturer
ORDER BY year, manufacturer;

-- 25. Which aircraft family had the highest demand?
SELECT
    aircraft_family,
    SUM(orders_gross) AS total_orders
FROM fleet_orders
GROUP BY aircraft_family
ORDER BY total_orders DESC;

-- 26. Which manufacturer has the largest backlog?
SELECT
    manufacturer,
    SUM(backlog_end_of_year) AS total_backlog
FROM fleet_orders
GROUP BY manufacturer
ORDER BY total_backlog DESC;

-- 27. How did COMAC grow between 2023 and 2026?
SELECT
    year,
    orders_gross,
    orders_net,
    deliveries,
    backlog_end_of_year
FROM fleet_orders
WHERE manufacturer='COMAC'
AND year BETWEEN 2023 AND 2026
ORDER BY year;
With Year-over-Year Growth
SELECT
    year,
    orders_net,
    LAG(orders_net) OVER(ORDER BY year) AS previous_orders,
    ROUND(
        ((orders_net-LAG(orders_net) OVER(ORDER BY year))
        *100.0/
        LAG(orders_net) OVER(ORDER BY year)),2
    ) AS growth_percentage
FROM fleet_orders
WHERE manufacturer='COMAC'
ORDER BY year;

-- 28. What percentage of all aircraft orders belongs to Boeing vs Airbus?
SELECT
    manufacturer,
    SUM(orders_gross) AS total_orders,
    ROUND(
        SUM(orders_gross)*100.0/
        (SELECT SUM(orders_gross)
         FROM fleet_orders
         WHERE manufacturer IN ('Boeing','Airbus')),
    2) AS percentage_share
FROM fleet_orders
WHERE manufacturer IN ('Boeing','Airbus')
GROUP BY manufacturer
ORDER BY percentage_share DESC;

-- 29. Which years saw the highest aircraft deliveries?
SELECT
    year,
    SUM(deliveries) AS total_deliveries
FROM fleet_orders
GROUP BY year
ORDER BY total_deliveries DESC;

-- Top 5 years
SELECT
    year,
    SUM(deliveries) AS total_deliveries
FROM fleet_orders
GROUP BY year
ORDER BY total_deliveries DESC
LIMIT 5;

-- 30. Which manufacturer experienced the largest order cancellations?
-- Order cancellations can be calculated 
-- Gross Orders − Net Orders
SELECT
    manufacturer,
    SUM(orders_gross - orders_net) AS total_cancellations
FROM fleet_orders
GROUP BY manufacturer
ORDER BY total_cancellations DESC;
By Year
SELECT
    manufacturer,
    year,
    (orders_gross - orders_net) AS cancellations
FROM fleet_orders
ORDER BY cancellations DESC;
------------------------
-- Which manufacturer dominated each year?
WITH yearly_orders AS
(
    SELECT
        year,
        manufacturer,
        SUM(orders_net) AS total_orders,
        RANK() OVER(
            PARTITION BY year
            ORDER BY SUM(orders_net) DESC
        ) AS rnk
    FROM fleet_orders
    GROUP BY year, manufacturer
)
SELECT
    year,
    manufacturer,
    total_orders
FROM yearly_orders
WHERE rnk = 1
ORDER BY year;

------------------------------------------------------------------------------

-- ** Regional Analysis ** --
-- passenger_traffic
--31. Which region generated the highest passenger traffic?
SELECT
    region,
    ROUND(SUM(rpk_billions),2) AS total_passenger_traffic
FROM passenger_traffic
GROUP BY region
ORDER BY total_passenger_traffic DESC;

-- 32. Which region recovered first after COVID?
-- Find the first year each region's annual RPK met or exceeded its 2019 level.
WITH yearly_traffic AS (
    SELECT
        region,
        year,
        SUM(rpk_billions) AS yearly_rpk
    FROM passenger_traffic
    GROUP BY region, year
),
baseline AS (
    SELECT
        region,
        yearly_rpk AS rpk_2019
    FROM yearly_traffic
    WHERE year = 2019
)
SELECT
    yt.region,
    MIN(yt.year) AS recovery_year
FROM yearly_traffic yt
JOIN baseline b
ON yt.region = b.region
WHERE yt.year > 2019
  AND yt.yearly_rpk >= b.rpk_2019
GROUP BY yt.region
ORDER BY recovery_year;

-- 33. Which region had the highest average revenue growth?
-- Since passenger_traffic has no revenue column, this question should use RPK growth.
WITH yearly AS (
    SELECT
        region,
        year,
        SUM(rpk_billions) AS yearly_rpk
    FROM passenger_traffic
    GROUP BY region, year
),
growth AS (
    SELECT
        region,
        year,
        yearly_rpk,
        LAG(yearly_rpk) OVER(PARTITION BY region ORDER BY year) AS prev_year
    FROM yearly
)
SELECT
    region,
    ROUND(AVG(((yearly_rpk-prev_year)/prev_year)*100),2) AS avg_growth_pct
FROM growth
WHERE prev_year IS NOT NULL
GROUP BY region
ORDER BY avg_growth_pct DESC;

-- 34. Compare North America and Europe over time.
SELECT
    year,
    region,
    ROUND(SUM(rpk_billions),2) AS passenger_traffic
FROM passenger_traffic
WHERE region IN ('North America','Europe')
GROUP BY year, region
ORDER BY year, region;

-- 35. Which region had the lowest average load factor?
SELECT
    region,
    ROUND(AVG(load_factor_pct),2) AS avg_load_factor
FROM passenger_traffic
GROUP BY region
ORDER BY avg_load_factor ASC;

-- 36. Which regions show the strongest long-term growth?
WITH yearly AS (
    SELECT
        region,
        year,
        SUM(rpk_billions) AS yearly_rpk
    FROM passenger_traffic
    GROUP BY region, year
)
SELECT
    region,
    ROUND(
        (
            MAX(yearly_rpk)-MIN(yearly_rpk)
        )/MIN(yearly_rpk)*100
    ,2) AS growth_percentage
FROM yearly
GROUP BY region
ORDER BY growth_percentage DESC;

-- 37. Which region experienced the largest COVID decline?
WITH yearly AS (
    SELECT
        region,
        year,
        SUM(rpk_billions) AS yearly_rpk
    FROM passenger_traffic
    GROUP BY region, year
),
covid AS (
    SELECT
        a.region,
        a.yearly_rpk AS rpk_2019,
        b.yearly_rpk AS rpk_2020
    FROM yearly a
    JOIN yearly b
    ON a.region=b.region
    WHERE a.year=2019
      AND b.year=2020
)
SELECT
    region,
    ROUND(((rpk_2020-rpk_2019)/rpk_2019)*100, 2) AS decline_percentage
FROM covid
ORDER BY decline_percentage;

-- 38. How has Asia Pacific recovered since 2020?
SELECT
    year,
    ROUND(SUM(rpk_billions),2) AS passenger_traffic,
    ROUND(AVG(load_factor_pct),2) AS avg_load_factor
FROM passenger_traffic
WHERE region='Asia Pacific'
AND year>=2020
GROUP BY year
ORDER BY year;

-- 39. Which regions exceeded 2019 traffic levels by 2026?
WITH yearly AS (
    SELECT
        region,
        year,
        SUM(rpk_billions) AS yearly_rpk
    FROM passenger_traffic
    GROUP BY region, year
),
compare AS (
    SELECT
        a.region,
        a.yearly_rpk AS rpk_2019,
        b.yearly_rpk AS rpk_2026
    FROM yearly a
    JOIN yearly b
    ON a.region=b.region
    WHERE a.year=2019
      AND b.year=2026
)
SELECT
    region,
    rpk_2019,
    rpk_2026
FROM compare
WHERE rpk_2026>rpk_2019
ORDER BY rpk_2026 DESC;

-- 40. Rank all regions by passenger growth.
WITH yearly AS (
    SELECT
        region,
        year,
        SUM(rpk_billions) AS yearly_rpk
    FROM passenger_traffic
    GROUP BY region, year
),
growth AS (
    SELECT
        region,
        MAX(yearly_rpk)-MIN(yearly_rpk) AS growth
    FROM yearly
    GROUP BY region
)
SELECT
    region,
    ROUND(growth,2) AS total_growth,
    RANK() OVER(ORDER BY growth DESC) AS region_rank
FROM growth;

--------------------------------------------------------------------------

-- **  Route Performance Analysis **--
-- route_performance
-- Which routes generated the highest annual revenue?
-- Highest Annual Revenue by Route
SELECT
    route,
    ROUND(SUM(annual_revenue_usd_m),2) AS total_revenue_million_usd
FROM route_performance
GROUP BY route
ORDER BY total_revenue_million_usd DESC;

-- 42. Which routes had the highest passenger volume?
-- Highest Passenger Volume

SELECT
    route,
    ROUND(SUM(annual_passengers_m),2) AS total_passengers_million
FROM route_performance
GROUP BY route
ORDER BY total_passengers_million DESC;

-- 43. Which routes had the highest average fare?
-- Highest Average Fare
SELECT
    route,
    ROUND(AVG(avg_fare_usd),2) AS average_fare
FROM route_performance
GROUP BY route
ORDER BY average_fare DESC;

-- 44. Is there a relationship between route distance and fare?
-- Distance vs Average Fare
SELECT
    route,
    distance_km,
    ROUND(AVG(avg_fare_usd),2) AS average_fare
FROM route_performance
GROUP BY route, distance_km
ORDER BY distance_km;
-- Correlation Coefficient
SELECT
    ROUND(CORR(distance_km, avg_fare_usd)::numeric,3) AS correlation
FROM route_performance;
/* Interpretation:
Near 1 → Strong positive relationship
Near 0 → No relationship
Near -1 → Strong negative relationship */

-- 45. Which routes recovered fastest after COVID?
-- (Compare 2022 with 2019 passenger traffic.)
-- COVID Recovery

SELECT
    route,
	MAX(CASE WHEN year=2019 THEN annual_passengers_m END) AS passengers_2019,
	MAX(CASE WHEN year=2022 THEN annual_passengers_m END) AS passengers_2022,
	ROUND((MAX(CASE WHEN year=2022 THEN annual_passengers_m END)
        /
        MAX(CASE WHEN year=2019 THEN annual_passengers_m END))*100, 2) AS recovery_percent
FROM route_performance
GROUP BY route
ORDER BY recovery_percent DESC;
-- replace 2022 with 2023 or 2024 depending on analysis.

-- 46. Which routes generate the highest revenue per passenger?
-- Revenue Per Passenger
SELECT
    route,
	ROUND(SUM(annual_revenue_usd_m) / SUM(annual_passengers_m), 2) AS revenue_per_passenger
FROM route_performance
GROUP BY route
ORDER BY revenue_per_passenger DESC;

-- 47. Which regions contain the most profitable routes?
-- Revenue by Region
SELECT
    region,
	ROUND(SUM(annual_revenue_usd_m),2) AS total_revenue
FROM route_performance
GROUP BY region
ORDER BY total_revenue DESC;

-- 48. Which airlines dominate the top 10 routes?
-- Airlines on Top Revenue Routes
SELECT
    main_airlines,
    COUNT(*) AS number_of_routes
FROM (
    SELECT *
    FROM route_performance
    ORDER BY annual_revenue_usd_m DESC
    LIMIT 10
)
GROUP BY main_airlines
ORDER BY number_of_routes DESC;

-- 49. Which routes have the highest weekly frequency?
-- Highest Weekly Frequency
SELECT
    route,
    weekly_frequency_est
FROM route_performance
ORDER BY weekly_frequency_est DESC;

-- Top 10:
SELECT
    route,
    weekly_frequency_est
FROM route_performance
ORDER BY weekly_frequency_est DESC
LIMIT 10;

-- 50. Does route distance influence passenger demand?
-- Distance vs Passenger Demand
SELECT
    route,
    distance_km,
    annual_passengers_m
FROM route_performance
ORDER BY distance_km;
-- Correlation
SELECT
    ROUND(CORR(distance_km, annual_passengers_m)::numeric, 3) AS correlation
FROM route_performance;


---------------------------------------------------------------------------

-- ** Aviation Safety Analysis ** --
-- aviation_incidents
-- 51. How many major aviation incidents occurred each year?
SELECT
    year,
    COUNT(*) AS total_incidents
FROM aviation_incidents
GROUP BY year
ORDER BY year;

-- 52. Which airline experienced the most incidents?
SELECT
    airline,
    COUNT(*) AS total_incidents
FROM aviation_incidents
GROUP BY airline
ORDER BY total_incidents DESC;

-- 53. Which manufacturer (Boeing vs Airbus) had more incidents?
SELECT
    CASE
        WHEN is_boeing = TRUE THEN 'Boeing'
        WHEN is_airbus = TRUE THEN 'Airbus'
        ELSE 'Other'
    END AS manufacturer,
    COUNT(*) AS total_incidents
FROM aviation_incidents
GROUP BY manufacturer
ORDER BY total_incidents DESC;

-- 54. Which years recorded the highest fatalities?
SELECT
    year,
    SUM(fatalities) AS total_fatalities
FROM aviation_incidents
GROUP BY year
ORDER BY total_fatalities DESC;

-- 55. How many incidents were geopolitical?
SELECT
    COUNT(*) AS geopolitical_incidents
FROM aviation_incidents
WHERE is_geopolitical = TRUE;



SELECT
    incident_id,
    airline,
    flight_number,
    year,
    location,
    description
FROM aviation_incidents
WHERE is_geopolitical = TRUE;

-- 56. What percentage of incidents were fatal?
SELECT
    ROUND(
        COUNT(*) FILTER (WHERE is_fatal = TRUE) * 100.0 /
        COUNT(*),
        2
    ) AS fatal_percentage
FROM aviation_incidents;

-- 57. Compare fatal and non-fatal incidents by year
SELECT
    year,
    COUNT(*) FILTER (WHERE is_fatal = TRUE) AS fatal_incidents,
    COUNT(*) FILTER (WHERE is_fatal = FALSE) AS non_fatal_incidents
FROM aviation_incidents
GROUP BY year
ORDER BY year;

-- 58. Which aircraft models appear most frequently in incidents?
SELECT
    aircraft_type,
    COUNT(*) AS incident_count
FROM aviation_incidents
GROUP BY aircraft_type
ORDER BY incident_count DESC;

-- 59. Has aviation become safer over time?
-- 1: Fatalities Trend
SELECT
    year,
    COUNT(*) AS total_incidents,
    SUM(fatalities) AS total_fatalities,
    ROUND(AVG(fatalities),2) AS avg_fatalities
FROM aviation_incidents
GROUP BY year
ORDER BY year;

-- 2: Fatal Incidents Trend
SELECT
    year,
    COUNT(*) FILTER (WHERE is_fatal = TRUE) AS fatal_incidents,
    COUNT(*) FILTER (WHERE is_fatal = FALSE) AS non_fatal_incidents
FROM aviation_incidents
GROUP BY year
ORDER BY year;
-- These trends can be visualized in Power BI to evaluate whether safety has improved over time.

-- 60. Which regions experienced the most major incidents?
-- table does not contain a region column, only a location column.
-- Group by location
SELECT
    location,
    COUNT(*) AS total_incidents
FROM aviation_incidents
GROUP BY location
ORDER BY total_incidents DESC;

----------------------------------------------------
-- Rank airlines by number of incidents --
SELECT
    airline,
    COUNT(*) AS total_incidents,
    RANK() OVER (ORDER BY COUNT(*) DESC) AS incident_rank
FROM aviation_incidents
GROUP BY airline;
-----------------------------------------------------
-------------------------------------------------------------------------------------------