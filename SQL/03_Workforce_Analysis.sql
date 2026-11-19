-- HR Workforce Intelligence & Attrition Analytics
-- SQL transcribed from the final project documentation PDF.
-- Review and test each statement in MySQL Workbench before committing.
-- The PDF does not include every query used in every analysis subsection.
-- No missing query has been invented in this extraction.

USE hr_analytics;

-- Source: PDF page 17
SELECT COUNT(*) AS Total_Employees, 
     SUM(CASE WHEN Attrition = 'No' THEN 1 ELSE 0 END) AS Active_Employees, 
     SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Exited_Employees, 
     ROUND( SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2 ) AS                     
Overall_Attrition_Rate  
FROM employees;

-- Source: PDF page 18
SELECT JobRole,COUNT(*) AS Total_Employees, 
ROUND( COUNT(*) * 100.0 /  
(SELECT COUNT(*) FROM employees), 2) AS Workforce_Percentage 
FROM employees  
GROUP BY JobRole  
ORDER BY Total_Employees DESC;

-- Source: PDF page 19
SELECT CASE     
WHEN Age < 25 THEN 'Under 25'    
WHEN Age BETWEEN 25 AND 34 THEN '25-34'    
WHEN Age BETWEEN 35 AND 44 THEN '35-44'     
WHEN Age BETWEEN 45 AND 54 THEN '45-54'   
ELSE '55+'END AS Age_Group, 
COUNT(*) AS Total_Employees,ROUND(COUNT(*) * 100.0 /  
(SELECT COUNT(*)  
FROM employees), 2)    AS Workforce_Percentage 
FROM employees 
GROUP BY Age_Group  
ORDER BY MIN(Age);

-- Source: PDF page 20
SELECT Gender, 
COUNT(*) AS Total_Employees, 
ROUND(    COUNT(*) * 100.0 /  
(SELECT COUNT(*)  

FROM employees),    2) AS Workforce_Percentage 
FROM employees  
GROUP BY Gender  
ORDER BY Total_Employees DESC;

-- Source: PDF page 22
SELECT EducationField, 
COUNT(*) AS Total_Employees, 
ROUND(COUNT(*) * 100.0 /  
(SELECT COUNT(*) 
FROM employees), 2) AS Workforce_Percentage 
FROM employees  
GROUP BY EducationField  
ORDER BY Total_Employees DESC;

-- Source: PDF page 24
SELECT CASE     
WHEN YearsAtCompany BETWEEN 0 AND 2 THEN '0-2 Years'     
WHEN YearsAtCompany BETWEEN 3 AND 5 THEN '3-5 Years'     
WHEN YearsAtCompany BETWEEN 6 AND 10 THEN '6-10 Years'     
WHEN YearsAtCompany BETWEEN 11 AND 15 THEN '11-15 Years'     
ELSE 'Above 15 Years'END AS Tenure_Group,COUNT(*) AS Total_Employees, 
ROUND(    COUNT(*) * 100.0 /  
(SELECT COUNT(*)  
FROM employees), 2) AS Workforce_Percentage 
FROM employees  
GROUP BY Tenure_Group  
ORDER BY MIN(YearsAtCompany);

-- Source: PDF page 25
SELECT CASE     
WHEN MonthlyIncome < 5000 THEN 'Lower'     
WHEN MonthlyIncome BETWEEN 5000 AND 9999 THEN 'Lower-Middle'     
WHEN MonthlyIncome BETWEEN 10000 AND 14999 THEN 'Upper-Middle'     
ELSE 'Higher' END AS Income_Group,COUNT(*) AS Total_Employees, 
ROUND(COUNT(*) * 100.0 /  
(SELECT COUNT(*)  
FROM employees), 2) AS Workforce_Percentage 
FROM employees  
GROUP BY Income_Group  
ORDER BY MIN(MonthlyIncome);

