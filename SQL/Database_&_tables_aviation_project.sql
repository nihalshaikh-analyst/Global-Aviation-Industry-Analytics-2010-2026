-- ============================================
-- DATABASE
-- ============================================

CREATE DATABASE aviation_project;

----------------------------------------------------------------
-- Create Tables Import CSV Files and Load Data one by one Table
----------------------------------------------------------------

-- TABLE 1 : airline_financials

CREATE TABLE airline_financials (
	year INTEGER NOT NULL,
	airline_name VARCHAR(100) NOT NULL,
	iata_code VARCHAR(5),
	country_iso3 CHAR(3),
	region VARCHAR(50),
	business_model VARCHAR(30),
	revenue_usd_bn NUMERIC(12,2),
	operating_margin_pct NUMERIC(6,2),
	operating_income_usd_bn NUMERIC(12,2),
	passengers_carried_m NUMERIC(12,2),
	load_factor_pct NUMERIC(5,2),
	fleet_size_est INTEGER,
	CONSTRAINT pk_airline_financials
    PRIMARY KEY (airline_name, year)
);

SELECT * FROM airline_financials;

SELECT COUNT(*)
FROM airline_financials;
-- count rows = 497


-- TABLE 2 : fleet_orders

CREATE TABLE fleet_orders (
	year INTEGER NOT NULL,
	manufacturer VARCHAR(30) NOT NULL,
	aircraft_family VARCHAR(60) NOT NULL,
	orders_gross INTEGER,
	orders_net INTEGER,
	deliveries INTEGER,
	backlog_end_of_year INTEGER,
	is_widebody BOOLEAN,
	is_narrowbody BOOLEAN,
	is_regional BOOLEAN,
	CONSTRAINT pk_fleet_orders
    PRIMARY KEY (manufacturer, aircraft_family, year)
);

SELECT * FROM fleet_orders;

SELECT COUNT(*)
FROM fleet_orders;
-- count rows = 86


-- TABLE 3 : passenger_traffic

 CREATE TABLE passenger_traffic (
	year_month VARCHAR(7) NOT NULL,
	year INTEGER,
	month INTEGER,
	region VARCHAR(50) NOT NULL,
	rpk_billions NUMERIC(12,2),
	ask_billions NUMERIC(12,2),
	load_factor_pct NUMERIC(5,2),
	CONSTRAINT pk_passenger_traffic
    PRIMARY KEY (year_month, region)
);

SELECT * FROM passenger_traffic;

SELECT COUNT(*)
FROM passenger_traffic;
-- count rows = 1176


-- Table : 4 route_performance

CREATE TABLE route_performance (
	year INTEGER NOT NULL,
	route VARCHAR(100) NOT NULL,
	origin_iata CHAR(3),
	destination_iata CHAR(3),
	distance_km INTEGER,
	region VARCHAR(60),
	main_airlines TEXT,
	annual_passengers_m NUMERIC(12,2),
	avg_fare_usd NUMERIC(10,2),
	weekly_frequency_est INTEGER,
	annual_revenue_usd_m NUMERIC(15,2),
	CONSTRAINT pk_route_performance
    PRIMARY KEY (route, year)
);

SELECT * FROM route_performance;

SELECT COUNT(*)
FROM route_performance;
-- count rows = 400


-- Table : 5 aviation_incidents

CREATE TABLE aviation_incidents (
	incident_id VARCHAR(20) PRIMARY KEY,
	date DATE,
	year INTEGER,
	month INTEGER,
	flight_number VARCHAR(20),
	airline VARCHAR(100),
	aircraft_type VARCHAR(100),
	severity VARCHAR(30),
	fatalities INTEGER,
	location VARCHAR(150),
	description TEXT,
	is_fatal BOOLEAN,
	is_geopolitical BOOLEAN,
	is_boeing BOOLEAN,
	is_airbus BOOLEAN
);

SELECT * FROM aviation_incidents;

SELECT COUNT(*)
FROM aviation_incidents;
-- count rows = 40
-- Check Row Counts Verify all rows were imported correctly.
-- Done.
------------------------------------------------------


