-- HR Workforce Intelligence & Attrition Analytics
-- SQL transcribed from the final project documentation PDF.
-- Review and test each statement in MySQL Workbench before committing.
-- The PDF does not include every query used in every analysis subsection.
-- No missing query has been invented in this extraction.

USE hr_analytics;

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

