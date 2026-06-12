# Employee Performance & Collection MIS System

## Project Overview

This project is an end-to-end MIS (Management Information System) dashboard built using **SQL and Excel** to analyze employee performance, attendance, sales, collections, and operational efficiency.

The objective of this project is to simulate a real-world business environment where managers can monitor key performance indicators (KPIs), identify top performers, track collections and sales trends, and make data-driven decisions.

---

## Tools Used

* MySQL
* Microsoft Excel
* Power Query
* Charts
* Data Cleaning
* Dashboard Design

---

## Dataset Information

The project consists of four datasets:

### Employees Table

Contains employee master information:

* Employee ID
* Employee Name
* Department
* Manager
* City
* Salary
* Experience

### Attendance Table

Tracks employee attendance and login hours:

* Attendance Date
* Employee ID
* Login Hours
* Attendance Status

### Sales Table

Tracks employee sales performance:

* Sales Date
* Employee ID
* Calls Made
* Target Sales
* Sales Amount

### Collections Table

Tracks collection performance:

* Collection Date
* Employee ID
* Target Collection
* Collection Amount
* Pending Amount
* Payment Status

---

## Database Structure

Database Name:

* employees

Tables:

* employees
* attendance
* sales
* collections

The tables are connected using **Employee ID (emp_id)** to perform data analysis using SQL JOIN operations.

---

## SQL Concepts Used

The project demonstrates practical usage of:

* SELECT Statements
* WHERE Clause
* ORDER BY
* GROUP BY
* HAVING
* Aggregate Functions

  * SUM()
  * AVG()
  * COUNT()
  * MAX()
  * MIN()
* INNER JOIN
* LEFT JOIN
* CASE WHEN
* Window Functions

  * RANK()
  * DENSE_RANK()
  * ROW_NUMBER()
* Common Table Expressions (CTE)
* Data Aggregation
* KPI Calculations

---

## Key Business Questions Solved

### Employee Analysis

* Total Employees
* Department-wise Employee Count
* Manager-wise Team Size
* City-wise Employee Distribution

### Attendance Analysis

* Attendance Percentage
* Average Login Hours
* Department-wise Login Hours

### Sales Analysis

* Total Sales
* Sales Efficiency %
* Department-wise Sales
* Daily Sales Trend

### Collection Analysis

* Total Collection
* Collection Efficiency %
* Department-wise Collection
* Manager-wise Collection
* Top 10 Collectors
* Daily Collection Trend

### Performance Analysis

* High, Medium and Low Performers
* Employee Ranking using Window Functions
* Top Performers by Department
* Employees Above Department Average Collection

---

## Dashboard KPIs

The dashboard includes:

* Total Employees
* Attendance %
* Average Login Hours
* Total Sales
* Total Collection
* Collection Efficiency %
* Sales Efficiency %

---

## Dashboard Features

* Interactive Slicers

  * Department
  * Manager
  * City

* Department Performance (Sales vs Collection)

* Manager-wise Collection Analysis

* Top 10 Collectors

* Department-wise Average Login Hours

* Daily Sales Trend

* Daily Collection Trend

---

## Project Workflow

Raw Data (CSV Files)

↓

MySQL Database

↓

SQL Analysis & KPI Calculation

↓

Excel Dashboard Development

↓

Business Insights & Reporting

---

## Key Insights

* Identified top-performing employees based on collection achievement.
* Compared departmental sales and collection performance.
* Tracked daily sales and collection trends.
* Measured operational efficiency using attendance and login hours.
* Created a centralized MIS dashboard for decision-making.

---

## Screenshots

### Dashboard

Employee Performance & Collection MIS Dashboard

### Database Structure

employees database containing:

* employees
* attendance
* sales
* collections

### SQL Analysis Output

Business KPI calculations and analytical query results.

---

## Author

**Rishabh Raj**

Data Analyst Portfolio Project

Skills Demonstrated:

* SQL
* Excel
* Power Query
* Dashboarding
* Data Analysis
