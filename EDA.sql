use hr_workforce_analytics;
/*Workforce Overview*/
/*Total Employess*/
Select count(*) as Total_Employees
from hr_employee_attrition;
/*Employees by Department, Gender, MaritalStatus, EducationField, Jobrole*/
Select count(*) as Employee_Count, Department
from hr_employee_attrition
group by Department
order by Employee_Count Desc;
Select count(*) as Employee_Count, Gender
from hr_employee_attrition
group by Gender
order by Employee_Count Desc;
Select count(*) as Employee_Count, MaritalStatus
from hr_employee_attrition
group by MaritalStatus
order by Employee_Count Desc;
Select count(*) as Employee_Count, EducationField
from hr_employee_attrition
group by EducationField
order by Employee_Count Desc;
Select count(*) as Employee_Count, JobRole
from hr_employee_attrition
group by JobRole
order by Employee_Count Desc;
/*Average Age, MonthlyIncome*/
select round(Avg(Age),2) as Average_Age from hr_employee_attrition;
select round(avg(MonthlyIncome),2) as Average_salary from hr_employee_attrition;
/*Department wise Avg Age , Avg Salary*/
select round(Avg(Age),2) as Average_Age , Department 
from hr_employee_attrition
Group by Department
Order by Average_Age Desc;
select round(avg(MonthlyIncome),2) as Average_salary , Department 
from hr_employee_attrition
Group by Department
Order by Average_salary Desc;
/*Attrition Count*/
Select count(*) as Employee_count, Attrition
from hr_employee_attrition
Group by Attrition;
/*Attrition Analysis */
/*Overall Attrition Rate*/
select count(*) as Total_Employees,
Sum(Case When Attrition = 'Yes' Then 1 Else 0 End) as Employee_Left,
Round(Sum(Case When Attrition = 'Yes' Then 1 Else 0 End)*100.0/count(*),2) as Overall_Attrition_Rate
From hr_employee_attrition;
/*Department with highest attrition*/
select count(*) as Total_Employees, Department,
Sum(Case When Attrition = 'Yes' Then 1 Else 0 End) as Employee_Left,
Round(Sum(Case When Attrition = 'Yes' Then 1 Else 0 End)*100.0/count(*),2) as Overall_Attrition_Rate
From hr_employee_attrition
Group by Department
Order by Overall_Attrition_Rate Desc;
/*Jobrole with highest attrition*/
select count(*) as Total_Employees, JobRole,
Sum(Case When Attrition = 'Yes' Then 1 Else 0 End) as Employee_Left,
Round(Sum(Case When Attrition = 'Yes' Then 1 Else 0 End)*100.0/count(*),2) as Overall_Attrition_Rate
From hr_employee_attrition
Group by JobRole
Order by Overall_Attrition_Rate Desc;
/*OverTime increase Attrition??*/
select count(*) as Total_Employees, OverTime,
Sum(Case When Attrition = 'Yes' Then 1 Else 0 End) as Employee_Left,
Round(Sum(Case When Attrition = 'Yes' Then 1 Else 0 End)*100.0/count(*),2) as Overall_Attrition_Rate
From hr_employee_attrition
Group by OverTime;
/*Attrition by Gender, MaritalStatus, Agegroup, EducationField, Joblevel*/
select count(*) as Total_Employees, Gender,
Sum(Case When Attrition = 'Yes' Then 1 Else 0 End) as Employee_Left,
Round(Sum(Case When Attrition = 'Yes' Then 1 Else 0 End)*100.0/count(*),2) as Overall_Attrition_Rate
From hr_employee_attrition
Group by Gender;
select count(*) as Total_Employees, MaritalStatus,
Sum(Case When Attrition = 'Yes' Then 1 Else 0 End) as Employee_Left,
Round(Sum(Case When Attrition = 'Yes' Then 1 Else 0 End)*100.0/count(*),2) as Overall_Attrition_Rate
From hr_employee_attrition
Group by MaritalStatus
Order by Overall_Attrition_Rate Desc;
select count(*) as Total_Employees, EducationField,
Sum(Case When Attrition = 'Yes' Then 1 Else 0 End) as Employee_Left,
Round(Sum(Case When Attrition = 'Yes' Then 1 Else 0 End)*100.0/count(*),2) as Overall_Attrition_Rate
From hr_employee_attrition
Group by EducationField
Order by Overall_Attrition_Rate Desc;
select count(*) as Total_Employees, JobLevel,
Sum(Case When Attrition = 'Yes' Then 1 Else 0 End) as Employee_Left,
Round(Sum(Case When Attrition = 'Yes' Then 1 Else 0 End)*100.0/count(*),2) as Overall_Attrition_Rate
From hr_employee_attrition
Group by JobLevel
Order by Overall_Attrition_Rate Desc;
SELECT
CASE
    WHEN Age BETWEEN 18 AND 25 THEN '18-25'
    WHEN Age BETWEEN 26 AND 35 THEN '26-35'
    WHEN Age BETWEEN 36 AND 45 THEN '36-45'
    WHEN Age BETWEEN 46 AND 55 THEN '46-55'
    ELSE '56-60'
END AS Age_Group,
COUNT(*) AS Total_Employees,
SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS Employees_Left,
ROUND(
SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)*100.0/COUNT(*),
2
) AS Attrition_Rate
FROM hr_employee_attrition
GROUP BY Age_Group
ORDER BY Age_Group;
/*Top 10 employees with highest monthlyincome who left*/
Select EmployeeNumber, JobRole, Department, MonthlyIncome From hr_employee_attrition
where Attrition = 'Yes'
Order by MonthlyIncome Desc
Limit 10;
/*Attrition by Department and Overtime*/
select Department, OverTime, count(*) as Total_Employees,
Sum(Case When Attrition = 'Yes' Then 1 Else 0 End) as Employee_Left,
Round(Sum(Case When Attrition = 'Yes' Then 1 Else 0 End)*100.0/count(*),2) as Overall_Attrition_Rate from hr_employee_attrition
Group by Department, OverTime
order by Overall_Attrition_Rate Desc; 
/*Salary Analysis */
/*Average Salary*/
Select round(avg(MonthlyIncome),2) AS Average_Salary from hr_employee_attrition;
/*Avg Salary by department, Job role, Joblevel, EducationField, Attrition, OverTime*/
Select round(avg(MonthlyIncome),2) as Average_Salary , Department from hr_employee_attrition
Group by Department
order by Average_Salary;
Select round(avg(MonthlyIncome),2) as Average_Salary , JobRole from hr_employee_attrition
Group by JobRole
order by Average_Salary;
Select round(avg(MonthlyIncome),2) as Average_Salary , EducationField from hr_employee_attrition
Group by EducationField
order by Average_Salary;
Select round(avg(MonthlyIncome),2) as Average_Salary , Attrition from hr_employee_attrition
Group by Attrition
order by Average_Salary;
Select round(avg(MonthlyIncome),2) as Average_Salary , OverTime from hr_employee_attrition
Group by OverTime
order by Average_Salary;
/*Salary Band Distribution*/
select
CASE 
when MonthlyIncome < 5000 then 'lowest Salary'
when MonthlyIncome between 5000 and 10000 then 'Medium Salary'
when MonthlyIncome between 10001 and 15000 then 'Highest Salary'
Else 'Very Higher Salary'
end Salary_band, Count(*) as Employee_count from hr_employee_attrition
group by Salary_band
order by Employee_count Desc;
/*Top 10 highest paid Employee*/
select EmployeeNumber, JobRole, Department, MonthlyIncome from hr_employee_attrition
order by MonthlyIncome Desc
Limit 10;
/*Top 5 Highest Paid Employee in each department*/
with Salary_rank as
(
select EmployeeNumber, JobRole, Department, MonthlyIncome,
dense_rank() over
(
Partition by Department 
Order by MonthlyIncome Desc
) as Salary_Rank
from hr_employee_attrition
)
select * from Salary_Rank
where Salary_Rank <=5;
/*Performance Analysis */
/*Avg Performace Rating  */
select Count(*) AS Employee_Count , Round(avg(PerformanceRating),2) as Average_PerformaceRating
from hr_employee_attrition;
/*Avg Performace Rating by Department, JobRole, Education, OverTime, JobLevel*/
select Department, Round(avg(PerformanceRating),2) as Average_PerformanceRating 
from hr_employee_attrition
Group by Department
order by Average_PerformanceRating;
select JobRole, Round(avg(PerformanceRating),2) as Average_PerformanceRating 
from hr_employee_attrition
Group by JobRole
order by Average_PerformanceRating;
select EducationField, Round(avg(PerformanceRating),2) as Average_PerformanceRating 
from hr_employee_attrition
Group by EducationField
order by Average_PerformanceRating Desc;
select OverTime, Round(avg(PerformanceRating),2) as Average_PerformanceRating 
from hr_employee_attrition
Group by OverTime
order by Average_PerformanceRating Desc;
select JobLevel, Round(avg(PerformanceRating),2) as Average_PerformanceRating 
from hr_employee_attrition
Group by JobLevel
order by Average_PerformanceRating Desc;
/*Avg Training by Department, JobRole*/
select Department , Round(avg(TrainingTimesLastyear),2) as Avg_Training from hr_employee_attrition
group by Department;
select JobRole , Round(avg(TrainingTimesLastyear),2) as Avg_Training from hr_employee_attrition
group by JobRole;
/*Employees With Highest Performance*/
select EmployeeNumber, JobRole,Department, MonthlyIncome, PerformanceRating
from hr_employee_attrition
Where PerformanceRating = 
(
select Max(PerformanceRating)
from hr_employee_attrition
)
order by MonthlyIncome Desc;
/*Performance Dustribution*/
select PerformanceRating, Count(*) as Employee_count
from hr_employee_attrition
Group by PerformanceRating
order by PerformanceRating;
/*Top 3 Highest Paid Employee in each department*/
with PerformanceRating_Rank as
(
select EmployeeNumber, JobRole, Department, MonthlyIncome,
dense_rank() over
(
Partition by Department 
Order by PerformanceRating Desc, MonthlyIncome Desc
) as PerformanceRating_Rank
from hr_employee_attrition
)
select * from PerformanceRating_Rank
where PerformanceRating_Rank <=3;
/*Experience Analysis */
/*Avg Total working years, yrs at company, Avg Experience by Department,Avg Experience by JobRole, Avg Experience by Attrition */
select Round(avg(TotalWorkingYears),2) as Average_Working_Years from hr_employee_attrition;
select Round(avg(YearsAtCompany),2) as Years_At_Company from hr_employee_attrition;
select Department, Round(avg(TotalWorkingYears),2) as Average_Experience from hr_employee_attrition
group by Department;
select JobRole, Round(avg(TotalWorkingYears),2) as Average_Experience from hr_employee_attrition
group by JobRole
order by Average_Experience Desc;
select Attrition, Round(avg(TotalWorkingYears),2) as Average_Experience from hr_employee_attrition
group by Attrition;
/*Avg yrs at company by department, Avg yrs since last promotion, Avg yrs with current manager*/
select Department, Round(avg(YearsAtCompany),2) as Years_At_Company from hr_employee_attrition
Group by Department;
Select Round(avg(YearsSinceLastPromotion),2) as Years_Since_Last_Promotion from hr_employee_attrition;
Select Round(avg(YearsWithCurrManager),2) as Years_With_Current_Manager from hr_employee_attrition;
/*Most Experience Employees */
select EmployeeNumber, JobRole, Department, TotalWorkingYears from hr_employee_attrition
order by TotalWorkingYears Desc
Limit 10;
/*Experience Categories*/
select
case
when TotalWorkingYears < 5 Then '0-4 years'
when TotalWorkingYears between 5 and 10 Then '5-10 years'
when TotalWorkingYears between 11 and 20 Then '11-20 years'
Else '20+ years'
End as Experience_Level,
count(*) As Employee_Count
from hr_employee_attrition
Group by Experience_Level
order by Employee_Count Desc;
/*Experience Above company average */
select EmployeeNumber, JobRole, Department, TotalWorkingYears from hr_employee_attrition
where TotalWorkingYears > (
select Avg(TotalWorkingYears)
from hr_employee_attrition
)
order by TotalWorkingYears Desc;
/*Employee Satisfaction Analysis*/
/*Average JobSatisfaction*/
select Round(avg(JobSatisfaction),2) as Job_Satisfaction From hr_employee_attrition;
/*Average JobSatisfaction By Deaprtment, By JobRole, By Attrition*/
select Department,Round(avg(JobSatisfaction),2) as Job_Satisfaction From hr_employee_attrition
Group By Department
order by Job_Satisfaction Desc;
select JobRole, Round(avg(JobSatisfaction),2) as Job_Satisfaction From hr_employee_attrition
group by JobRole
Order by Job_Satisfaction Desc;
select Attrition, Round(avg(JobSatisfaction),2) as Job_Satisfaction From hr_employee_attrition
group by Attrition
Order by Job_Satisfaction Desc;
/*WorkLifeBalance by Department, Attrition*/
select Department, Round(avg(WorkLifeBalance),2) as WorkLifeBalance From hr_employee_attrition
group by Department
Order by WorkLifeBalance Desc;
select Attrition, Round(avg(WorkLifeBalance),2) as WorkLifeBalance From hr_employee_attrition
group by Attrition
Order by WorkLifeBalance Desc;
/*Environment Satisfaction*/
select  Round(avg(EnvironmentSatisfaction),2) as EnvironmentSatisfaction From hr_employee_attrition;
/*Relationshp Satisfaction*/
select  Round(avg(RelationshipSatisfaction),2) as RelationshipSatisfaction From hr_employee_attrition;
/*Satisfaction Level Distribution*/
select JobSatisfaction, Count(*) as Employee_count
from hr_employee_attrition
Group by JobSatisfaction
Order by JobSatisfaction;
/*Employees with High Satisfaction*/
select EmployeeNumber, JobRole, Department, MonthlyIncome, JobSatisfaction, WorkLifeBalance from hr_employee_attrition
where JobSatisfaction = (
select Max(JobSatisfaction)
from hr_employee_attrition
)
order by WorkLifeBalance Desc;
/*Below Average JobSatisfaction*/
select EmployeeNumber, JobRole, Department, MonthlyIncome, JobSatisfaction, WorkLifeBalance from hr_employee_attrition
where JobSatisfaction < (
select Avg(JobSatisfaction)
from hr_employee_attrition
)
order by JobSatisfaction;