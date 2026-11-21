# End-to-End Data Cleaning & Analysis: Pizza Place Sales

**Tools:** Python (Pandas), Jupyter Notebook / VS Code, SQL

## 1. Project Overview
This dataset contains sales transactions from a pizza restaurant spread across 4 separate CSV files (`orders.csv`, `order_details.csv`, `pizzas.csv`, and `pizza_types.csv`). Before conducting business analysis to identify peak hours and best-selling menu items, the raw data needed to be audited, standardized, and enriched with time-based features to ensure accurate reporting.

## 2. Raw Data Challenges (Initial Findings)
* **Character Encoding Issue:** `pizza_types.csv` contained special characters that triggered a standard UTF-8 decoding error when loaded into Python.
* **Unformatted Date & Time Columns:** The `date` and `time` columns in the `orders` table were stored as `object` (string) data types, preventing day-of-week and hourly trend analysis.
* **Potential Whitespace in Text Fields:** Categorical and text columns (`category`, `name`, and `size`) risked having leading or trailing spaces that could split identical groups during aggregation.

## 3. Data Cleaning & Preparation Steps (`cleaning.ipynb`)
* **Data Loading & Encoding Handling:** Loaded all 4 datasets into Pandas and applied `encoding="latin1"` to `pizza_types.csv` so all menu names and ingredients rendered properly.
* **Automated Data Auditing:** Stored all DataFrames in a Python dictionary and iterated through them using a `for` loop to inspect data types (`.info()`), check missing values (`.isnull().sum()`), and verify duplicate records (`.duplicated().sum()`).
* **Datetime Conversion & Feature Engineering:** Converted `date` and `time` columns into `datetime` objects, then extracted `dayname` and `order_hour` columns to support operational peak-hour analysis.
* **Text Standardization:** Applied `.str.strip()` across `size`, `name`, and `category` columns to remove extra whitespace.
* **Export Clean Datasets:** Exported the validated tables into 4 clean CSV files (`orders_clean.csv`, `order_details_clean.csv`, `pizzas_clean.csv`, and `pizza_types_clean.csv`).

## 4. Repository Structure
* `cleaning.ipynb` — Jupyter Notebook containing the full Python data inspection, cleaning, and feature engineering workflow.
* `orders.csv`, `order_details.csv`, `pizzas.csv`, `pizza_types.csv` — Original raw datasets.
* `*_clean.csv` — Validated datasets (0 missing values, 0 duplicates) ready for SQL querying and visualization.
