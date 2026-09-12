# Zomato Restaurant Analytics

An end-to-end data analytics project on global restaurant listings from Zomato — covering **data cleaning (Python), relational modeling & querying (SQL), and reporting**.

## 📌 Problem Statement

Zomato's raw restaurant listing data — spanning multiple countries, cuisines, pricing tiers, and service features — is unclean and split across disconnected sheets (main listings, currency rates, country names, opening dates), making it difficult to analyze restaurant distribution, pricing, ratings, and service adoption (table booking, online delivery) in a structured way.

## 🎯 Objective

To clean and structure the raw Zomato dataset, build a relational data model in SQL, and answer key business questions — restaurant distribution by geography and time, pricing and rating segmentation, service adoption rates, and cuisine popularity — to support data-driven insights into the restaurant industry.

## 🛠️ Tools & Workflow

```
Raw Data (Zomato.xlsx)
        ↓
   Python (Pandas) — cleaning, type-fixing, null handling
        ↓
   Cleaned dataset exported (Main, Calendar, Currency, Country sheets)
        ↓
   MySQL — table import, relational modeling, business-question querying
        ↓
   Excel , Tableau & Power BI — interactive dashboards & reporting
```

---

### 1️⃣ Python — Data Cleaning (`Zomato_Cleaning_SQL_Import.ipynb`)

- Loaded all sheets (`Main`, `Currency`, `Country`, `Calendar`) from the raw Excel file using `pandas`
- Standardized column names (stripped whitespace, replaced spaces with underscores) across all four tables
- Checked and confirmed **zero duplicate rows** in the main table
- Checked null values and data types across all tables
- Fixed data types — e.g. cast `RestaurantID` to object, `Year`/`Month_No` in the calendar table to integer
- Dropped calendar rows with missing `Datekey`
- Exported all four cleaned tables into a single consolidated file: **`Zomato_Cleaned_dataset.xlsx`**
- Loaded the cleaned `Main` table (9,551 rows) into a MySQL database (`ZOMATO_RESTUARANTS`) using `SQLAlchemy`

### 2️⃣ SQL — Data Modeling & Analysis (`Zomato_Project.sql`)

**Relational model built** connecting:
- `main.year_&_date` → `calender.Datekey`
- `main.Currency` → `currency.Currency`
- `main.CountryCode` → `country.CountryID`

**Key findings from SQL analysis:**
- New Delhi and India-based cities dominate restaurant counts, far ahead of other cities/countries
- Restaurant openings have grown steadily from 2010 to 2018, with a brief dip mid-decade
- The majority of restaurants fall in the lower rating buckets (0–2 and 2–3), with fewer high-rated (4–5) restaurants
- Most restaurants are concentrated in the **Affordable/Budget** price buckets, with very few in the Premium/Luxury range
- Only a small share of restaurants offer **table booking**, while a larger share offer **online delivery**
- Restaurants in higher price range segments tend to have slightly higher average ratings
- **North Indian** is the most common cuisine city-wide, with a solid average rating
- A niche set of restaurants combine **high ratings (≥4.5) with low customer engagement (<50 votes)** — potentially undiscovered, underrated spots

### 3️⃣ Tableau — Restaurant Overview Dashboard

Raw cleaned files were imported into Tableau and relationships established between them (Main ↔ Calendar ↔ Currency ↔ Country) to power this dashboard.

- Covers **8,652 restaurants** across 15 countries and 43 cities
- Average rating of **2.8** with **1,187K total votes**
- **New Delhi** leads restaurant count by a wide margin over other cities
- **"Cheap"** price bucket dominates at **81.73%** of listings
- Only **12.84%** of restaurants offer table booking
- Restaurant openings show a steady rise from 2010 through 2018

### 4️⃣ Power BI — Multi-Page Restaurant Analytics

Raw cleaned files (Main, Calendar, Currency, Country) were imported into Power BI and relationships established via the data model to enable cross-filtering across the Overview, Dining, and Geographical & Location Analysis pages.

- Covers **10K+ restaurants** across **141 cities**
- Average rating of **2.89** and average cost of **$10.09**
- **North Indian** is the most common cuisine (936 restaurants)
- Table booking adoption sits at **12.12%** vs. **26%** for online delivery
- **India** accounts for the vast majority of listings (8,652) compared to the US (434)

### 5️⃣ Excel — Interactive Dashboard

Cleaned data was loaded into Excel, connected via Pivot Tables, and built into an interactive dashboard using slicers for dynamic filtering.

- Covers **9,551 restaurants** across **15 countries**, with an average rating of **2.89** and average cost of **$10.09**
- **Rating by Restaurant** — nearly half (48%) fall in the 3–4 rating range, with only 14% rated 4–5
- **Global Dining Affordability Index** — Singapore ($155.8) and Philippines ($117.3) rank as the most expensive countries by average cost, while Turkey and India rank cheapest
- **Top 10 Restaurants by City** — New Delhi leads by far (5,473), followed by Gurgaon (1,118) and Noida (1,080)
- **Price Bucket Analysis** — Affordable dominates (7,273 restaurants), followed by Mid-Range (852), Budget (1,245), Premium (144), and Luxury (37)
- **Online Delivery vs. Table Booking** — 25.66% of restaurants offer online delivery vs. 12.12% offering table booking, both still a minority of total listings
- **Restaurant Opening by Year** — steady growth from 2010 to 2018, dipping mid-decade before recovering to 1,102 new openings by 2018
- **Top 10 Expensive Cuisines** — French, Mediterranean, European cuisine tops the list at $500, followed by Chinese, Continental, Singaporean ($438)
- Filters: Reasonable Restaurants (price tier), Year & Date, Country

---

## 📁 Files in this Repository

| File | Description |
|---|---|
| `Zomato.xlsx` | Raw data file |
| `ZomatoQuestionnaire.txt` | Project Questionnaire file |
| `ZOMATO-excel.xlsx` | Excel project file -Overview |
| `Zomato_Project.sql` | SQL scripts — data model, relationships & business queries |
| `Zomato_Restaurant_Overview.twbx` | Tableau packaged workbook — Restaurant Overview dashboard |
| `Zomato_Dashboard.pbix` | Power BI project file — Overview, Dining, and Geographical pages |


## 📈 Key Insights

- The cleaned dataset covers **9,551 restaurants** across 15 countries and 141 cities.
- **India dominates** restaurant listings with 8,652 restaurants, followed distantly by the United States (434).
- **New Delhi** is the top city by restaurant count (5,473–5.5K), far ahead of Gurgaon and Noida.
- The majority of restaurants fall in the **"Cheap"/Affordable** price bucket (81.73%), with very few in the Expensive tier (0.45%).
- Only **12–12.84% of restaurants offer table booking**, while **26% offer online delivery** — indicating substantial room for service adoption growth.
- **North Indian** is the most common cuisine (936 restaurants), and Jakarta shows the highest average customer engagement (votes) by city.
- Most restaurants cluster in the **"Good" (4,282)** and **3–4 rating bucket (48.06%)**, with the highest-rated city being Inner City at 4.90.
- Restaurant openings grew steadily from 2010 to 2018, dipping mid-decade before recovering to 1,003+ new openings by 2018.

---

⭐ If you found this project useful, consider giving the repo a star!
