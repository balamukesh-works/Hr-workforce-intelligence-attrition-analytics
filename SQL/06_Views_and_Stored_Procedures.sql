-- HR Workforce Intelligence & Attrition Analytics
-- SQL transcribed from the final project documentation PDF.
-- Review and test each statement in MySQL Workbench before committing.
-- The PDF does not include every query used in every analysis subsection.
-- No missing query has been invented in this extraction.

USE hr_analytics;

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

