

##  Step 8 — Power BI Analysis & Power Query

### Objective

Connect the PostgreSQL database to Power BI and transform the aviation datasets using Power Query to create a clean, consistent, and analysis-ready data model.

### Power Query Features Used

- PostgreSQL Connector
- Data Type Conversion
- Trim & Clean
- Capitalize Each Word
- Remove Duplicates
- Column Quality Check
- Remove Unnecessary Columns
- Create Reference Queries
- Dimension Table Creation

### Transformations Performed

- Verified all data types.
- Standardized text values.
- Removed duplicate records.
- Validated null values.
- Optimized columns for reporting.
- Created reusable dimension tables.

### Outcome

The transformed dataset is ready for data modeling and dashboard development in Power BI.

---

# Step 9 — Power BI Data Modeling

## Project: Global Aviation Industry Analysis 2010–2026

### Step 9: Data Modeling & Star Schema

### 1. Objective

The objective of Step 9 was to create a structured data model in Power BI that connects the five aviation datasets through a common **Date dimension**.

The model was designed using a simplified **Star Schema**, with one central **Dim Date** table connected to the five analytical tables.

---

### 2. Tables Used

#### Analytical Tables

- Airline Financials
- Fleet Orders
- Passenger Traffic
- Route Performance
- Aviation Incidents

#### Dimension Table

- Dim Date

No separate dimension tables such as Dim Airline, Dim Region, or Dim Manufacturer were used in this version of the project.

---

### 3. Dim Date Table

A dedicated calendar table was created in Power BI to provide a common time dimension for the entire project.

The calendar covers the project period:

**2010–2026**

The Date table contains:

- Date
- Year
- Month Number
- Month Name
- Quarter

The table was also marked as the official **Date Table** in Power BI.

---

### 4. Date Columns in Analytical Tables

Since some analytical tables contained only year-level information, appropriate date columns were created to establish relationships with the Date table.

Date fields were prepared for:

- Airline Financials
- Fleet Orders
- Passenger Traffic
- Route Performance
- Aviation Incidents

This ensured that all tables could participate in time-based analysis.

---

### 5. Relationships

The Dim Date table was connected to all five analytical tables.

| From Table | From Column | To Table | To Column | Cardinality |
|---|---|---|---|---|
| Dim Date | Date | Airline Financials | Date | 1:* |
| Dim Date | Date | Fleet Orders | Date | 1:* |
| Dim Date | Date | Passenger Traffic | year_month | 1:* |
| Dim Date | Date | Route Performance | Date | 1:* |
| Dim Date | Date | Aviation Incidents | Date | 1:* |

All relationships were configured as:

**One-to-Many (1:*)**

with **single-direction filtering** from the Date table to the analytical tables.

---

### 6. Star Schema

The final model follows a simplified Star Schema.

```text
                         ┌──────────────┐
                         │   Dim Date   │
                         └──────┬───────┘
                                │
             ┌──────────────────┼──────────────────┐
             │                  │                  │
             ▼                  ▼                  ▼
      ┌──────────────┐   ┌─────────────┐   ┌──────────────────┐
      │    Airline   │   │ Fleet       │   │ Passenger        │
      │  Financials  │   │ Orders      │   │ Traffic          │
      └──────────────┘   └─────────────┘   └──────────────────┘
             │                  │                  │
             └──────────────────┼──────────────────┘
                                │
                         ┌──────┴───────┐
                         │              │
                         ▼              ▼
                  ┌──────────────┐ ┌──────────────────┐
                  │    Route     │ │    Aviation      │
                  │ Performance  │ │    Incidents     │
                  └──────────────┘ └──────────────────┘
