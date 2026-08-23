# Step 1 – Business Understanding & Data Dictionary

## 1. Business Understanding

The **Global Aviation Industry 2010–2026** dataset is designed to analyze airline financial performance, aircraft manufacturer competition, passenger traffic, route economics, and aviation safety.

The analysis focuses on identifying major business trends across the aviation industry, including the impact of COVID-19, airline recovery patterns, Boeing vs Airbus competition, route revenue performance, airline business models, and aviation safety.

---

# 2. Data Dictionary

## Table 1: `airline_financials`

| Column Name | Data Type | Description | Example |
|---|---|---|---|
| `year` | INTEGER | Financial reporting year | 2024 |
| `airline_name` | VARCHAR(100) | Full airline name | Delta Air Lines |
| `iata_code` | VARCHAR(5) | IATA airline code | DL |
| `country_iso3` | CHAR(3) | ISO-3 country code | USA |
| `region` | VARCHAR(50) | Geographic region | North America |
| `business_model` | VARCHAR(20) | Airline type (Legacy, Low Cost, Hybrid) | Legacy |
| `revenue_usd_bn` | DECIMAL(10,2) | Annual revenue in USD billions | 58.20 |
| `operating_margin_pct` | DECIMAL(5,2) | Operating profit margin (%) | 9.50 |
| `operating_income_usd_bn` | DECIMAL(10,2) | Operating income in USD billions | 5.53 |
| `passengers_carried_m` | DECIMAL(10,2) | Passengers carried in millions | 190.30 |
| `load_factor_pct` | DECIMAL(5,2) | Passenger load factor (%) | 86.40 |
| `fleet_size_est` | INTEGER | Estimated fleet size | 982 |

---

## Table 2: `fleet_orders`

| Column Name | Data Type | Description | Example |
|---|---|---|---|
| `year` | INTEGER | Calendar year | 2024 |
| `manufacturer` | VARCHAR(30) | Aircraft manufacturer | Boeing |
| `aircraft_family` | VARCHAR(50) | Aircraft family | 737 MAX |
| `orders_gross` | INTEGER | Total aircraft orders | 623 |
| `orders_net` | INTEGER | Net orders after cancellations | 569 |
| `deliveries` | INTEGER | Aircraft delivered | 348 |
| `backlog_end_of_year` | INTEGER | Outstanding orders | 5,124 |
| `is_widebody` | BOOLEAN | Widebody aircraft indicator | FALSE |
| `is_narrowbody` | BOOLEAN | Narrowbody aircraft indicator | TRUE |
| `is_regional` | BOOLEAN | Regional aircraft indicator | FALSE |

---

## Table 3: `passenger_traffic`

| Column Name | Data Type | Description | Example |
|---|---|---|---|
| `year_month` | DATE | Year and month | 2024-07 |
| `year` | INTEGER | Calendar year | 2024 |
| `month` | INTEGER | Month number | 7 |
| `region` | VARCHAR(50) | Geographic region | Asia Pacific |
| `rpk_billions` | DECIMAL(10,2) | Revenue Passenger Kilometers (billions) | 61.40 |
| `ask_billions` | DECIMAL(10,2) | Available Seat Kilometers (billions) | 72.10 |
| `load_factor_pct` | DECIMAL(5,2) | Passenger load factor (%) | 85.20 |

---

## Table 4: `route_performance`

| Column Name | Data Type | Description | Example |
|---|---|---|---|
| `year` | INTEGER | Calendar year | 2024 |
| `route` | VARCHAR(100) | Flight route | LHR-JFK |
| `origin_iata` | CHAR(3) | Origin airport code | LHR |
| `destination_iata` | CHAR(3) | Destination airport code | JFK |
| `distance_km` | INTEGER | Route distance in kilometers | 5,540 |
| `region` | VARCHAR(50) | Route region | Europe–North America |
| `main_airlines` | VARCHAR(255) | Major airlines operating the route | British Airways, American Airlines |
| `annual_passengers_m` | DECIMAL(10,2) | Annual passengers in millions | 4.80 |
| `avg_fare_usd` | DECIMAL(10,2) | Average one-way fare in USD | 780.00 |
| `weekly_frequency_est` | INTEGER | Estimated weekly flights | 140 |
| `annual_revenue_usd_m` | DECIMAL(12,2) | Annual route revenue in USD millions | 3,744.00 |

---

## Table 5: `aviation_incidents`

| Column Name | Data Type | Description | Example |
|---|---|---|---|
| `incident_id` | VARCHAR(20) | Unique incident identifier | AI171 |
| `date` | DATE | Incident date | 2025-06-12 |
| `year` | INTEGER | Calendar year | 2025 |
| `month` | INTEGER | Month number | 6 |
| `flight_number` | VARCHAR(20) | Flight number | AI171 |
| `airline` | VARCHAR(100) | Airline involved | Air India |
| `aircraft_type` | VARCHAR(100) | Aircraft model | Boeing 787-8 |
| `severity` | VARCHAR(30) | Incident severity | fatal_crash |
| `fatalities` | INTEGER | Number of fatalities | 241 |
| `location` | VARCHAR(150) | Incident location | Ahmedabad, India |
| `description` | TEXT | Incident summary | Aircraft crashed shortly after takeoff |
| `is_fatal` | BOOLEAN | Fatal incident flag | TRUE |
| `is_geopolitical` | BOOLEAN | Geopolitical event flag | FALSE |
| `is_boeing` | BOOLEAN | Boeing aircraft flag | TRUE |
| `is_airbus` | BOOLEAN | Airbus aircraft flag | FALSE |

---

# 3. Suggested Primary Keys

| Table | Primary Key |
|---|---|
| `airline_financials` | `(airline_name, year)` |
| `fleet_orders` | `(manufacturer, aircraft_family, year)` |
| `passenger_traffic` | `(year_month, region)` |
| `route_performance` | `(route, year)` |
| `aviation_incidents` | `incident_id` |

---

# 4. Potential Relationships

| From Table | Column | To Table | Column | Relationship Purpose |
|---|---|---|---|---|
| `airline_financials` | `airline_name` | `aviation_incidents` | `airline` | Airline-based analysis |
| `airline_financials` | `year` | `fleet_orders` | `year` | Year-based analysis |
| `airline_financials` | `year` | `passenger_traffic` | `year` | Time-based analysis |
| `passenger_traffic` | `region` | `route_performance` | `region` | Regional analysis |
| `route_performance` | `year` | `fleet_orders` | `year` | Year-based comparison |

> **Note:** These are potential analytical relationships. For Power BI, a dedicated Date/Calendar table and dimension tables such as `DimAirline`, `DimRegion`, and `DimManufacturer` can provide a cleaner star-schema model.

---

# 5. Relationship Diagram – Business View

```text
                         ┌──────────────────────────────┐
                         │      airline_financials      │
                         ├──────────────────────────────┤
                         │ year                         │
                         │ airline_name                 │
                         │ region                       │
                         │ business_model               │
                         │ revenue                      │
                         │ passengers                   │
                         │ load_factor                  │
                         └──────────────┬───────────────┘
                                        │
                         airline_name   │   year
                                        │
                                        ▼
                         ┌──────────────────────────────┐
                         │      aviation_incidents      │
                         ├──────────────────────────────┤
                         │ incident_id                  │
                         │ airline                      │
                         │ year                         │
                         │ aircraft_type                │
                         │ fatalities                   │
                         └──────────────────────────────┘


        ┌──────────────────────────────┐
        │       passenger_traffic      │
        ├──────────────────────────────┤
        │ year_month                   │
        │ year                         │
        │ region                       │
        │ RPK                          │
        │ ASK                          │
        │ Load Factor                  │
        └──────────────┬───────────────┘
                       │
                 region│ year
                       │
                       ▼
        ┌──────────────────────────────┐
        │       route_performance      │
        ├──────────────────────────────┤
        │ route                        │
        │ region                       │
        │ year                         │
        │ passengers                   │
        │ revenue                      │
        └──────────────────────────────┘


        ┌──────────────────────────────┐
        │         fleet_orders         │
        ├──────────────────────────────┤
        │ year                         │
        │ manufacturer                 │
        │ aircraft_family              │
        │ orders                       │
        │ deliveries                   │
        │ backlog                      │
        └──────────────────────────────┘
