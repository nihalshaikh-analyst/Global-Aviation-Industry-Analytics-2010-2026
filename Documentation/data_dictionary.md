# Global Aviation Industry 2010–2026

> **30 Airlines × 17 Years of Financials | Boeing vs Airbus vs COMAC | Passenger Traffic | Global Routes | Aviation Incidents**

A comprehensive aviation industry dataset covering **2010–2026**, designed for data analysis, business intelligence, aviation research, financial analysis, and forecasting.

---

## About the Dataset

The **Global Aviation Industry 2010–2026** dataset provides a multi-dimensional view of the global aviation industry.

It combines:

- Airline financial performance
- Boeing, Airbus, and COMAC aircraft orders
- Regional passenger traffic
- Major global aviation routes
- Major aviation incidents
- COVID-19 impact and recovery
- Regional aviation trends
- 🇸🇦 Middle East aviation expansion
- 🇨🇳 COMAC C919 growth
- Boeing production and recovery challenges

The dataset covers major industry events including the **737 MAX crisis, COVID-19 aviation collapse, Saudi aviation expansion, COMAC C919 growth, and the 2024–2025 Boeing crisis**.

---

## Project Objectives

This dataset can be used to analyze:

1. Airline revenue and profitability trends
2. Passenger traffic growth and recovery
3. Boeing vs Airbus aircraft orders
4. COMAC's emergence in the commercial aircraft market
5. Regional aviation recovery after COVID-19
6. Global route performance
7. Aviation safety and major incidents
8. Middle East aviation expansion
9. Low-cost vs legacy airline performance
10. Aviation industry forecasting

---

# Dataset Structure

The project contains **5 CSV files** with approximately **2,200 rows** in total.

| File | Rows | Description |
|---|---:|---|
| `airline_financials.csv` | 497 | 30 airlines × 17 years of financial and operational data |
| `fleet_orders.csv` | 86 | Boeing, Airbus, COMAC and Embraer orders, deliveries and backlog |
| `passenger_traffic.csv` | 1,176 | Monthly regional passenger traffic from 2010–2026 |
| `route_performance.csv` | 400 | 40 major global routes and their performance |
| `aviation_incidents.csv` | 40 | Major aviation incidents from 2010–2026 |

---

# Airlines Covered

The dataset covers **30 airlines** across major global aviation markets.

### 🇺🇸 US Legacy Airlines
- Delta
- United
- American
- Alaska

### 🇺🇸 US Low-Cost Airlines
- Southwest
- JetBlue

### 🇪🇺 European Legacy Airlines
- Lufthansa Group
- IAG
- Air France-KLM
- Aeroflot

### 🇪🇺 European Low-Cost Airlines
- Ryanair
- easyJet

### 🇪🇺 European Hybrid
- Turkish Airlines

### 🇨🇳 Chinese Airlines
- Air China
- China Eastern
- China Southern

### 🇯🇵 Japanese Airlines
- JAL
- ANA

### Other Asian Airlines
- Singapore Airlines
- Cathay Pacific
- Korean Air
- IndiGo
- AirAsia

### Middle Eastern Airlines
- Emirates
- Qatar Airways
- Etihad
- Saudia
- Riyadh Air

### Latin American Airlines
- LATAM
- Azul

---

# Dataset Files

## 1. `airline_financials.csv`

Contains annual financial and operational information for 30 airlines.

### Key Columns

| Column | Description |
|---|---|
| `year` | Financial year |
| `airline_name` | Airline name |
| `iata_code` | IATA airline code |
| `country_iso3` | Country ISO3 code |
| `region` | Geographic region |
| `business_model` | Legacy / Low Cost / Regional |
| `revenue_usd_bn` | Annual revenue in USD billions |
| `operating_margin_pct` | Operating margin percentage |
| `operating_income_usd_bn` | Operating income in USD billions |
| `passengers_carried_m` | Passengers carried in millions |
| `load_factor_pct` | Passenger load factor |
| `fleet_size_est` | Estimated fleet size |

---

## 2. `fleet_orders.csv`

Tracks aircraft orders, deliveries and backlog for major aircraft manufacturers.

### Manufacturers

- Boeing
- Airbus
- COMAC
- Embraer

### Key Columns

| Column | Description |
|---|---|
| `year` | Year |
| `manufacturer` | Aircraft manufacturer |
| `aircraft_family` | Aircraft family |
| `orders_gross` | Gross aircraft orders |
| `orders_net` | Net orders after cancellations |
| `deliveries` | Aircraft delivered |
| `backlog_end_of_year` | Year-end backlog |
| `is_widebody` | Widebody classification |
| `is_narrowbody` | Narrowbody classification |
| `is_regional` | Regional aircraft classification |

---

## 3. `passenger_traffic.csv`

Contains monthly regional aviation passenger traffic data.

### Regions

- North America
- Europe
- Asia Pacific
- Middle East
- Latin America
- Africa

### Key Columns

| Column | Description |
|---|---|
| `year_month` | Monthly time index |
| `year` | Year |
| `month` | Month |
| `region` | Geographic region |
| `rpk_billions` | Revenue Passenger Kilometers |
| `ask_billions` | Available Seat Kilometers |
| `load_factor_pct` | RPK / ASK ratio |

---

## 4. `route_performance.csv`

Contains performance data for **40 major global routes**.

### Key Columns

| Column | Description |
|---|---|
| `year` | Year |
| `route` | Route name |
| `origin_iata` | Origin airport |
| `destination_iata` | Destination airport |
| `distance_km` | Great-circle distance |
| `region` | Geographic region |
| `main_airlines` | Main airlines operating the route |
| `annual_passengers_m` | Annual passengers in millions |
| `avg_fare_usd` | Average one-way fare |
| `weekly_frequency_est` | Estimated weekly flights |
| `annual_revenue_usd_m` | Estimated annual route revenue |

---

## 5. `aviation_incidents.csv`

Contains **40 major aviation incidents and accidents** from 2010–2026.

### Key Columns

| Column | Description |
|---|---|
| `incident_id` | Unique incident ID |
| `date` | Incident date |
| `year` | Year |
| `month` | Month |
| `flight_number` | Flight number |
| `airline` | Airline |
| `aircraft_type` | Aircraft type |
| `severity` | Incident severity |
| `fatalities` | Number of fatalities |
| `location` | Incident location |
| `description` | Incident details |
| `is_fatal` | Fatality flag |
| `is_geopolitical` | Geopolitical event flag |
| `is_boeing` | Boeing aircraft flag |
| `is_airbus` | Airbus aircraft flag |

---

# Key Industry Findings

## COVID-19 Impact — 2020

The dataset captures the unprecedented impact of COVID-19 on global aviation.

### Examples

- Delta revenue fell from approximately **$47B in 2019 to $17B in 2020**
- Lufthansa Group revenue fell from approximately **$40B to $15B**
- Cathay Pacific experienced approximately **58% revenue decline**
- Asia Pacific RPK fell from approximately **64B in December 2019 to 9B in April 2020**
- Industry-wide operating margins reached approximately **-30% to -35%**

---

# Boeing 737 MAX Crisis

The dataset captures the dramatic change in Boeing 737 family net orders.

| Year | Net Orders |
|---|---:|
| 2018 | +675 |
| 2019 | -87 |
| 2020 | -1,026 |
| 2024 | +569 |

In 2024, Airbus recorded approximately **1,456 A320-family net orders**, creating a significant gap with Boeing.

---

# 2024–2025 Boeing & Aviation Crisis

Major events represented in the dataset include:

- **AS1282** — Alaska Airlines 737 MAX 9 door plug incident
- **JL516** — Japan Airlines A350 collision at Haneda
- **AA5342** — American Eagle / Army Black Hawk collision
- **DL4819** — Delta CRJ-900 landing accident in Toronto
- **AI171** — Air India 787 crash in Ahmedabad

The dataset also captures Boeing production constraints and the FAA production cap.

---

# 🇨🇳 COMAC C919 Growth

The dataset tracks the development of China's domestic narrowbody aircraft program.

| Year | Orders | Deliveries |
|---|---:|---:|
| 2018 | 24 | 0 |
| 2023 | 250 | 4 |
| 2024 | 220 | 13 |

The majority of COMAC's orders remain concentrated in the Chinese domestic market.

---

# Middle East Aviation Growth

The dataset highlights the rapid expansion of Middle Eastern aviation hubs.

### Key observations

- Emirates reached approximately **$33B revenue in 2024**
- Qatar Airways revenue increased from approximately **$7B in 2010 to $22B in 2024**
- Saudi Arabia is investing heavily in aviation infrastructure
- Saudia and Riyadh Air are part of Saudi Arabia's aviation expansion strategy
- Etihad underwent major restructuring following its earlier expansion period

---

# Regional Recovery After COVID

Recovery was not uniform across regions.

| Region | Approximate Recovery |
|---|---|
| North America | 2023 |
| Europe | 2024 |
| Asia Pacific | 2024–2025 |
| Middle East | Exceeded 2019 by 2022 |

Asia Pacific experienced a slower recovery largely due to extended COVID restrictions and lockdowns.

---

# Geopolitical Aviation Events

The dataset includes major geopolitical aviation events such as:

- **MH17 — 2014**
- **PS752 — 2020**
- **FR4978 — 2021**
- **Aeroflot sanctions impact — 2022+**
- **J28243 — 2024**

These events allow researchers to investigate the relationship between geopolitics and aviation.

---

# Data Sources

The dataset combines public aviation information with modeled components.

### Real Public Data Sources

- Airline annual reports and SEC 10-K filings
- Boeing orders and deliveries reports
- Airbus orders and deliveries reports
- IATA Air Passenger Market Analysis
- ICAO traffic statistics
- OAG route statistics
- Aviation Safety Network
- NTSB reports
- EASA / FAA notices

---

# Modeled Components

Some parts of the dataset are modeled rather than directly reported for every year/month.

These include:

- Year-by-year revenue interpolation
- Operating margin estimation
- Regional passenger traffic interpolation
- Seasonal passenger traffic patterns
- Route passenger volume estimation
- Route revenue estimation

The methodology uses real-world anchor data and applies interpolation, seasonal patterns and crisis adjustments.

---

# Methodology

## Step 1 — Airline Financials

Airline financials are anchored to actual reference-year financial data.

Missing years are estimated using interpolation with adjustments for:

- COVID-19
- Boeing 737 MAX impact
- Russia sanctions
- Saudi aviation investment
- Airline business model

---

## Step 2 — Fleet Orders

Aircraft order data is anchored to selected years using Boeing and Airbus reports.

The dataset tracks:

- Gross orders
- Net orders
- Deliveries
- Backlog

COMAC and Embraer are also tracked separately.

---

## Step 3 — Passenger Traffic

Regional RPK data is modeled using IATA reference data.

Seasonality is incorporated into the monthly data.

COVID-related reductions are specifically modeled for:

- 2020
- 2021
- 2022

Regional recovery timelines are also incorporated.

---

## Step 4 — Route Performance

The dataset contains 40 major global routes.

Route performance considers:

- Distance
- Passenger volume
- Average fare
- Flight frequency
- COVID impact
- Inflation

---

## Step 5 — Aviation Incidents

40 major aviation incidents are included.

Each incident is categorized as:

- `fatal_crash`
- `fatal_collision`
- `incident`
- `ground_incident`
- `sanctions_impact`

---

# Suggested Analysis Questions

## 1. Boeing Recovery

> When could Boeing return to parity with Airbus in the narrowbody market?

---

## 2. COVID Recovery

> Which region took the longest to recover to its 2019 passenger traffic baseline?

---

## 3. Saudi Aviation Strategy

> How does the growth of Saudia and Riyadh Air compare with Emirates and Qatar Airways?

---

## 4. Route Economics

> Which global routes generate the highest estimated revenue?

---

## 5. Low-Cost vs Legacy Airlines

> Did COVID-19 change the structural operating-margin difference between low-cost and legacy airlines?

---

## 6. Aviation Safety

> Has commercial aviation become safer when incidents are adjusted for traffic volume?

---

## 7. Boeing Crisis

> What impact did major 2024–2025 incidents have on Boeing's business performance?

---

## 8. Middle East Hub Competition

> How do Emirates, Qatar Airways and Turkish Airlines compete for global connecting traffic?

---

## 9. COMAC C919

> Can COMAC become a meaningful competitor to Boeing and Airbus?

---

# Tools & Technologies

This dataset can be analyzed using:

- **Python**
- **Pandas**
- **NumPy**
- **Matplotlib**
- **Seaborn**
- **SQL**
- **PostgreSQL**
- **Microsoft Excel**
- **Power BI**
- **DAX**
- **Power Query**
- **Jupyter Notebook**

---

# Potential Dashboard KPIs

A Power BI dashboard can include:

### Financial KPIs
- Total Revenue
- Operating Income
- Average Operating Margin
- Revenue Growth

### Passenger KPIs
- Total Passengers
- Average Load Factor
- Regional RPK
- Regional ASK

### Fleet KPIs
- Total Orders
- Net Orders
- Deliveries
- Backlog

### Route KPIs
- Total Route Passengers
- Average Fare
- Route Revenue
- Weekly Frequency

### Safety KPIs
- Total Incidents
- Fatal Incidents
- Total Fatalities
- Geopolitical Incidents

---

# Limitations

The dataset has several limitations:

- Foreign airline financials may differ slightly because of currency conversion.
- Chinese airline financial data during COVID contains estimates.
- 2025–2026 fleet orders include projections.
- Route passenger volumes are modeled from regional aggregates.
- Only major aviation incidents are included.
- Cargo airlines such as FedEx, UPS and Cargolux are excluded.
- Private aviation and general aviation are excluded.
- 2026 data is partial and covers data through **April 2026**.

---


