# Global-Aviation-Industry-Analytics-2010-2026
End-to-end Global Aviation Industry Analytics project (2010–2026) using Excel, PostgreSQL, ETL, SQL, EDA, Power BI, DAX, Power Query, and Star Schema and also Python, EDA to analyze airline financials, passenger traffic, aircraft orders, route performance, and aviation safety.

# ✈️ Global Aviation Industry Analytics | 2010–2026

<p align="center">

**End-to-End Data Analytics & Business Intelligence Project**

</p>

<p align="center">

![Python](https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white)
![Pandas](https://img.shields.io/badge/Pandas-150458?style=for-the-badge&logo=pandas&logoColor=white)
![NumPy](https://img.shields.io/badge/NumPy-013243?style=for-the-badge&logo=numpy&logoColor=white)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-316192?style=for-the-badge&logo=postgresql&logoColor=white)
![SQL](https://img.shields.io/badge/SQL-336791?style=for-the-badge&logo=postgresql&logoColor=white)
![Power BI](https://img.shields.io/badge/Power%20BI-F2C811?style=for-the-badge&logo=Power-BI&logoColor=black)
![DAX](https://img.shields.io/badge/DAX-1F4E79?style=for-the-badge&logo=microsoft&logoColor=white)
![Power Query](https://img.shields.io/badge/Power%20Query-217346?style=for-the-badge&logo=microsoft&logoColor=white)
![Excel](https://img.shields.io/badge/Excel-217346?style=for-the-badge&logo=microsoft-excel&logoColor=white)
![GitHub](https://img.shields.io/badge/GitHub-181717?style=for-the-badge&logo=github&logoColor=white)

</p>

---

# 📌 Project Overview

The **Global Aviation Industry Analytics** project is an end-to-end data analytics and business intelligence solution analyzing the global aviation industry from **2010 to 2026**.

The project combines multiple aviation datasets covering:

- Airline financial performance
- Passenger traffic
- Aircraft orders and backlog
- Aircraft manufacturers
- Global route performance
- Aviation incidents and safety

The project follows a complete analytics lifecycle:

> **Raw Data → Python EDA → Data Cleaning → PostgreSQL → SQL Analysis → Data Modeling → DAX → Power BI → Business Insights**

The final output is an interactive **5-page Power BI dashboard** designed to provide business users with insights into financial performance, passenger demand, regional trends, aircraft manufacturers, routes, and aviation safety.

---

# 🎯 Project Objectives

The main objective of this project is to transform raw aviation data into meaningful business intelligence.

### Key objectives include:

- Analyze airline financial performance
- Identify revenue and profit leaders
- Analyze global passenger demand
- Identify high-growth regions
- Compare Boeing, Airbus, and COMAC
- Analyze aircraft orders and backlog
- Identify high-performing global routes
- Analyze aviation incidents
- Build a scalable Power BI data model
- Create interactive business dashboards
- Generate actionable business insights

---

# ❓ Business Questions

## 💰 1. Airline Financial Analysis

- Which airlines generate the highest revenue?
- Which airlines generate the highest profit?
- Which airlines have the strongest profit margins?
- How has airline financial performance changed over time?
- Which airlines show consistent financial growth?

---

## 👥 2. Passenger & Demand Analysis

- How has passenger traffic changed from 2010 to 2026?
- Which regions have the highest passenger traffic?
- Which regions have experienced the strongest growth?
- What are the major passenger demand trends?

---

## 🛩️ 3. Aircraft Manufacturer Analysis

- How do Boeing, Airbus, and COMAC compare?
- Which manufacturer has the highest aircraft orders?
- Which manufacturer has the largest backlog?
- How has manufacturer performance changed over time?

---

## 🌎 4. Regional Analysis

- Which regions contribute the most to global aviation?
- Which regions have the strongest passenger demand?
- Which regions show the highest growth potential?
- Where could future aviation investment be focused?

---

## 🛣️ 5. Route Performance Analysis

- Which routes have the highest passenger volumes?
- Which global routes perform the best?
- Which regions contain the strongest routes?
- How does route performance change over time?

---

## ⚠️ 6. Aviation Safety Analysis

- How have aviation incidents changed over time?
- Which regions experienced the most incidents?
- What patterns can be identified from major incidents?
- How is incident activity distributed across years and regions?

---

# 📊 Dataset

The project uses five primary datasets.

| Dataset | Rows | Description |
|---|---:|---|
| `airline_financials.csv` | 497 | Airline financial performance |
| `fleet_orders.csv` | 86 | Aircraft orders and backlog |
| `passenger_traffic.csv` | 1,176 | Passenger traffic by region and year |
| `route_performance.csv` | 400 | Major global route performance |
| `aviation_incidents.csv` | 40 | Major aviation incidents |

### Dataset Coverage

| Metric | Coverage |
|---|---:|
| Analysis Period | 2010–2026 |
| Airlines | 30 |
| Major Routes | 40 |
| Major Incidents | 40 |
| Aircraft Manufacturers | Boeing, Airbus, COMAC |
| Primary Datasets | 5 |

---

# 🏗️ End-to-End Project Architecture

```text
                         RAW DATA
                            │
                            ▼
                  ┌───────────────────┐
                  │   Python + EDA    │
                  │ Pandas / NumPy    │
                  └─────────┬─────────┘
                            │
                            ▼
                  Data Validation
                            │
                            ▼
                  Data Cleaning
                            │
                            ▼
                  ┌───────────────────┐
                  │    PostgreSQL     │
                  │       SQL         │
                  └─────────┬─────────┘
                            │
                            ▼
                    SQL Analysis
                            │
                            ▼
                 Fact & Dimension Tables
                            │
                            ▼
                  ┌───────────────────┐
                  │    Power Query    │
                  └─────────┬─────────┘
                            │
                            ▼
                     Star Schema
                            │
                            ▼
                  ┌───────────────────┐
                  │       DAX         │
                  │      Measures     │
                  └─────────┬─────────┘
                            │
                            ▼
                  ┌───────────────────┐
                  │     Power BI      │
                  │    Dashboard      │
                  └─────────┬─────────┘
                            │
                            ▼
                  Business Insights




