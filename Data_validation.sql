use hr_workforce_analytics;
/*Data Validation*/
/*Total Records */
select count(*) as Total_Records
from hr_employee_attrition;
 /*Total Columns */
SELECT COUNT(*) AS Total_Columns
FROM information_schema.columns
WHERE table_schema='hr_workforce_analytics'
AND table_name='hr_employee_attrition';
/*Check Duplicate EmployeeNumber */
select   EmployeeNumber, count(*) as Duplicate_Count
from hr_employee_attrition
Group by EmployeeNumber
having count(*)>1;
/*Check Null Values */
SELECT
SUM(Age IS NULL) AS Age_Nulls,
SUM(Gender IS NULL) AS Gender_Nulls,
SUM(Department IS NULL) AS Department_Nulls,
SUM(MonthlyIncome IS NULL) AS Salary_Nulls,
SUM(Attrition IS NULL) AS Attrition_Nulls
FROM hr_employee_attrition;
/*Age Range */
select MIN(Age) as Minimum_age , MAX(Age) as Maximum_age
from hr_employee_attrition;
/*Salary Range*/
select MIN(MonthlyIncome) as lowest_salary , MAX(MonthlyIncome) as highest_salary
from hr_employee_attrition;
/*Unique Departments*/
select distinct Department from hr_employee_attrition;
/*Unique Attrition*/
select distinct Attrition from hr_employee_attrition;
/*Gender Distribution*/
select count(*) as count , Gender 
from hr_employee_attrition
Group by Gender;
/*Department Distribution*/
select count(*) as count , Department
from hr_employee_attrition
Group by Department;
