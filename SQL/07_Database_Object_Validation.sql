-- HR Workforce Intelligence & Attrition Analytics
-- SQL transcribed from the final project documentation PDF.
-- Review and test each statement in MySQL Workbench before committing.
-- The PDF does not include every query used in every analysis subsection.
-- No missing query has been invented in this extraction.

USE hr_analytics;

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

