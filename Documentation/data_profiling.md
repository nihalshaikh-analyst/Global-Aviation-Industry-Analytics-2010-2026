# Step 2 – Data Profiling & Data Quality Assessment

## 2.1 Data Profiling Process

Each dataset was reviewed using **Microsoft Excel** to understand its structure and evaluate data quality before importing it into **PostgreSQL**.

The following data quality checks were performed:

- Dataset dimensions
- Column names
- Data types
- Missing values
- Duplicate records
- Text consistency
- Numeric validation
- Date validation
- Business rule validation
- Outlier identification

---

# 2.2 Data Quality Checklist

| Validation Item | Purpose | Status |
|---|---|---|
| Row Count Verification | Verify expected number of records | ✅ Completed |
| Column Count Verification | Ensure dataset structure is correct | ✅ Completed |
| Column Name Review | Identify blank or inconsistent names | ✅ Completed |
| Data Type Validation | Verify numeric, text, and date columns | ✅ Completed |
| Missing Value Assessment | Detect incomplete information | ✅ Completed |
| Duplicate Record Check | Identify duplicate observations | ✅ Completed |
| Text Quality Check | Detect spaces and inconsistent text | ✅ Completed |
| Numeric Validation | Verify valid numeric ranges | ✅ Completed |
| Date Validation | Ensure valid date formats | ✅ Completed |
| Business Rule Validation | Identify logically invalid values | ✅ Completed |

---

# 2.3 Dataset Profiling Summary

## 1. `airline_financials.csv`

### Columns Reviewed

- `year`
- `airline_name`
- `iata_code`
- `country_iso3`
- `region`
- `business_model`
- `revenue_usd_bn`
- `operating_margin_pct`
- `operating_income_usd_bn`
- `passengers_carried_m`
- `load_factor_pct`
- `fleet_size_est`

### Validation Performed

- Verified year values
- Checked airline names for consistency
- Reviewed revenue values
- Validated operating margins
- Verified passenger counts
- Checked fleet sizes
- Confirmed load factors remained within expected business limits

Potential issues identified during profiling were documented for further review before SQL analysis.

---

## 2. `fleet_orders.csv`

### Columns Reviewed

- `year`
- `manufacturer`
- `aircraft_family`
- `orders_gross`
- `orders_net`
- `deliveries`
- `backlog_end_of_year`
- `is_widebody`
- `is_narrowbody`
- `is_regional`

### Validation Performed

- Manufacturer consistency
- Aircraft family naming consistency
- Boolean value verification
- Negative order detection
- Delivery validation
- Backlog validation

---

## 3. `passenger_traffic.csv`

### Columns Reviewed

- `year_month`
- `year`
- `month`
- `region`
- `rpk_billions`
- `ask_billions`
- `load_factor_pct`

### Validation Performed

- Monthly continuity
- Region consistency
- RPK values
- ASK values
- Load factor validation
- Date formatting

---

## 4. `route_performance.csv`

### Columns Reviewed

- `year`
- `route`
- `origin_iata`
- `destination_iata`
- `distance_km`
- `region`
- `main_airlines`
- `annual_passengers_m`
- `avg_fare_usd`
- `weekly_frequency_est`
- `annual_revenue_usd_m`

### Validation Performed

- Airport code consistency
- Route naming consistency
- Distance validation
- Passenger volume review
- Fare validation
- Revenue validation

---

## 5. `aviation_incidents.csv`

### Columns Reviewed

- `incident_id`
- `date`
- `year`
- `month`
- `flight_number`
- `airline`
- `aircraft_type`
- `severity`
- `fatalities`
- `location`
- `description`
- `is_fatal`
- `is_geopolitical`
- `is_boeing`
- `is_airbus`

### Validation Performed

- Incident ID uniqueness
- Date consistency
- Airline naming consistency
- Fatality count validation
- Boolean value verification
- Severity classification

---

# 2.4 Data Quality Findings

The following data quality dimensions were assessed throughout the profiling process.

---

## Missing Values

Each column was reviewed to identify **null or blank values** that could impact future analysis.

### Recommended Action

- Investigate missing business-critical fields.
- Decide whether to retain, replace, or remove incomplete records.
- Document any imputation performed.

---

## Duplicate Records

Duplicate rows were reviewed to determine whether they represented true duplicates or valid repeated business events.

### Recommended Action

- Remove only confirmed duplicate records.
- Preserve legitimate repeated observations.
- Validate duplicates using appropriate business keys.

---

## Text Quality

Text columns were inspected for:

- Leading spaces
- Trailing spaces
- Extra spaces
- Mixed capitalization
- Inconsistent naming conventions

### Recommended Action

Standardize text formatting before importing the data into PostgreSQL.

Example:

```text
" Boeing "
"boeing"
"BOEING"
