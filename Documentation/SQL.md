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
