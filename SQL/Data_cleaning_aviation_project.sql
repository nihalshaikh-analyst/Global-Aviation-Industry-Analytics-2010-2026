--------------------------------------------------------------
-- Data Cleaning 
-------------------------------------------------------------

-- Data Cleanig By Each Table
-- Check for Duplicate Records

SELECT 
	airline_name,
	year,
	COUNT(*)
FROM airline_financials
GROUP BY airline_name, year
HAVING COUNT(*) > 1;
-- No duplicates records in airline_financials table.

SELECT 
	year,
	manufacturer,
	aircraft_family,
	COUNT(*)
FROM fleet_orders
GROUP BY year, manufacturer, aircraft_family
HAVING COUNT(*) > 1;
-- No duplicates records in fleet_orders table.

SELECT 
	year_month,
	region,
	COUNT(*)
FROM passenger_traffic
GROUP BY year_month, region
HAVING COUNT(*) > 1;
-- No diuplicates records in passenger_traffic table.

SELECT 
	year,
	route,
	COUNT(*)
FROM route_performance
GROUP BY year, route
HAVING COUNT(*) > 1;
-- No duplicates records in route_performance table.

SELECT 
	incident_id,
	COUNT(*)
FROM aviation_incidents
GROUP BY incident_id
HAVING COUNT(*) > 1;
-- No duplicates records in aviation_incidents.


-- Check Missing Values

SELECT *
FROM airline_financials
WHERE year IS NULL
	OR airline_name IS NULL
	OR iata_code IS NULL
	OR country_iso3 IS NULL
	OR region IS NULL
	OR business_model IS NULL
	OR revenue_usd_bn IS NULL
	OR operating_margin_pct IS NULL
	OR operating_income_usd_bn IS NULL
	OR passengers_carried_m IS NULL
	OR load_factor_pct IS NULL
	OR fleet_size_est IS NULL;
-- No null values in airline_passenger table.

SELECT *
FROM aviation_incidents
WHERE incident_id IS NULL
	OR date IS NULL
	OR year IS NULL
	OR month IS NULL 
	OR flight_number IS NULL
	OR airline IS NULL
	OR aircraft_type IS NULL
	OR severity IS NULL
	OR fatalities IS NULL 
	OR location IS NULL
	OR description IS NULL
	OR is_fatal IS NULL
	OR is_geopolitical IS NULL
	OR is_boeing IS NULL
	OR is_airbus IS NULL;
-- No null values in aviation_incident table.

SELECT *
FROM fleet_orders
WHERE year IS NULL
	OR manufacturer IS NULL
	OR aircraft_family IS NULL
	OR orders_gross IS NULL
	OR orders_net IS NULL
	OR deliveries IS NULL
	OR backlog_end_of_year IS NULL
	OR is_widebody IS NULL
	OR is_narrowbody IS NULL
	OR is_regional IS NULL;
-- No null values in fleet_orders table.

SELECT *
FROM passenger_traffic
WHERE year_month IS NULL
	OR year IS NULL
	OR month IS NULL
	OR region IS NULL
	OR rpk_billions IS NULL
	OR ask_billions IS NULL
	OR load_factor_pct IS NULL;
-- No null valuse in passenger_traffic table.

SELECT *
FROM route_performance
WHERE year IS NULL
	OR route IS NULL
	OR origin_iata IS NULL
	OR destination_iata IS NULL
	OR distance_km IS NULL
	OR region IS NULL
	OR main_airlines IS NULL
	OR annual_passengers_m IS NULL
	OR avg_fare_usd IS NULL
	OR weekly_frequency_est IS NULL
	OR annual_revenue_usd_m IS NULL;
--No null values is route_performance table.

---------------------------------------------------------

-- Remove Leading & Trailing Spaces
-- 1. airline_financials
-- Check
SELECT DISTINCT airline_name
FROM airline_financials
WHERE airline_name <> TRIM(airline_name);

SELECT DISTINCT region
FROM airline_financials
WHERE region <> TRIM(region);

SELECT DISTINCT business_model
FROM airline_financials
WHERE business_model <> TRIM(business_model);

-- Clean
UPDATE airline_financials
SET airline_name = TRIM(airline_name);

UPDATE airline_financials
SET region = TRIM(region);

UPDATE airline_financials
SET business_model = TRIM(business_model);

-- 2. fleet_orders
-- Check
SELECT DISTINCT manufacturer
FROM fleet_orders
WHERE manufacturer <> TRIM(manufacturer);

SELECT DISTINCT aircraft_family
FROM fleet_orders
WHERE aircraft_family <> TRIM(aircraft_family);

-- Clean
UPDATE fleet_orders
SET manufacturer = TRIM(manufacturer);

UPDATE fleet_orders
SET aircraft_family = TRIM(aircraft_family);

-- 3. passenger_traffic
-- Check
SELECT DISTINCT region
FROM passenger_traffic
WHERE region <> TRIM(region);

-- Clean
UPDATE passenger_traffic
SET region = TRIM(region);

-- 4. route_performance
-- Check
SELECT DISTINCT route
FROM route_performance
WHERE route <> TRIM(route);

SELECT DISTINCT origin_iata
FROM route_performance
WHERE origin_iata <> TRIM(origin_iata);

SELECT DISTINCT destination_iata
FROM route_performance
WHERE destination_iata <> TRIM(destination_iata);

SELECT DISTINCT region
FROM route_performance
WHERE region <> TRIM(region);

SELECT DISTINCT main_airlines
FROM route_performance
WHERE main_airlines <> TRIM(main_airlines);

-- Clean
UPDATE route_performance
SET route = TRIM(route);

UPDATE route_performance
SET origin_iata = TRIM(origin_iata);

UPDATE route_performance
SET destination_iata = TRIM(destination_iata);

UPDATE route_performance
SET region = TRIM(region);

UPDATE route_performance
SET main_airlines = TRIM(main_airlines);

-- 5. aviation_incidents
-- Check
SELECT DISTINCT airline
FROM aviation_incidents
WHERE airline <> TRIM(airline);

SELECT DISTINCT aircraft_type
FROM aviation_incidents
WHERE aircraft_type <> TRIM(aircraft_type);

SELECT DISTINCT severity
FROM aviation_incidents
WHERE severity <> TRIM(severity);

SELECT DISTINCT location
FROM aviation_incidents
WHERE location <> TRIM(location);

-- Clean
UPDATE aviation_incidents
SET airline = TRIM(airline);

UPDATE aviation_incidents
SET aircraft_type = TRIM(aircraft_type);

UPDATE aviation_incidents
SET severity = TRIM(severity);

UPDATE aviation_incidents
SET location = TRIM(location);
-------------------------------------------------------------

-- Validate Numeric Values
-- Check for impossible values.
-- validate every numeric column

-- airline_financials
-- Check for negative revenue
SELECT *
FROM airline_financials
WHERE revenue_usd_bn < 0;

-- Check operating margin (optional business rule)
SELECT *
FROM airline_financials
WHERE operating_margin_pct < -100
   OR operating_margin_pct > 100;

-- Check negative operating income
SELECT *
FROM airline_financials
WHERE operating_income_usd_bn < 0;

-- Check negative passengers
SELECT *
FROM airline_financials
WHERE passengers_carried_m < 0;

-- Check load factor
SELECT *
FROM airline_financials
WHERE load_factor_pct < 0
   OR load_factor_pct > 100;

-- Check fleet size
SELECT *
FROM airline_financials
WHERE fleet_size_est < 0;

-- 2. fleet_orders
-- Check negative values
SELECT *
FROM fleet_orders
WHERE orders_gross < 0
   OR orders_net < 0
   OR deliveries < 0
   OR backlog_end_of_year < 0;

-- Check business rule
-- Net orders should generally not exceed gross orders.
SELECT *
FROM fleet_orders
WHERE orders_net > orders_gross;

-- 3. passenger_traffic
-- Check RPK
SELECT *
FROM passenger_traffic
WHERE rpk_billions < 0;

-- Check ASK
SELECT *
FROM passenger_traffic
WHERE ask_billions < 0;

-- Check load factor
SELECT *
FROM passenger_traffic
WHERE load_factor_pct < 0
   OR load_factor_pct > 100;

-- 4. route_performance
-- Check distance
SELECT *
FROM route_performance
WHERE distance_km <= 0;

-- Check passengers
SELECT *
FROM route_performance
WHERE annual_passengers_m < 0;

-- Check fare
SELECT *
FROM route_performance
WHERE avg_fare_usd < 0;

-- Check weekly frequency
SELECT *
FROM route_performance
WHERE weekly_frequency_est < 0;

-- Check revenue
SELECT *
FROM route_performance
WHERE annual_revenue_usd_m < 0;

-- 5. aviation_incidents
-- Check fatalities
SELECT *
FROM aviation_incidents
WHERE fatalities < 0;

-- Check year
SELECT *
FROM aviation_incidents
WHERE year < 2010
   OR year > 2026;

-- Check month
SELECT *
FROM aviation_incidents
WHERE month NOT BETWEEN 1 AND 12;


-- Check Distinct Values
-- 1. airline_financials
-- Region
SELECT DISTINCT region
FROM airline_financials
ORDER BY region;
/* ANS =
----------------
|	region	   |
----------------
|Asia		   |
|Europe		   |
|Latin America |
|Middel East   |
|North America |
---------------- */

-- Business Model
SELECT DISTINCT business_model
FROM airline_financials
ORDER BY business_model;
/* ANS
----------------
|business_model|
----------------
|legacy		   |
|low|cost	   |
|regional      |
---------------- */

-- Airline Name
SELECT DISTINCT airline_name
FROM airline_financials
ORDER BY airline_name;
/* ANS = In air_line column has 30 distinct name.*/

-- Country ISO3
SELECT DISTINCT country_iso3
FROM airline_financials
ORDER BY country_iso3;
/* ANS = In country_iso3 column has 19 Unique country.*/

-- 2. fleet_orders
-- Manufacturer
SELECT DISTINCT manufacturer
FROM fleet_orders
ORDER BY manufacturer;
/* ANS = 
--------------
|manufacturer|
--------------
|	Airbus	 |
|	Boeing	 |
|	COMAC	 |
|	Embraer  |
-------------- */

-- Aircraft Family
SELECT DISTINCT aircraft_family
FROM fleet_orders
ORDER BY aircraft_family;

-- 3. passenger_traffic
-- Region
SELECT DISTINCT region
FROM passenger_traffic
ORDER BY region;

-- 4. route_performance
-- Region
SELECT DISTINCT region
FROM route_performance
ORDER BY region;

-- Route
SELECT DISTINCT route
FROM route_performance
ORDER BY route;

-- Origin Airport
SELECT DISTINCT origin_iata
FROM route_performance
ORDER BY origin_iata;

-- Destination Airport
SELECT DISTINCT destination_iata
FROM route_performance
ORDER BY destination_iata;

-- Main Airlines
SELECT DISTINCT main_airlines
FROM route_performance
ORDER BY main_airlines;

-- 5. aviation_incidents
-- Airline
SELECT DISTINCT airline
FROM aviation_incidents
ORDER BY airline;

-- Aircraft Type
SELECT DISTINCT aircraft_type
FROM aviation_incidents
ORDER BY aircraft_type;

-- Severity
SELECT DISTINCT severity
FROM aviation_incidents
ORDER BY severity;

-- Location
SELECT DISTINCT location
FROM aviation_incidents
ORDER BY location;

------------------------------------------------------------------

-- Validate Date & Time Values
-- 1. airline_financials
-- Check Year Range
SELECT
    MIN(year) AS min_year,
    MAX(year) AS max_year
FROM airline_financials;

-- Find Invalid Years
SELECT *
FROM airline_financials
WHERE year < 2010
   OR year > 2026;

-- 2. fleet_orders
-- Check Year Range
SELECT
    MIN(year) AS min_year,
    MAX(year) AS max_year
FROM fleet_orders;

-- Find Invalid Years
SELECT *
FROM fleet_orders
WHERE year < 2010
   OR year > 2026;

-- 3. passenger_traffic
-- Check Year and Month Range
SELECT
    MIN(year) AS min_year,
    MAX(year) AS max_year,
    MIN(month) AS min_month,
    MAX(month) AS max_month
FROM passenger_traffic;

-- Find Invalid Years
SELECT *
FROM passenger_traffic
WHERE year < 2010
   OR year > 2026;

-- Find Invalid Months
SELECT *
FROM passenger_traffic
WHERE month NOT BETWEEN 1 AND 12;

-- Check Distinct Year-Month Values
SELECT DISTINCT year_month
FROM passenger_traffic
ORDER BY year_month;

-- 4. route_performance
-- Check Year Range
SELECT
    MIN(year) AS min_year,
    MAX(year) AS max_year
FROM route_performance;

-- Find Invalid Years
SELECT *
FROM route_performance
WHERE year < 2010
   OR year > 2026;

-- 5. aviation_incidents
-- Check Date Range
SELECT
    MIN(date) AS earliest_incident,
    MAX(date) AS latest_incident
FROM aviation_incidents;

-- Check Year and Month Range
SELECT
    MIN(year) AS min_year,
    MAX(year) AS max_year,
    MIN(month) AS min_month,
    MAX(month) AS max_month
FROM aviation_incidents;

-- Find Invalid Years
SELECT *
FROM aviation_incidents
WHERE year < 2010
   OR year > 2026;

-- Find Invalid Months
SELECT *
FROM aviation_incidents
WHERE month NOT BETWEEN 1 AND 12;

-- Find Invalid Dates
SELECT *
FROM aviation_incidents
WHERE date IS NULL;

-----------------------------------------------
-----------------------------------------------
-- Create Cleaning Views
CREATE VIEW vw_airline_financials AS
SELECT
    TRIM(airline_name) AS airline_name,
    INITCAP(region) AS region,
    INITCAP(business_model) AS business_model,
    UPPER(country_iso3) AS country_iso3,
    UPPER(iata_code) AS iata_code,
    year,
    revenue_usd_bn,
    operating_margin_pct,
    operating_income_usd_bn,
    passengers_carried_m,
    load_factor_pct,
    fleet_size_est
FROM airline_financials;
-----------------------------------------------
-----------------------------------------------