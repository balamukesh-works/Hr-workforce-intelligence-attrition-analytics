
-- HR Workforce Intelligence & Attrition Analytics
-- SQL transcribed from the final project documentation PDF.
-- Review and test each statement in MySQL Workbench before committing.
-- The PDF does not include every query used in every analysis subsection.
-- No missing query has been invented in this extraction.

USE hr_analytics;

-- Section: Employee Indicator Score Analysis
-- Documentation Reference: PDF Page 46
SELECT Indicator_Score, COUNT(*) AS Total_Employees, 
   SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END ) AS Exited_Employees, 
   ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END ) * 100.0 / COUNT(*), 2 
   ) AS Attrition_Rate 
FROM (SELECT EmployeeNumber, Attrition, 
   (CASE WHEN OverTime = 'Yes' THEN 1 ELSE 0 END) + 
   (CASE WHEN YearsAtCompany <= 2 THEN 1 ELSE 0 END) + 
   (CASE WHEN JobSatisfaction <= 2 THEN 1 ELSE 0 END) + 
   (CASE WHEN WorkLifeBalance = 1 THEN 1 ELSE 0 END) + 
   (CASE WHEN BusinessTravel = 'Travel_Frequently' THEN 1 ELSE 0 END) 
   AS Indicator_Score 
 FROM employees) AS Employee_Indicators 
GROUP BY Indicator_Score 
ORDER BY Indicator_Score;

-- Section: Risk Segment-wise Attrition Analysis
-- Documentation Reference: PDF Page 47
SELECT Risk_Segment,COUNT(*) AS Total_Employees, 
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) As Exited_Employees, 
    ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)* 100.0 / COUNT(*), 2) 
    AS  Attrition_Rate 
FROM (SELECT Attrition, 
 
CASE 
  
WHEN Indicator_Score = 0 THEN 'Low Indicators' 
 
WHEN Indicator_Score = 1 THEN 'Moderate Indicators' 
 
ELSE 'Multiple Indicators' 
 
END AS Risk_Segment 
 
FROM (SELECT Attrition, 
 
 
(CASE WHEN OverTime = 'Yes' THEN 1 ELSE 0 END) + 
 
 
(CASE WHEN YearsAtCompany <= 2 THEN 1 ELSE 0 END) + 
 
 
(CASE WHEN JobSatisfaction <= 2 THEN 1 ELSE 0 END) + 

(CASE WHEN WorkLifeBalance = 1 THEN 1 ELSE 0 END) + 
 
 
(CASE WHEN BusinessTravel = 'Travel_Frequently' THEN 1 ELSE 0 END) 
 
 
AS Indicator_Score 
FROM employees) AS Employee_Indicators) AS Segmented_Employees 
GROUP BY Risk_Segment 
ORDER BY 
 
CASE Risk_Segment 
 
WHEN 'Low Indicators' THEN 1 
 
WHEN 'Moderate Indicators' THEN 2 
 
WHEN 'Multiple Indicators' THEN 3 
 
END;

-- Section: Department-wise Average Tenure of Exited Employees
-- Documentation Reference: PDF Page 49
SELECT e.Department,COUNT(*) AS Exited_Employees, 
   ROUND(AVG(DATEDIFF(x.ExitDate, h.HireDate)), 0) AS Avg_Tenure_Days, 
   ROUND(AVG(DATEDIFF(x.ExitDate, h.HireDate)) / 365.25, 2) AS Avg_Tenure_Years 
FROM employees e 
INNER JOIN employee_hire_details h 
ON e.EmployeeNumber = h.EmployeeNumber 
INNER JOIN employee_exit_details x 
ON e.EmployeeNumber = x.EmployeeNumber 
WHERE e.Attrition = 'Yes' 
GROUP BY e.Department 
ORDER BY Avg_Tenure_Days DESC;

-- Section: Exit Reason Distribution
-- Documentation Reference: PDF Page 50
SELECT ExitReason,COUNT(*) AS Exited_Employees, 
 
ROUND(COUNT(*) * 100.0 /  
SUM(COUNT(*)) OVER (), 2) AS Exit_Percentage 
FROM employee_exit_details  
 GROUP BY ExitReason 
ORDER BY Exited_Employees DESC;

-- Section: Risk Segment-wise Attrition Summary
-- Documentation Reference: PDF Page 73
SELECT CASE 
        WHEN Indicator_Score = 0 THEN 'Low Indicators' 
        WHEN Indicator_Score = 1 THEN 'Moderate Indicators' 
        ELSE 'Multiple Indicators' 
    END AS Employee_Segment, 
    COUNT(*) AS Total_Employees, 
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Exited_Employees, 
    ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0/ 
    COUNT(*),2) AS Attrition_Rate 
FROM (SELECT EmployeeNumber,Attrition, 
        (CASE WHEN OverTime = 'Yes' THEN 1 ELSE 0 END) + 
        (CASE WHEN YearsAtCompany <= 2 THEN 1 ELSE 0 END) + 
        (CASE WHEN JobSatisfaction <= 2 THEN 1 ELSE 0 END) + 
        (CASE WHEN WorkLifeBalance = 1 THEN 1 ELSE 0 END) + 
        (CASE WHEN BusinessTravel = 'Travel_Frequently' THEN 1 ELSE 0 END)AS Indicator_Score 
        FROM employees) AS Employee_Indicators 
GROUP BY Employee_Segment 
ORDER BY 

    CASE Employee_Segment 
        WHEN 'Low Indicators' THEN 1 
        WHEN 'Moderate Indicators' THEN 2 
        WHEN 'Multiple Indicators' THEN 3 
    END;

-- Section: Comparative Attrition Analysis Across Multiple Dimensions
-- Documentation Reference: PDF Page 75
WITH Employee_Indicators AS (
    SELECT
        EmployeeNumber,
        Attrition,
        (CASE WHEN OverTime = 'Yes' THEN 1 ELSE 0 END) +
        (CASE WHEN YearsAtCompany <= 2 THEN 1 ELSE 0 END) +
        (CASE WHEN JobSatisfaction <= 2 THEN 1 ELSE 0 END) +
        (CASE WHEN WorkLifeBalance = 1 THEN 1 ELSE 0 END) +
        (CASE WHEN BusinessTravel = 'Travel_Frequently' THEN 1 ELSE 0 END)
        AS Indicator_Score
    FROM employees
)

SELECT
    'Risk Segmentation' AS Attrition_Dimension,
    'Multiple Indicators' AS Employee_Group,
    COUNT(*) AS Total_Employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Exited_Employees,
    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS Attrition_Rate
FROM Employee_Indicators
WHERE Indicator_Score >= 2

UNION ALL

SELECT
    'Job Role', 'Sales Representative', COUNT(*),
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END),
    ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2)
FROM employees
WHERE JobRole = 'Sales Representative'

UNION ALL

SELECT
    'Work-Life Balance', 'Level 1', COUNT(*),
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END),
    ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2)
FROM employees
WHERE WorkLifeBalance = 1

UNION ALL

SELECT
    'Overtime', 'Yes', COUNT(*),
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END),
    ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2)
FROM employees
WHERE OverTime = 'Yes'

UNION ALL

SELECT
    'Company Tenure', '0-2 Years', COUNT(*),
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END),
    ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2)
FROM employees
WHERE YearsAtCompany BETWEEN 0 AND 2

UNION ALL

SELECT
    'Salary Band', 'Lower Income', COUNT(*),
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END),
    ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2)
FROM employees
WHERE MonthlyIncome < 5000

UNION ALL

SELECT
    'Business Travel', 'Travel Frequently', COUNT(*),
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END),
    ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2)
FROM employees
WHERE BusinessTravel = 'Travel_Frequently'

UNION ALL

SELECT
    'Job Satisfaction', 'Level 1', COUNT(*),
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END),
    ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2)
FROM employees
WHERE JobSatisfaction = 1

UNION ALL

SELECT
    'Department', 'Sales', COUNT(*),
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END),
    ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2)
FROM employees
WHERE Department = 'Sales';
