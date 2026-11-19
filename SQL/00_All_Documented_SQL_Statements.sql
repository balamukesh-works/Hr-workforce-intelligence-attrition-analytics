-- HR Workforce Intelligence & Attrition Analytics
-- SQL transcribed from the final project documentation PDF.
-- Review and test each statement in MySQL Workbench before committing.
-- The PDF does not include every query used in every analysis subsection.
-- No missing query has been invented in this extraction.

USE hr_analytics;

-- Source: PDF page 7
DESCRIBE employees;

-- Source: PDF page 9
DESCRIBE employee_hire_details;

-- Source: PDF page 9
DESCRIBE employee_exit_details;

-- Source: PDF page 10
SELECT COUNT(*) AS Total_Records, 
    SUM(Age IS NULL) AS Age_Null, 
    SUM(Attrition IS NULL) AS Attrition_Null, 
    SUM(BusinessTravel IS NULL) AS BusinessTravel_Null, 
    SUM(DailyRate IS NULL) AS DailyRate_Null, 
    SUM(Department IS NULL) AS Department_Null, 
    SUM(DistanceFromHome IS NULL) AS DistanceFromHome_Null, 
    SUM(Education IS NULL) AS Education_Null, 
    SUM(EducationField IS NULL) AS EducationField_Null, 

    SUM(EmployeeCount IS NULL) AS EmployeeCount_Null, 
    SUM(EmployeeNumber IS NULL) AS EmployeeNumber_Null, 
    SUM(EnvironmentSatisfaction IS NULL) AS EnvironmentSatisfaction_Null, 
    SUM(Gender IS NULL) AS Gender_Null, 
    SUM(HourlyRate IS NULL) AS HourlyRate_Null, 
    SUM(JobInvolvement IS NULL) AS JobInvolvement_Null, 
    SUM(JobLevel IS NULL) AS JobLevel_Null, 
    SUM(JobRole IS NULL) AS JobRole_Null, 
    SUM(JobSatisfaction IS NULL) AS JobSatisfaction_Null, 
    SUM(MaritalStatus IS NULL) AS MaritalStatus_Null, 
    SUM(MonthlyIncome IS NULL) AS MonthlyIncome_Null, 
    SUM(MonthlyRate IS NULL) AS MonthlyRate_Null, 
    SUM(NumCompaniesWorked IS NULL) AS NumCompaniesWorked_Null, 
    SUM(Over18 IS NULL) AS Over18_Null, 
    SUM(OverTime IS NULL) AS OverTime_Null, 
    SUM(PercentSalaryHike IS NULL) AS PercentSalaryHike_Null, 
    SUM(PerformanceRating IS NULL) AS PerformanceRating_Null, 
    SUM(RelationshipSatisfaction IS NULL) AS RelationshipSatisfaction_Null, 
    SUM(StandardHours IS NULL) AS StandardHours_Null, 
    SUM(StockOptionLevel IS NULL) AS StockOptionLevel_Null, 
    SUM(TotalWorkingYears IS NULL) AS TotalWorkingYears_Null, 
    SUM(TrainingTimesLastYear IS NULL) AS TrainingTimesLastYear_Null, 
    SUM(WorkLifeBalance IS NULL) AS WorkLifeBalance_Null, 
    SUM(YearsAtCompany IS NULL) AS YearsAtCompany_Null, 
    SUM(YearsInCurrentRole IS NULL) AS YearsInCurrentRole_Null, 
    SUM(YearsSinceLastPromotion IS NULL) AS YearsSinceLastPromotion_Null, 
    SUM(YearsWithCurrManager IS NULL) AS YearsWithCurrManager_Null 
 FROM employees;

-- Source: PDF page 12
SELECT COUNT(*) AS Duplicate_Groups 
FROM ( 
    SELECT * 
    FROM employees 
    GROUP BY  Age, Attrition, BusinessTravel, DailyRate, Department, 
        DistanceFromHome, Education, EducationField, EmployeeCount, 
        EmployeeNumber, EnvironmentSatisfaction, Gender, HourlyRate, 
        JobInvolvement, JobLevel, JobRole, JobSatisfaction, 
        MaritalStatus, MonthlyIncome, MonthlyRate, NumCompaniesWorked, 
        Over18, OverTime, PercentSalaryHike, PerformanceRating, 
        RelationshipSatisfaction, StandardHours, StockOptionLevel, 
        TotalWorkingYears, TrainingTimesLastYear, WorkLifeBalance, 
        YearsAtCompany, YearsInCurrentRole, YearsSinceLastPromotion, 
        YearsWithCurrManager 
    HAVING COUNT(*) > 1) AS Duplicate_Records;

-- Source: PDF page 13
SELECT 
    SUM(CASE WHEN PerformanceRating NOT BETWEEN 3 AND 4 
        THEN 1 ELSE 0 END) AS Invalid_PerformanceRating, 

    SUM(CASE WHEN RelationshipSatisfaction NOT BETWEEN 1 AND 4 
        THEN 1 ELSE 0 END) AS Invalid_RelationshipSatisfaction, 
    SUM(CASE WHEN WorkLifeBalance NOT BETWEEN 1 AND 4 
        THEN 1 ELSE 0 END) AS Invalid_WorkLifeBalance, 
    SUM(CASE WHEN StockOptionLevel NOT BETWEEN 0 AND 3 
        THEN 1 ELSE 0 END) AS Invalid_StockOptionLevel 
FROM employees;

-- Source: PDF page 15
SELECT 
    COUNT(*) AS Total_Records, 
    COUNT(DISTINCT EmployeeCount) AS EmployeeCount_Distinct_Values, 
    COUNT(DISTINCT StandardHours) AS StandardHours_Distinct_Values, 
    MIN(EmployeeCount) AS EmployeeCount_Value, 
    MIN(StandardHours) AS StandardHours_Value 
FROM employees;

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

-- Source: PDF page 28
SELECT Department, 
    COUNT(*) AS Total_Employees, 
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Exited_Employees, 
    ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0/  
    COUNT(*),2) AS Attrition_Rate 
FROM employees 
GROUP BY Department 
ORDER BY Attrition_Rate DESC;

-- Source: PDF page 29
SELECT JobRole,COUNT(*) AS Total_Employees, 
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Exited_Employees, 
    ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0/ 
    COUNT(*),2) AS Attrition_Rate 
FROM employees 
GROUP BY JobRole 
ORDER BY Attrition_Rate DESC;

-- Source: PDF page 30
SELECT OverTime,COUNT(*) AS Total_Employees, 
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Exited_Employees, 
    ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0/ 
    COUNT(*),2) AS Attrition_Rate 
FROM employees 
GROUP BY OverTime 
ORDER BY Attrition_Rate DESC;

-- Source: PDF page 32
SELECT 
    JobSatisfaction, COUNT(*) AS Total_Employees, 
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Exited_Employees, 
    ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0/ 
    COUNT(*),2) AS Attrition_Rate 
FROM employees 
GROUP BY JobSatisfaction 
ORDER BY JobSatisfaction;

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

-- Source: PDF page 46
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

-- Source: PDF page 47
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

-- Source: PDF page 49
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

-- Source: PDF page 50
SELECT ExitReason,COUNT(*) AS Exited_Employees, 
 
ROUND(COUNT(*) * 100.0 /  
SUM(COUNT(*)) OVER (), 2) AS Exit_Percentage 
FROM employee_exit_details  
 GROUP BY ExitReason 
ORDER BY Exited_Employees DESC;

-- Source: PDF page 53
CREATE VIEW vw_workforce_summary AS 
SELECT COUNT(*) AS Total_Employees, 
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Exited_Employees, 
    SUM(CASE WHEN Attrition = 'No' THEN 1 ELSE 0 END) AS Active_Employees, 
    ROUND( SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2 ) AS 
Overall_Attrition_Rate 
FROM employees;

-- Source: PDF page 53
SELECT * FROM vw_workforce_summary;

-- Source: PDF page 54
CREATE VIEW vw_department_attrition AS 
SELECT Department,COUNT(*) AS Total_Employees, 
     SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Exited_Employees, 
     SUM(CASE WHEN Attrition = 'No' THEN 1 ELSE 0 END) AS Active_Employees, 
     ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)* 100.0 /                                                 
COUNT(*),2)     AS Attrition_Rate 
FROM employees 
GROUP BY Department;

-- Source: PDF page 54
SELECT * FROM vw_department_attrition;

-- Source: PDF page 55
CREATE VIEW vw_employee_segmentation AS 
 SELECT EmployeeNumber,Department,JobRole,Attrition, ( 
     CASE WHEN OverTime = 'Yes' THEN 1 ELSE 0 END + 
     CASE WHEN YearsAtCompany <= 2 THEN 1 ELSE 0 END + 
     CASE WHEN JobSatisfaction <= 2 THEN 1 ELSE 0 END + 
     CASE WHEN WorkLifeBalance = 1 THEN 1 ELSE 0 END + 
     CASE WHEN BusinessTravel = 'Travel_Frequently' THEN 1 ELSE 0 END) 
     AS Indicator_Score, 
    CASE 
    WHEN ( 
        CASE WHEN OverTime = 'Yes' THEN 1 ELSE 0 END + 

        CASE WHEN YearsAtCompany <= 2 THEN 1 ELSE 0 END + 
        CASE WHEN JobSatisfaction <= 2 THEN 1 ELSE 0 END + 
        CASE WHEN WorkLifeBalance = 1 THEN 1 ELSE 0 END + 
        CASE WHEN BusinessTravel = 'Travel_Frequently' THEN 1 ELSE 0 END 
        ) = 0 THEN 'Low Indicators' 
    WHEN ( 
        CASE WHEN OverTime = 'Yes' THEN 1 ELSE 0 END + 
        CASE WHEN YearsAtCompany <= 2 THEN 1 ELSE 0 END + 
        CASE WHEN JobSatisfaction <= 2 THEN 1 ELSE 0 END + 
        CASE WHEN WorkLifeBalance = 1 THEN 1 ELSE 0 END + 
        CASE WHEN BusinessTravel = 'Travel_Frequently' THEN 1 ELSE 0 END 
        ) = 1 THEN 'Moderate Indicators' 
        ELSE 'Multiple Indicators' 
    END AS Employee_Segment 
FROM employees;

-- Source: PDF page 56
SELECT * 
FROM vw_employee_segmentation;

-- Source: PDF page 56
SELECT Employee_Segment,COUNT(*) AS Total_Employees, 
SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Exited_Employees, 
ROUND(    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 /  
COUNT(*), 2) AS Attrition_Rate 
FROM vw_employee_segmentation GROUP BY Employee_Segment;

-- Source: PDF page 57
DELIMITER // 
 
CREATE PROCEDURE sp_workforce_summary() 
BEGIN 
SELECT COUNT(*) AS Total_Employees, 
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Exited_Employees, 
    SUM(CASE WHEN Attrition = 'No' THEN 1 ELSE 0 END) AS Active_Employees, 
    ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / 
    COUNT(*),2) AS Overall_Attrition_Rate 
FROM employees; 
END // 

DELIMITER ;

-- Source: PDF page 58
CALL sp_workforce_summary();

-- Source: PDF page 59
DELIMITER // 
 
CREATE PROCEDURE sp_department_attrition(IN p_department VARCHAR(100)) 
BEGIN 
    SELECT Department,COUNT(*) AS Total_Employees, 
      SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Exited_Employees, 
      SUM(CASE WHEN Attrition = 'No' THEN 1 ELSE 0 END) AS Active_Employees, 
      ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 /                                 
COUNT(*),2) AS Attrition_Rate 
    FROM employees 
    WHERE Department = p_department 
    GROUP BY Department; 
END // 
 
DELIMITER ;

-- Source: PDF page 59
CALL sp_department_attrition('Sales');

-- Source: PDF page 59
CALL sp_department_attrition('Human Resources');

-- Source: PDF page 59
CALL sp_department_attrition('Research & Development');

-- Source: PDF page 62
SELECT TABLE_NAME,TABLE_TYPE 
FROM INFORMATION_SCHEMA.TABLES 
WHERE TABLE_SCHEMA = 'hr_analytics' 
ORDER BY TABLE_TYPE, TABLE_NAME;

-- Source: PDF page 62
SELECT ROUTINE_NAME,ROUTINE_TYPE 
FROM INFORMATION_SCHEMA.ROUTINES 
WHERE ROUTINE_SCHEMA = 'hr_analytics' AND ROUTINE_TYPE = 'PROCEDURE' 
ORDER BY ROUTINE_NAME;

-- Source: PDF page 63
SELECT 'employees' AS Table_Name,COUNT(*) AS Total_Records 
FROM employees 
 
UNION ALL 
SELECT 'employee_hire_details',COUNT(*) 
FROM employee_hire_details 
 
UNION ALL 
SELECT 'employee_exit_details',COUNT(*) 
FROM employee_exit_details;

-- Source: PDF page 64
SELECT table_name,column_name,constraint_name 
FROM information_schema.key_column_usage 
WHERE table_schema = 'hr_analytics' AND constraint_name = 'PRIMARY' 
ORDER BY table_name;

-- Source: PDF page 64
SHOW INDEX FROM employees;

-- Source: PDF page 65
SELECT table_name,column_name,constraint_name,referenced_table_name, 
    referenced_column_name 
FROM information_schema.key_column_usage 
WHERE table_schema = 'hr_analytics' AND referenced_table_name IS NOT NULL 
ORDER BY table_name;

-- Source: PDF page 66
SELECT 'Hire records without matching employees' AS Validation_Check, 
 
COUNT(*) AS Issue_Count 
FROM employee_hire_details h LEFT JOIN employees e  
ON h.EmployeeNumber = e.EmployeeNumber 
WHERE e.EmployeeNumber IS NULL 
 
UNION ALL 
SELECT 'Exit records without matching employees',COUNT(*) 
FROM employee_exit_details x 
LEFT JOIN employees e 
ON x.EmployeeNumber = e.EmployeeNumber 
WHERE e.EmployeeNumber IS NULL 
 
UNION ALL 
SELECT 'Exit records for employees not marked as exited',COUNT(*) 
FROM employee_exit_details x 
JOIN employees e  
ON x.EmployeeNumber = e.EmployeeNumber 
WHERE e.Attrition <> 'Yes' OR e.Attrition IS NULL 
 
UNION ALL 
SELECT 'Exited employees without exit records',COUNT(*) 
FROM employees e 
LEFT JOIN employee_exit_details x  
ON e.EmployeeNumber = x.EmployeeNumber 
WHERE e.Attrition = 'Yes' AND x.EmployeeNumber IS NULL 
 
UNION ALL 
SELECT 'Active employees with exit records',COUNT(*) 
FROM employees e 
JOIN employee_exit_details x  
ON e.EmployeeNumber = x.EmployeeNumber 
WHERE e.Attrition = 'No';

-- Source: PDF page 67
SELECT * FROM vw_employee_segmentation 
LIMIT 10;

-- Source: PDF page 67
SELECT Employee_Segment,COUNT(*) AS Total_Employees, 
SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Exited_Employees, 
ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 /  
COUNT(*), 2) AS Attrition_Rate 
FROM vw_employee_segmentation GROUP BY Employee_Segment;

-- Source: PDF page 73
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

-- Source: PDF page 75
WITH Employee_Indicators AS  
   ( SELECT  EmployeeNumber, Attrition,  
(CASE WHEN OverTime = 'Yes' THEN 1 ELSE 0 END) +     
(CASE WHEN YearsAtCompany <= 2 THEN 1 ELSE 0 END) +     
(CASE WHEN JobSatisfaction <= 2 THEN 1 ELSE 0 END) +     
(CASE WHEN WorkLifeBalance = 1 THEN 1 ELSE 0 END) +     
(CASE WHEN BusinessTravel = 'Travel_Frequently' THEN 1 ELSE 0 END)    AS Indicator_Score 
FROM employees) 
SELECT 'Job Role' AS Attrition_Dimension,'Sales Representative' AS Employee_Group, 
COUNT(*) AS Total_Employees, 
SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Exited_Employees, 
ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 /  
COUNT(*), 2) AS Attrition_Rate 
FROM employees  
WHERE JobRole = 'Sales Representative' 
       UNION ALL 
SELECT 'Work-Life Balance','Level 1',COUNT(*), 
SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END), 
ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) 
FROM employees  
WHERE WorkLifeBalance = 1 
       UNION ALL 
SELECT 'Risk Segmentation','Multiple Indicators',COUNT(*), 
SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END), 
ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) 
FROM Employee_Indicators  
WHERE Indicator_Score >= 2 
       UNION ALL 
SELECT 'Overtime','Yes',COUNT(*), 
SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END), 
ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) 
FROM employees  
WHERE OverTime = 'Yes' 
       UNION ALL 
SELECT 'Company Tenure','0-2 Years',COUNT(*), 
SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END), 
ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) 
FROM employees  
WHERE YearsAtCompany BETWEEN 0 AND 2 
       UNION ALL 
SELECT 'Salary Band','Lower Income',COUNT(*), 
SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END), 
ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) 
FROM employees  
WHERE MonthlyIncome < 5000 
       UNION ALL 
SELECT 'Business Travel','Travel Frequently',COUNT(*), 
SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END), 
ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) 

FROM employees  
WHERE BusinessTravel = 'Travel_Frequently' 
       UNION ALL 
SELECT 'Job Satisfaction','Level 1',COUNT(*), 
SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END), 
ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) 
FROM employees  
WHERE JobSatisfaction = 1 
       UNION ALL 
SELECT 'Department','Sales',COUNT(*), 
SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END), 
ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) 
FROM employees  
WHERE Department = 'Sales';

