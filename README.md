# E-Commerce Customer Analytics & RFM Segmentation

An end-to-end data analytics project focused on analysing e-commerce sales performance, understanding customer purchasing behaviour, and segmenting customers using the RFM (Recency, Frequency, Monetary) model.

The project follows a complete data analytics workflow using **Microsoft Excel, MySQL, and Microsoft Power BI**, transforming raw transactional data into meaningful business insights through data cleaning, SQL analysis, customer segmentation, and interactive dashboards.

---

## Table of Contents

1. [Project Overview](#-project-overview)
2. [Business Objectives](#-business-objectives)
3. [Technology Stack](#-technology-stack)
4. [Dataset Overview](#-dataset-overview)
5. [Project Workflow](#-project-workflow)
6. [Data Cleaning & Preparation](#-data-cleaning--preparation)
7. [SQL Analysis](#-sql-analysis)
8. [RFM Analysis & Customer Segmentation](#-rfm-analysis--customer-segmentation)
9. [Power BI Dashboards](#-power-bi-dashboards)
10. [Key Business Insights](#-key-business-insights)
11. [Project Structure](#-project-structure)
12. [How to Explore the Project](#-how-to-explore-the-project)
13. [Business Recommendations](#-business-recommendations)
14. [Future Improvements](#-future-improvements)

---

## 📌 Project Overview

Understanding customer behaviour and sales performance is essential for e-commerce businesses to make informed business decisions.

This project analyses e-commerce transactional data to uncover sales trends, customer purchasing patterns, revenue contributions, and customer value.

The project uses Excel for initial data auditing and preparation, MySQL for data validation, business analysis and RFM-based customer segmentation, and Power BI for developing interactive dashboards.

The final outcome is a two-page Power BI report covering:

- Sales Performance Analysis
- Customer Segmentation & RFM Analysis

The objective is to convert transactional data into actionable insights that can support business performance evaluation, customer retention, and data-driven decision-making.

## 🎯 Business Objectives

The primary objectives of this project are:

- Analyse overall sales performance and revenue trends.
- Identify top-performing product categories and regions.
- Understand customer purchasing behaviour.
- Analyse order distribution across payment methods and geographical regions.
- Evaluate returned orders and return rates.
- Calculate customer Recency, Frequency, and Monetary values.
- Segment customers based on their purchasing behaviour and value.
- Identify high-value, loyal, potential, and at-risk customers.
- Compare revenue and purchasing activity across customer segments.
- Develop interactive dashboards to communicate business insights effectively.

---

## 🛠️ Technology Stack

| Technology | Purpose |
|---|---|
| Microsoft Excel | Data auditing, inspection, validation and preprocessing |
| MySQL | Data storage, SQL queries, business analysis and RFM segmentation |
| Microsoft Power BI | Data modelling, DAX measures, visualisation and interactive dashboards |

### Tools & Features Used

**Excel**
- Data inspection and auditing
- Missing-value validation
- Duplicate detection
- Data consistency checks
- Data preparation

**MySQL**
- Database and table creation
- Data import and validation
- Filtering and sorting
- Aggregate functions
- GROUP BY and HAVING
- Subqueries
- CASE statements
- Joins and customer-level analysis
- Window functions
- RFM calculations and customer segmentation

**Power BI**
- Data modelling and relationships
- DAX measures
- KPI cards
- Slicers and interactive filters
- Donut charts
- Column and bar charts
- Scatter plots
- Stacked area charts

---

## 📊 Dataset Overview

The project uses an e-commerce transactional dataset containing customer and order-related information.

### Dataset Statistics

| Attribute | Details |
|---|---:|
| Total Records | 34,500 |
| Total Columns | 17 |
| Unique Order IDs | 34,500 |
| Unique Customers | 7,903 |
| Start Date | 12 September 2023 |
| End Date | 11 September 2025 |
| Missing Values | 0 |
| Exact Duplicate Rows | 0 |

The dataset contains information related to:

- Customer identification and demographics
- Order identification and dates
- Product categories and product information
- Purchase quantities and prices
- Discounts and total amounts
- Payment methods
- Geographical regions
- Shipping costs and delivery information
- Order returns

**Note:** The dataset was audited before analysis. The validation results indicated no missing values or exact duplicate records.

---

## 🔄 Project Workflow

The project follows a structured data analytics workflow:

1. Dataset inspection and auditing using Excel.
2. Data preparation and validation.
3. Importing transactional data into MySQL.
4. Database and data validation.
5. SQL-based business analysis.
6. RFM metric calculation and scoring.
7. Customer segmentation.
8. Exporting analytical tables for Power BI.
9. Data modelling and relationship creation.
10. DAX measure development.
11. Interactive dashboard development.
12. Business insights and interpretation.

---

## 🧹 Data Cleaning & Preparation

Microsoft Excel was used for initial data inspection, auditing, and preprocessing.

The workbook was organised into three sheets:

| Sheet | Purpose |
|---|---|
| Raw_Data | Original dataset preserved without modifications |
| Data_Audit | Column-level data quality inspection and validation |
| Cleaned_Data | Prepared dataset for further analysis |

### Data Quality Checks

The following checks were performed:

- Missing-value validation across all 17 columns.
- Exact duplicate-row detection.
- Categorical consistency checks.
- Numeric and date-range validation.
- Logical validation of relevant columns.
- Inspection of customer, order, product, and transaction fields.

### Data Quality Results

- No missing values were identified.
- No exact duplicate rows were found.
- Column-level validation was completed.
- The prepared dataset was used for subsequent MySQL analysis.

---

## 🗄️ SQL Analysis

MySQL was used to store, validate, and analyse the transactional dataset.

### Database Information

**Database:** `ecommerce_analysis`

**Primary transaction table:** `ecommerce_data`

The imported data was validated to confirm:

- 34,500 transaction records.
- 34,500 unique order IDs.
- 7,903 unique customers.
- Correct date range.
- No missing values in key fields.

### SQL Business Analysis

A total of 12 business-oriented SQL queries were developed and executed.

The analysis covered areas such as:

- Overall sales and revenue performance.
- Order and customer analysis.
- Product category performance.
- Regional sales analysis.
- Payment method distribution.
- Customer purchasing behaviour.
- Transaction and return-related analysis.
- Revenue and purchasing metrics.

The SQL work also included subqueries, CASE statements, aggregate functions, and window functions where appropriate.

The objective was to answer practical business questions rather than simply demonstrate SQL syntax.

---

## 👥 RFM Analysis & Customer Segmentation

RFM analysis was performed to understand customer purchasing behaviour and identify different customer value groups.

RFM stands for:

### 1. Recency (R)

Measures how recently a customer made a purchase.

- Lower recency value means the customer purchased more recently.
- Higher recency value indicates a longer period since the last purchase.

### 2. Frequency (F)

Measures how many purchases a customer made during the analysis period.

- Higher frequency indicates more frequent purchasing behaviour.
- Each order is counted as one purchase, irrespective of the number of products in that order.

### 3. Monetary (M)

Measures the total amount spent by a customer during the analysis period.

- Higher monetary value indicates greater recorded customer spending.
- It helps identify customers who contribute more to overall revenue.

### RFM Calculation

Recency, Frequency, and Monetary metrics were calculated at the customer level using MySQL.

The reference date used for Recency calculation was:

**11 September 2025**

The calculated metrics and scores were stored in the `rfm_scores` table.

### Customer Segmentation

Customers were classified into five segments using SQL CASE-based segmentation logic.

| Customer Segment | Description |
|---|---|
| Champions | Customers with strong Recency, Frequency, and Monetary scores |
| Loyal Customers | Customers demonstrating strong purchasing frequency |
| Potential Loyalists | Recently active customers with potential to become loyal |
| At Risk | Previously frequent customers who have not purchased recently |
| Others | Customers who do not fall into the specifically defined segments |

### Key Segmentation Rules

Some of the implemented segmentation conditions include:

| Segment | Condition |
|---|---|
| Champions | Recency Score >= 4, Frequency Score >= 4, Monetary Score >= 4 |
| At Risk | Recency Score <= 2 and Frequency Score >= 3 |
| Potential Loyalists | Recency Score >= 4 and Frequency Score <= 2 |
| Loyal Customers | Frequency Score >= 4 |
| Others | Remaining customers |

The resulting customer-level segmentation was stored in the `customer_segments` table.

### Customer Segment Distribution

A total of 7,903 customers were classified into five segments.

| Segment | Customers | Percentage |
|---|---:|---:|
| Others | 4,815 | 60.93% |
| Potential Loyalists | 1,422 | 17.99% |
| Loyal Customers | 1,020 | 12.91% |
| At Risk | 598 | 7.57% |
| Champions | 48 | 0.61% |
| **Total** | **7,903** | **100%** |

---

## 📈 Power BI Dashboards

Microsoft Power BI was used to create an interactive two-page report.

### Dashboard 1: Sales Overview

The Sales Overview dashboard focuses on overall business performance and transactional analysis.

<p align="center">
  <img src="Powerbi%20Dashboard%20part/Sales%20Overview%20Dashboard.png" alt="Sales Overview Dashboard" width="900">
</p>

**Key Performance Indicators (KPIs)**

- Total Revenue
- Total Orders
- Total Customers
- Average Order Value
- Total Quantity Sold

**Visualisations**

| Visual | Business Purpose |
|---|---|
| Yearly Revenue Trend | Analyse revenue changes over time |
| Revenue by Category | Identify top-performing product categories |
| Orders by Payment Method | Understand payment method distribution |
| Orders by Region | Compare order volumes across regions |
| Returned vs Non-Returned Orders | Understand order return patterns |

**Interactive Slicers**

- Order Date
- Product Category
- Payment Method
- Customer Gender
- Region
- Customer Segment

### Dashboard 2: Customer Segmentation & RFM Analysis

The second dashboard focuses on customer value, purchasing behaviour, and RFM segmentation.

<p align="center">
  <img src="Powerbi%20Dashboard%20part/RFM%20Segmentation%20Dashboard.png" alt="RFM Segmentation Dashboard" width="900">
</p>

**Key Performance Indicators (KPIs)**

- Total Customers
- Champions
- Potential Loyalists
- At Risk
- Loyal Customers
- Others

**Visualisations**

| Visual | Business Purpose |
|---|---|
| Customer Segment Distribution | Understand the distribution of customers across RFM segments |
| Revenue by Customer Segment | Compare revenue contributions across segments |
| Total Orders by Customer Segment | Analyse order volume across customer segments |
| Average Purchase Frequency by Segment | Compare purchasing frequency across segments |
| Frequency vs Monetary by Segment | Explore the relationship between customer purchase frequency and spending |
| Monthly Revenue Trend by Segment | Analyse historical monthly revenue contributions from different customer segments |

**Note:** The RFM segment labels are based on the final customer classification using the 11 September 2025 reference date. The monthly revenue trend therefore groups historical transactions according to customers' final assigned segments.

---

## 💡 Key Business Insights

The analysis provides several useful observations:

### Customer Distribution
- Others represent approximately 60.93% of the customer base.
- Potential Loyalists represent approximately 17.99%.
- Loyal Customers account for approximately 12.91%.
- At Risk customers represent approximately 7.57%.
- Champions represent approximately 0.61%.

### Revenue Contribution
The Others segment contributes the highest total recorded revenue, followed by Loyal Customers and Potential Loyalists.

### Purchasing Frequency
Champions have the highest average purchase frequency at 8.48, followed by Loyal Customers at 7.89.

### Customer Retention Opportunities
The At Risk segment contains 598 customers who may require targeted engagement and retention strategies.

### Customer Value Analysis
Combining Frequency and Monetary metrics provides a way to explore purchasing patterns, identify high-spending customers, and understand differences between customer segments.

---

## 📁 Project Structure

The repository is organised around the main stages of the analytics workflow.

```text
Customer-Segment-RFM-and-Sales-Analysis/
│
├── Dataset preparation for analysis/
│   ├── E-commerce_Customer_Segmentation_raw.csv
│   ├── E-commerce_Customer_Segmentation.xlsx
│   └── Data Audit.xlsx
│
├── Powerbi Dashboard part/
│   ├── RFM_analysis.pbix
│   ├── RFM Segmentation Dashboard.png
│   ├── Sales Overview Dashboard.png
│   ├── ecommerce_data.csv
│   ├── rfm_scores.csv
│   └── customer_segments.csv
│
├── Business queries and RFM.sql
│
└── README.md
```

| Folder / File | Purpose |
|---|---|
| `Dataset preparation for analysis/` | Raw dataset, the Excel-cleaned version, and the data audit |
| `Powerbi Dashboard part/` | Power BI file, dashboard screenshots, and the CSVs that feed the dashboard |
| `Business queries and RFM.sql` | SQL for data validation, business analysis, RFM scoring, and customer segmentation |
| `README.md` | Project documentation |

---

## 🚀 How to Explore the Project

To explore the project:

### 1. Excel

Open the Excel workbook to review the original dataset, data audit, and prepared data.

### 2. MySQL

Import the dataset into MySQL and execute the SQL scripts to explore the data validation, business analysis, RFM calculations, and segmentation logic.

### 3. Power BI

Open the `.pbix` report in Power BI Desktop to explore the Sales Overview and Customer Segmentation dashboards.

Interact with the slicers and visuals to investigate sales performance and customer behaviour.

**Requirements:**
- Microsoft Excel
- MySQL Server and MySQL Workbench
- Microsoft Power BI Desktop

---

## 📌 Business Recommendations

Based on the analysis, the following strategies could be considered:

| Customer Segment | Suggested Business Strategy |
|---|---|
| Champions | Introduce loyalty rewards, exclusive offers, and referral programmes |
| Loyal Customers | Encourage repeat purchases through loyalty benefits and personalised offers |
| Potential Loyalists | Use targeted promotions and engagement campaigns to encourage repeat purchases |
| At Risk | Consider win-back campaigns and personalised incentives to reactivate customers |
| Others | Analyse purchasing behaviour further and identify opportunities to improve customer engagement |

These are potential business strategies derived from the segmentation results, not measured outcomes of campaigns.

---

## 🔮 Future Improvements

Potential enhancements to the project include:

- Adding more detailed customer retention analysis.
- Performing cohort-based customer analysis.
- Analysing customer lifetime value.
- Exploring customer purchasing patterns over different time periods.
- Developing more advanced customer segmentation techniques.
- Adding predictive analytics for customer churn.
- Automating data refresh and dashboard updates.

---

## 👨‍💻 Project Objective

This project was developed to apply practical data analytics skills to a real-world-style e-commerce business scenario.

It demonstrates an end-to-end workflow involving data preparation, SQL-based analysis, customer segmentation, and interactive business intelligence reporting.

**The ultimate objective is to transform raw transactional data into meaningful business insights that support better sales analysis, customer understanding, and data-driven decision-making.**
