# HR Workforce Intelligence & Attrition Analytics

## Project Overview
This project focuses on analyzing employee workforce data and identifying patterns associated with employee attrition using **MySQL**. It demonstrates how SQL can be used to transform workforce data into meaningful insights that support HR decision-making.

The project uses the HR Analytics Employee Attrition & Performance dataset, containing 1,470 employee records and 35 attributes.

## Business Problem
Employee attrition can affect workforce stability, productivity, and recruitment costs. This project explores workforce characteristics and identifies employee groups with comparatively higher attrition rates to help HR teams understand where attention may be needed.

## Project Objectives
- Analyze overall employee attrition and workforce distribution.
- Identify attrition patterns across departments, job roles, and employee demographics.
- Examine the relationship between job satisfaction, overtime, salary, tenure, and attrition.
- Perform data quality checks and validation.
- Use relational tables and SQL joins to combine workforce information.
- Create reusable database objects for analytical purposes.

## Tools & Technologies
- **Database:** MySQL
- **SQL Environment:** MySQL Workbench
- **Documentation:** Microsoft Word / PDF

## Database Structure
The project uses three tables:

- `employees` – employee dataset.
- `employee_hire_details` – Supporting hire-date information.
- `employee_exit_details` – Supporting exit-date and exit-reason information.


## SQL Concepts Demonstrated
- Data inspection and validation
- Filtering, sorting, and aggregation
- GROUP BY and HAVING
- CASE statements
- Subqueries and Common Table Expressions (CTEs)
- Joins and relational analysis
- Window functions
- Views and stored procedures
- Database object validation

## Key Findings
- Total employees analyzed: **1,470**
- Active employees: **1,233**
- Employees who exited: **237**
- Overall attrition rate: **16.12%**
- Sales department attrition rate: **20.63%**
- HR department attrition rate: **19.05%**
- Research & Development department attrition rate: **13.84%**

These findings describe patterns in the dataset and should not be interpreted as proof of cause and effect.

## Repository Structure
- `Documentation/` – Detailed project documentation.
- `Dataset/` – Source dataset.
- `SQL/` – SQL scripts organized by analytical area.
- `Screenshots/` – Project execution evidence.
- `README.md` – Project overview.

## Dataset Source & Attribution

**Dataset:** HR Analytics Employee Attrition & Performance

**Source:** [Kaggle –  HR Analytics Employee Attrition & Performance](https://www.kaggle.com/datasets/pavansubhasht/ibm-hr-analytics-attrition-dataset)

The original dataset contains fictional employee data created by data scientists and includes 1,470 employee records with 35 columns.

**Additional Data:** The `employee_hire_details` and `employee_exit_details` tables were created for this project to support relational analysis and SQL joins. They are not part of the dataset.

## Project Documentation
The detailed project report is available in the `Documentation` folder.

## Disclaimer
This is an independent SQL portfolio project created for learning and demonstrating SQL-based workforce analytics. 