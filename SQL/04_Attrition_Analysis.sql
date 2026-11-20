
-- HR Workforce Intelligence & Attrition Analytics
-- SQL transcribed from the final project documentation PDF.
-- Review and test each statement in MySQL Workbench before committing.
-- The PDF does not include every query used in every analysis subsection.
-- No missing query has been invented in this extraction.

USE hr_analytics;


-- ============================================================
-- SECTION 1: AGE GROUP-WISE ATTRITION ANALYSIS
-- Documentation Reference: PDF Page 27
-- ============================================================

-- Source: PDF page 27
SELECT CASE  
        WHEN Age < 25 THEN 'Under 25' 
        WHEN Age BETWEEN 25 AND 34 THEN '25-34' 
        WHEN Age BETWEEN 35 AND 44 THEN '35-44' 
        WHEN Age BETWEEN 45 AND 54 THEN '45-54' 
        ELSE '55+' 
    END AS Age_Group, 
    COUNT(*) AS Total_Employees, 
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Exited_Employees, 
    ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS  Attrition_Rate 
FROM employees 
GROUP BY Age_Group 
ORDER BY 
    CASE Age_Group 
        WHEN 'Under 25' THEN 1 
        WHEN '25-34' THEN 2 
        WHEN '35-44' THEN 3 
        WHEN '45-54' THEN 4 
        WHEN '55+' THEN 5 
    END;


-- ============================================================
-- SECTION 2: DEPARTMENT-WISE ATTRITION ANALYSIS
-- Documentation Reference: PDF Page 28
-- ============================================================

-- Source: PDF page 28
SELECT Department, 
    COUNT(*) AS Total_Employees, 
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Exited_Employees, 
    ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0/  
    COUNT(*),2) AS Attrition_Rate 
FROM employees 
GROUP BY Department 
ORDER BY Attrition_Rate DESC;


-- ============================================================
-- SECTION 3: JOB ROLE-WISE ATTRITION ANALYSIS
-- Documentation Reference: PDF Page 29
-- ============================================================

-- Source: PDF page 29
SELECT JobRole,COUNT(*) AS Total_Employees, 
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Exited_Employees, 
    ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0/ 
    COUNT(*),2) AS Attrition_Rate 
FROM employees 
GROUP BY JobRole 
ORDER BY Attrition_Rate DESC;


-- ============================================================
-- SECTION 4: OVERTIME-WISE ATTRITION ANALYSIS
-- Documentation Reference: PDF Page 30
-- ============================================================

-- Source: PDF page 30
SELECT OverTime,COUNT(*) AS Total_Employees, 
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Exited_Employees, 
    ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0/ 
    COUNT(*),2) AS Attrition_Rate 
FROM employees 
GROUP BY OverTime 
ORDER BY Attrition_Rate DESC;


-- ============================================================
-- SECTION 5: JOB SATISFACTION-WISE ATTRITION ANALYSIS
-- Documentation Reference: PDF Page 32
-- ============================================================

-- Source: PDF page 32
SELECT 
    JobSatisfaction, COUNT(*) AS Total_Employees, 
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Exited_Employees, 
    ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0/ 
    COUNT(*),2) AS Attrition_Rate 
FROM employees 
GROUP BY JobSatisfaction 
ORDER BY JobSatisfaction;


-- ============================================================
-- SECTION 6: YEARS AT COMPANY-WISE ATTRITION ANALYSIS
-- Documentation Reference: PDF Page 34
-- ============================================================

-- Source: PDF page 34
SELECT 
    CASE 
        WHEN YearsAtCompany BETWEEN 0 AND 2 THEN '0-2 Years' 
        WHEN YearsAtCompany BETWEEN 3 AND 5 THEN '3-5 Years' 
        WHEN YearsAtCompany BETWEEN 6 AND 10 THEN '6-10 Years' 
        WHEN YearsAtCompany BETWEEN 11 AND 15 THEN '11-15 Years' 
        ELSE 'Above 15 Years' 
    END AS Tenure_Group, 
    COUNT(*) AS Total_Employees, 
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Exited_Employees, 
    ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0/ 
    COUNT(*),2) AS Attrition_Rate 
FROM employees 
GROUP BY Tenure_Group 
ORDER BY MIN(YearsAtCompany);


-- ============================================================
-- SECTION 7: YEARS WITH CURRENT MANAGER-WISE ATTRITION ANALYSIS
-- Documentation Reference: PDF Page 36
-- ============================================================

-- Source: PDF page 36
SELECT 
    CASE 
        WHEN YearsWithCurrManager BETWEEN 0 AND 2 THEN '0-2 Years' 
        WHEN YearsWithCurrManager BETWEEN 3 AND 5 THEN '3-5 Years' 
        WHEN YearsWithCurrManager BETWEEN 6 AND 10 THEN '6-10 Years' 
        WHEN YearsWithCurrManager BETWEEN 11 AND 15 THEN '11-15 Years' 
        ELSE 'Above 15 Years' 
    END AS Manager_Tenure_Group, 
    COUNT(*) AS Total_Employees, 
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Exited_Employees, 
    ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0/ 
    COUNT(*),2) AS Attrition_Rate 
FROM employees 
GROUP BY Manager_Tenure_Group 
ORDER BY MIN(YearsWithCurrManager);


-- ============================================================
-- SECTION 8: SALARY BAND-WISE ATTRITION ANALYSIS
-- Documentation Reference: PDF Page 38
-- ============================================================

-- Source: PDF page 38
SELECT 
    CASE 
        WHEN MonthlyIncome < 5000 THEN 'Lower' 
        WHEN MonthlyIncome BETWEEN 5000 AND 9999 THEN 'Lower-Middle' 
        WHEN MonthlyIncome BETWEEN 10000 AND 14999 THEN 'Upper-Middle' 
        ELSE 'Higher' 
    END AS Salary_Band,COUNT(*) AS Total_Employees, 
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Exited_Employees, 
    ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0/ 
    COUNT(*),2) AS Attrition_Rate 
FROM employees 
GROUP BY Salary_Band 
ORDER BY MIN(MonthlyIncome);


-- ============================================================
-- SECTION 9: DEPARTMENT-WISE SALARY ANALYSIS
-- Documentation Reference: PDF Page 41
-- ============================================================

-- Source: PDF page 41
SELECT  Department,  Total_Employees, Average_Monthly_Income,Minimum_Income,   
Maximum_Income 
FROM ( 
    SELECT Department, COUNT(*) AS Total_Employees, ROUND(AVG(MonthlyIncome), 2)  
     AS Average_Monthly_Income, 
     MIN(MonthlyIncome) AS Minimum_Income, 
     MAX(MonthlyIncome) AS Maximum_Income, 
        CASE Department 
            WHEN 'Sales' THEN 1 
            WHEN 'Human Resources' THEN 2 
            WHEN 'Research & Development' THEN 3 
        END AS Sort_Order 
    FROM employees 
    GROUP BY Department 
    UNION ALL 
    SELECT 'Total', COUNT(*),ROUND(AVG(MonthlyIncome), 2), MIN(MonthlyIncome), 
        MAX(MonthlyIncome), 4 
    FROM employees) AS Department_Summary 
ORDER BY Sort_Order;


-- ============================================================
-- SECTION 10: JOB LEVEL AND SALARY BAND-WISE ATTRITION ANALYSIS
-- Documentation Reference: PDF Page 43
-- ============================================================

-- Source: PDF page 43
SELECT Job_Level, Salary_Band, Total_Employees, Exited_Employees, Attrition_Rate 
 FROM 
( SELECT JobLevel AS Job_Level, 
CASE WHEN MonthlyIncome <= 4000 THEN 'Lower Income'  
WHEN MonthlyIncome <= 8000 THEN 'Lower-Middle Income' 
WHEN MonthlyIncome <= 12000 THEN 'Upper-Middle Income' ELSE 'Higher Income' 
END AS Salary_Band, COUNT(*) AS Total_Employees, 

    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Exited_Employees,  
    ROUND( SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 /  
    COUNT(*), 2 ) AS Attrition_Rate 
FROM employees 
GROUP BY JobLevel,Salary_Band 
UNION ALL 
     SELECT NULL, 'Total', COUNT(*), 
 
SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END), 
     
ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),2) 
 
FROM employees) AS Salary_Band_Analysis ;
