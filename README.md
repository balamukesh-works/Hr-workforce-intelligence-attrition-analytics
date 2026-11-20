HR Workforce Intelligence & Attrition Analytics

A SQL-based workforce analytics project using MySQL to investigate employee attrition patterns, analyze workforce characteristics, and generate meaningful HR insights.

---

📌 Project Overview

This project focuses on analyzing employee workforce data and identifying patterns associated with employee attrition using MySQL.

The analysis uses the HR Analytics Employee Attrition & Performance dataset, containing 1,470 employee records and 35 original attributes.

The project demonstrates practical SQL skills across data validation, relational database design, workforce analysis, and advanced analytical querying.

🎯 Business Problem

Employee attrition can affect workforce stability, productivity, and recruitment costs.

This project explores workforce characteristics and identifies employee groups with comparatively higher attrition rates to help HR teams understand where attention may be needed.

🎯 Project Objectives

- Analyze overall employee attrition and workforce distribution.
- Identify attrition patterns across departments, job roles, and employee demographics.
- Examine relationships between satisfaction, overtime, salary, tenure, and attrition.
- Perform data quality checks and validation.
- Design relational tables and apply SQL JOINs.
- Develop reusable database objects for analytical purposes.

🛠️ Tools & Technologies

| Category | Technology |
|---|---|
| Database | MySQL |
| SQL Environment | MySQL Workbench |
| Documentation | Microsoft Word / PDF |
| Query Language | SQL |

📊 Dataset Overview

| Metric | Value |
|---|---:|
| Total Employee Records | 1,470 |
| Original Attributes | 35 |
| Active Employees | 1,233 |
| Employees Exited | 237 |
| Overall Attrition Rate | 16.12% |

Dataset:HR Analytics Employee Attrition & Performance

Source: Kaggle

🏗️ Database Structure

The project uses three relational tables:

| Table | Description |
|---|---|
| `employees` |  employee dataset |
| `employee_hire_details` | Supporting employee hire-date information |
| `employee_exit_details` | Supporting employee exit-date and exit-reason information |

Primary keys, foreign key constraints, and relational JOINs were implemented to support integrated analysis.


💻 SQL Concepts Demonstrated

- Data inspection and validation
- Filtering, sorting, and aggregation
- GROUP BY and HAVING
- CASE statements and conditional calculations
- Subqueries and Common Table Expressions (CTEs)
- INNER JOIN and other relational JOIN operations
- Window functions and ranking
- SQL Views and Stored Procedures
- Database object validation

 📈 Key Analytical Findings

 Overall Attrition

| Metric | Result |
|---|---:|
| Total Employees | 1,470 |
| Active Employees | 1,233 |
| Employee Exits | 237 |
| Attrition Rate | **16.12%** |

 Department-wise Attrition

| Department | Attrition Rate |
|---|---:|
| Sales | 20.63% |
| Human Resources | 19.05% |
| Research & Development | 13.84% |

Key Observation:Sales had the highest attrition rate among the three departments.

These findings describe patterns in the dataset and should not be interpreted as proof of cause and effect.

📁 Repository Structure

```text
HR-Workforce-Intelligence-Attrition-Analytics/
│
├── README.md
│
├── Dataset/
│
├── SQL/
│   ├── Data_Validation/
│   ├── Workforce_Analysis/
│   ├── Attrition_Analysis/
│   └── Advanced_SQL/
│
├── Documentation/
│
└── Screenshots/
```

The folder names above illustrate the intended organization; adjust them to match the actual repository contents.

📚 Project Documentation

The detailed project report is available in the Documentation folder.

It covers the project workflow, database design, data validation, analytical queries, findings, and conclusions.

🔍 Dataset Attribution

Dataset:HR Analytics Employee Attrition & Performance

Source:Kaggle

The dataset contains fictional employee data and includes 1,470 records with 35 columns.

Additional hire-date and exit-detail information was generated for relational database design and SQL JOIN practice.

⚠️ Disclaimer

This is an independent SQL portfolio project developed for learning and demonstrating SQL-based workforce analytics.

The analysis identifies associations and patterns within the available dataset; it does not establish causal relationships or predict employee attrition.

---

Developed using MySQL | SQL | MySQL Workbench
