# Step 3 – PostgreSQL Database Design & Data Import Documentation

## Project Objective

The objective of this phase is to design a structured PostgreSQL database for the **Global Aviation Industry** dataset and import all CSV files into the database.

A properly designed database ensures:

- Data integrity
- Efficient SQL querying
- Structured data storage
- Reliable data management
- A consistent data source for Power BI dashboards

---

# Database Information

| Item | Details |
|---|---|
| **Database Name** | `aviation_project` |
| **Database Management System** | PostgreSQL |
| **Database Administration Tool** | pgAdmin 4 |

---

# Dataset Overview

The project consists of five datasets covering different aspects of the global aviation industry between **2010 and 2026**.

| Table | Description | Expected Rows |
|---|---|---:|
| `airline_financials` | Airline financial performance | 497 |
| `fleet_orders` | Aircraft manufacturer orders and deliveries | 86 |
| `passenger_traffic` | Monthly regional passenger traffic | 1,176 |
| `route_performance` | Global route performance | 400 |
| `aviation_incidents` | Major aviation incidents | 40 |

---

# Database Schema

The PostgreSQL database contains the following tables:

```text
aviation_project
│
├── airline_financials
├── fleet_orders
├── passenger_traffic
├── route_performance
└── aviation_incidents

```

# Step 4 – Data Cleaning & Validation Documentation

## 4.1 Row Count Validation

### Objective

Verify that all CSV files were imported successfully into PostgreSQL.

### Validation Performed

```sql
SELECT COUNT(*) FROM airline_financials;

SELECT COUNT(*) FROM fleet_orders;

SELECT COUNT(*) FROM passenger_traffic;

SELECT COUNT(*) FROM route_performance;

SELECT COUNT(*) FROM aviation_incidents;
```

** Step 5 Documentation – Exploratory Data Analysis (EDA)**

**Business Goals**

- Analyze      airline financial performance.
- Identify      revenue trends over time.
- Measure      passenger growth and demand.
- Compare      airline business models.
- Evaluate      Boeing vs Airbus performance.
- Analyze      route profitability.
- Assess      aviation safety trends.

---

**SQL Concepts Used**

- SELECT
- WHERE
- ORDER      BY
- GROUP      BY
- HAVING
- Aggregate      Functions
- DISTINCT
- LIMIT

---

**Business Questions Solved**

**Financial Analysis**

- Which      airline generated the highest revenue?
- What      is the yearly revenue trend?
- Which      airline carried the most passengers?
- Which      airline has the highest operating margin?
- Compare      legacy and low-cost airlines.

---

**Fleet Analysis**

- Boeing      vs Airbus yearly orders.
- Deliveries      trend.
- Backlog      trend.
- Widebody      vs Narrowbody demand.

---

**Passenger Analysis**

- Regional      passenger growth.
- COVID      recovery.
- Load      factor comparison.
- Monthly      traffic trend.

---

**Route Analysis**

- Highest      revenue routes.
- Highest      passenger routes.
- Average      fare comparison.

---

**Safety Analysis**

- Fatal      incidents by year.
- Boeing      vs Airbus incidents.
- Geopolitical      events.

---

**Key Insights**

- Airline      revenue declined sharply in 2020 because of COVID-19.
- Passenger      demand recovered at different rates across regions.
- Airbus      gained market share while Boeing experienced challenges after the 737 MAX      crisis.
- Middle      Eastern airlines showed strong growth after the pandemic.
- Several      international routes generated significantly higher revenue than others.

---

**Outcome**

Successfully completed exploratory analysis and identified
key KPIs to be used in dashboard development.

---

**📄 Step 6 Documentation – Advanced SQL Analysis**

**Objective**

Perform advanced SQL analysis to generate deeper business
insights using analytical SQL techniques.

---

**SQL Features Used**

- Common      Table Expressions (CTEs)
- Window      Functions
- RANK()
- DENSE_RANK()
- ROW_NUMBER()
- LAG()
- LEAD()
- CASE      WHEN
- Subqueries
- Views

---

**Business Scenarios Solved**

**Revenue Growth Analysis**

Calculated Year-over-Year revenue growth for each airline.

---

**Airline Ranking**

Ranked airlines based on yearly revenue.

---

**Regional Leaders**

Identified the highest revenue airline in every region.

---

**Running Revenue**

Calculated cumulative revenue over the years.

---

**Industry Benchmarking**

Compared airline revenue against yearly industry averages.

---

**Profitability Analysis**

Identified airlines performing above average operating
margin.

---

**Revenue Classification**

Categorized airlines into:

- High      Revenue
- Medium      Revenue
- Low      Revenue

---

**Route Performance**

Ranked routes by annual revenue.

---

**Manufacturer Analysis**

Compared Boeing and Airbus yearly performance.

---

**View Creation**

Created reusable SQL Views for reporting.

---

**SQL Skills Demonstrated**

- Analytical      Queries
- Ranking      Functions
- Running      Totals
- Time-Series      Analysis
- Business      Logic
- Performance      Optimization

---

**Business Insights**

- COVID      caused the largest decline in airline revenue during the study period.
- Boeing      recovered gradually after the 737 MAX crisis but remained behind Airbus in      several years.
- Low-cost      carriers generally maintained stronger operating margins.
- Some      airlines consistently outperformed the industry average.

---

**Outcome**

Generated advanced analytical reports that can directly support executive decision-making and Power BI dashboard development.
