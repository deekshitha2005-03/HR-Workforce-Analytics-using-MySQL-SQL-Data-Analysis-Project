use hr_workforce_analytics;
/*Data Cleaning*/
/*Duplicate values */
select count(*) as duplicate_count
from hr_employee_attrition
group  by Age, Attrition, BusinessTravel, DailyRate, Department,
DistanceFromHome, Education, EducationField,
EmployeeCount, EmployeeNumber, EnvironmentSatisfaction,
Gender, HourlyRate, JobInvolvement, JobLevel,
JobRole, JobSatisfaction, MaritalStatus,
MonthlyIncome, MonthlyRate, NumCompaniesWorked,
Over18, OverTime, PercentSalaryHike,
PerformanceRating, RelationshipSatisfaction,
StandardHours, StockOptionLevel,
TotalWorkingYears, TrainingTimesLastYear,
WorkLifeBalance, YearsAtCompany,
YearsInCurrentRole, YearsSinceLastPromotion,
YearsWithCurrManager having count(*)>1;
/*Missing Values */
select SUM(Age IS NULL) AS Age,
SUM(Gender IS NULL) AS Gender,
SUM(Department IS NULL) AS Department,
SUM(JobRole IS NULL) AS JobRole,
SUM(MonthlyIncome IS NULL) AS MonthlyIncome,
SUM(Attrition IS NULL) AS Attrition
FROM hr_employee_attrition;
/*Blank text Values */
SELECT
SUM(TRIM(Department)='') AS Blank_Department,
SUM(TRIM(JobRole)='') AS Blank_JobRole,
SUM(TRIM(Gender)='') AS Blank_Gender
FROM hr_employee_attrition;
/*Overtime Values */
select distinct OverTime from hr_employee_attrition;
/*Negative Values */
select * from hr_employee_attrition
where 
Age < 0
or MonthlyIncome < 0
or YearsAtCompany < 0
or TotalWorkingYears < 0;
/*Employee Count */
select distinct EmployeeCount from hr_employee_attrition;