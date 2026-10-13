# 🏨 Hotel & Airbnb Booking, Pricing & Occupancy Analytics

An end-to-end analytics project on a hospitality booking dataset, covering **data cleaning in Excel**, **relational analysis in MySQL**, and an **interactive two-page dashboard in Power BI**.

> B.Tech (CSE) project report — CGC University Mohali, July 2026
> **Author:** Sukhwinder Singh · **Guide:** Pawan Saini

---

## 📌 Overview

Hotels and Airbnb-style properties generate large volumes of booking, customer, payment and review data, but it is rarely clean or connected. This project turns that raw data into decision-support insights by following a three-stage BI pipeline:

```
Raw (dirty) data ──► Excel (clean & validate) ──► MySQL (model & query) ──► Power BI (visualise)
```

## 🎯 Key Questions Answered

- Which cities and property types generate the most revenue?
- How do Hotels and Airbnb listings compare?
- How do bookings and revenue vary by season, weekday/weekend and lead time?
- Which room types, booking sources and payment methods are most popular?
- Who are the highest-spending customers, and how satisfied are guests?

## 🗂️ Repository Structure

```
Hotel & Airbnb Analytics/
├── dirty_dataset_cleaning.csv.xlsx      # Cleaned dataset (7 tables) + pivot tables + Excel dashboard
├── Hotel_Airbnb_SQL_Queries.sql         # 30 MySQL analytical queries
├── Hotel & Airbnb Analytics Report.docx # Full project report
└── README.md
```

## 🧰 Tools & Technologies

| Tool | Purpose |
|---|---|
| **Microsoft Excel** | Data cleaning, pivot tables, intermediate dashboard |
| **MySQL Workbench** | Relational database and SQL analysis |
| **Power BI Desktop** | Data model, DAX measures, interactive dashboard |
| **CSV** | Interchange format between tools |

## 🗃️ Dataset

Seven related tables (Excel sheets):

| Table | Key Columns | Description |
|---|---|---|
| `booking` | booking_id, customer_id, property_id, property_type, city, room_type, check_in/out, booking_status, season, total_amount | Central fact table — one row per reservation |
| `customer` | customer_id, name, gender, age, city, state | Guest demographics |
| `property` | property_id, property_name, property_type, city, state | Hotel / Airbnb listings |
| `hotel_detail` | property_id, hotel_chain, stars, total_rooms, amenities | Hotel-specific attributes |
| `airbnb_detail` | property_id, host_id, instant_bookable, minimum_nights, availability_365 | Airbnb-specific attributes |
| `payment` | payment_id, booking_id, base_price, discount, GST, total_amount, payment_method, payment_status | Financial details |
| `review` | review_id, booking_id, rating, review_title, would_recommend | Post-stay feedback |

**Relationships**

| Parent | Child | Key |
|---|---|---|
| Customer | Booking | `customer_id` |
| Property | Booking | `property_id` |
| Booking | Payment | `booking_id` |
| Booking | Review | `booking_id` |
| Property | Hotel / Airbnb Detail | `property_id` |

## 🧹 Data Cleaning (Excel)

| Issue | Fix |
|---|---|
| Missing values | Corrected with logical rules, or removed if unrecoverable |
| Duplicate records | Removed against key IDs |
| Inconsistent categories (room type, status) | Standardised to fixed sets |
| Extra spaces / casing | Cleaned with text functions |
| Mixed date formats | Converted to a single format |

## 🔎 SQL Analysis

`Hotel_Airbnb_SQL_Queries.sql` contains **30 queries**, progressing from basics to advanced:

- **KPIs:** total bookings, revenue, customers, properties
- **Aggregations:** revenue/bookings by city, property type, season, room type, booking source, payment method
- **Customer analysis:** top spenders, repeat customers (>5 bookings)
- **Quality & behaviour:** average rating, lead time, stay duration, weekend vs weekday
- **Advanced SQL:** `RANK()`, `ROW_NUMBER()`, CTEs, subqueries, running totals with window functions

**Run it:**

```sql
-- 1. Import the cleaned sheets as tables: booking, customer, property,
--    payment, review, hotel_detail, airbnb_detail
-- 2. Then execute:
SOURCE Hotel_Airbnb_SQL_Queries.sql;
```

## 📊 Power BI Dashboard

**DAX measures**

| Measure | Formula |
|---|---|
| Total Revenue | `SUM(payment_dirty[final_amount])` |
| Total Bookings | `COUNTROWS(booking_dirty)` |
| Total Customers | `DISTINCTCOUNT(booking_dirty[customer_id])` |
| Average Rating | `AVERAGE(review_dirty[customer_rating])` |
| Avg. Stay Duration | `AVERAGE(booking_dirty[total_nights])` |

**Page 1 – Executive Overview:** KPI cards, Top 10 cities by revenue, revenue by property type, monthly revenue trend, booking status distribution.

**Page 2 – Customer & Property Insights:** top customers, payment methods, revenue by room type, purpose of visit, bookings by season, preferred room types.

Slicers for **City, Property Type, Season and Booking Status** are synced across both pages, with navigation buttons between them.

## 💡 Key Insights

- Revenue is concentrated in a small set of cities and property types.
- Hotels and Airbnb listings differ in booking and revenue patterns.
- Booking volume varies noticeably by month and season.
- A meaningful share of bookings are Cancelled or Waiting rather than Confirmed.
- A small group of high-value customers drives a large share of revenue.
- Customers show clear payment-method and room-type preferences.

## 🚀 Future Scope

- Predictive models for demand, pricing and cancellations
- Real-time data feeds and automated refresh
- Sentiment analysis of review text

## 🧠 Skills Demonstrated

Data cleaning · Relational database design · Advanced SQL (joins, CTEs, window functions) · Data modelling · DAX · Dashboard design · Business storytelling

## 📄 Report

Full methodology, literature review, results and conclusions are in **`Hotel & Airbnb Analytics Report.docx`**.

## 👤 Author

**Sukhwinder Singh** — B.Tech CSE, CGC University Mohali
