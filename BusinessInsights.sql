use hr_workforce_analytics;
/*Business Insights*/
/*Find the total number of employees in each department.*/
select Department, count(*) As Employees from hr_employee_attrition
group by Department
order by Employees;
/*Calculate the attrition rate for the entire company.*/
select 
sum(case when Attrition = 'Yes' Then 1 else 0 End) as EmployeesLeft,
Round(sum(case when Attrition = 'Yes' Then 1 else 0 End) * 100.0 / count(*),2) as Attrition_Rate
from hr_employee_attrition;
/*Find the department with the highest attrition rate.*/
select Department, sum(case when Attrition = 'Yes' Then 1 else 0 End) as EmployeesLeft,
Round(sum(case when Attrition = 'Yes' Then 1 else 0 End) * 100.0 / count(*),2) as Attrition_Rate
from hr_employee_attrition
Group by Department
Order by Attrition_Rate Desc;
/*Identify the top 5 job roles with the highest attrition.*/
select JobRole, sum(case when Attrition = 'Yes' Then 1 else 0 End) as EmployeesLeft,
Round(sum(case when Attrition = 'Yes' Then 1 else 0 End) * 100.0 / count(*),2) as Attrition_Rate
from hr_employee_attrition
Group by JobRole
Order by Attrition_Rate Desc
Limit 5;
/*Find the average monthly income for each department.*/
select Round(avg(MonthlyIncome),2) as AverageMonthlyIncome , Department from hr_employee_attrition
Group by Department
Order by AverageMonthlyIncome Desc;
/*Which job role has the highest average salary?*/
select JobRole, Round(avg(MonthlyIncome),2) as AverageSalary  from hr_employee_attrition
Group by JobRole
Order by AverageSalary Desc
limit 1;
/*Find the average age of employees in each department.*/
select Round(avg(Age),2) as AverageAge , Department from hr_employee_attrition
Group by Department
Order by AverageAge Desc;
/*Count male and female employees in every department.*/
select Count(*) as Employees , Gender from hr_employee_attrition
group by Gender,Deapartment;
/*Find the average years at the company for each department.*/
select Round(avg(YearsAtCompany),2) as AverageYears , Department from hr_employee_attrition
Group by Department
Order by AverageYears Desc;
/*Which department has the highest average job satisfaction?*/
select Round(avg(JobSatisfaction),2) as AverageJobSatisfaction , Department from hr_employee_attrition
Group by Department
Order by AverageJobSatisfaction Desc
limit 1;
/*List employees whose salary is greater than the company average.*/
select EmployeeNumber, Department, MonthlyIncome 
from hr_employee_attrition e
where MonthlyIncome >
(
select Avg(MonthlyIncome)
from hr_employee_attrition
);
/*Find employees whose experience is greater than the department average.*/
select EmployeeNumber, Department, YearsAtCompany as Experience 
from hr_employee_attrition e
where YearsAtCompany >
(
select Avg(YearsAtCompany) from hr_employee_attrition
where Department = e.Department
);
/*Find the highest-paid employee in every department.*/
with DeptRank as(
select  EmployeeNumber, Department, MonthlyIncome ,
dense_rank() over(
Partition by Department 
order by MonthlyIncome Desc
) as Ranking
from hr_employee_attrition )
select * from DeptRank
where Ranking = 1;
/*Find employees who earn more than their department's average salary but have below-average job satisfaction.*/
with deptavg as
(
select Department, Avg(MonthlyIncome) as AverageSalary
from hr_employee_attrition
group by Department
)
select e.EmployeeNumber, e.Department, e.MonthlyIncome
from hr_employee_attrition e
Join deptavg d on e.department = d.department
where e.MonthlyIncome > d.AverageSalary and JobSatisfaction < (
select avg(JobSatisfaction) from hr_employee_attrition
);
/*Show departments where attrition is above the company attrition rate.*/
select Department , Round(Sum(case When Attrition = 'Yes' Then 1 Else 0 End)  *100.0 / count(*),2) As AttritionRate
from hr_employee_attrition
group by Department
Having AttritionRate>
(
select Round(Sum(case When Attrition = 'Yes' Then 1 Else 0 End)  *100.0 / count(*),2) As AttritionRate
from hr_employee_attrition
);
/*Find the average salary of employees who left versus employees who stayed.*/
select Attrition , Round(avg(MonthlyIncome),2) as AverageSalary from hr_employee_attrition
 Group by Attrition;
/*Find departments where overtime employees have a higher attrition rate than non-overtime employees.*/
With AttritionRate As
(
select Department, OverTime, Sum(case When Attrition = 'Yes' Then 1 Else 0 End) as EmployeeLeft , 
Round(Sum(case When Attrition = 'Yes' Then 1 Else 0 End)  *100.0 / count(*),2) As AttritionRate
from  hr_employee_attrition
Group By Department, OverTime
)
Select y.AttritionRate as OverTime_YesRate ,  n.AttritionRate as OverTime_NoRate , y.Department from AttritionRate y
Join
AttritionRate n On y.Department = n.Department
Where y.OverTime = 'Yes' And n.OverTime = 'No' And y.AttritionRate > n.AttritionRate;
/*Identify the top three highest-paid employees in each department.*/
with Salary_Rank as
(
select EmployeeNumber, MonthlyIncome,Department, row_number() over
(
Partition By Department
Order by MonthlyIncome Desc
) as row_num
from hr_employee_attrition
)
select * from Salary_Rank
Where row_num <= 3;
/*Find employees who have never received a promotion but have worked for more than five years.*/
select EmployeeNumber, YearsAtCompany, YearsSinceLastPromotion from hr_employee_attrition
Where YearsAtCompany > 5 and YearsSinceLastPromotion = 0
order by YearsAtCompany desc;
/*Find employees with the maximum years at the company in each department.*/
with max_years_at_company_rank as
(
select EmployeeNumber, Department, YearsAtCompany, Dense_Rank() Over(
partition by Department
order by YearsAtCompany desc
) as Years_Rank
from hr_employee_attrition
) 
select * from  max_years_at_company_rank
Where Years_Rank = 1;
/*Rank employees by salary within each department.*/
with Salary_Rank as
(
Select EmployeeNumber, Department, MonthlyIncome,
Dense_rank() over(
partition by Department
order by MonthlyIncome Desc
) as Salary_Rank
from hr_employee_attrition
)
select * from Salary_Rank;
/*Find the second-highest salary in every department.*/
with Salary_Rank as
(
Select EmployeeNumber, Department, MonthlyIncome,
Dense_rank() over(
partition by Department
order by MonthlyIncome Desc
) as Salary_Rank
from hr_employee_attrition
)
select * from Salary_Rank
where Salary_Rank = 2;
/*Find employees whose salary is in the top 10% of their department.*/
with Salary_Rank as 
(
select EmployeeNumber, Department, MonthlyIncome,
row_number() over(
partition by Department
order by MonthlyIncome Desc
) as Salary_Rank
from hr_employee_attrition
),
DepartmentCount as
(
select Department, Count(*) as EmployeeCount
from hr_employee_attrition
group by Department
) 
select s.EmployeeNumber, s.Department, s.MonthlyIncome
from Salary_Rank s 
join DepartmentCount d 
on s.Department = d.Department
Where s.Salary_Rank <= ceil(d.EmployeeCount * 0.10);
/*Identify departments where the average performance rating is higher than the company average.*/
with deptavg as
(
select Department, avg(PerformanceRating) as AveragePerformanceRating
from hr_employee_attrition
group by Department
)
select Department,  AveragePerformanceRating
from deptavg
where AveragePerformanceRating >(
select Avg(PerformanceRating) from hr_employee_attrition
);
/*Find employees whose work-life balance is below average but whose performance rating is above average.*/
select EmployeeNumber, WorkLifeBalance, PerformanceRating from hr_employee_attrition
where WorkLifeBalance <
(
select Round(avg(WorkLifeBalance),2) from hr_employee_attrition
) and 
PerformanceRating >
(
select Round(avg(PerformanceRating),2) from hr_employee_attrition
);
/*Calculate the percentage contribution of each department to the company's total salary expenditure.*/
select  Department,sum(MonthlyIncome), Round(sum(MonthlyIncome) /
(
select (sum(MonthlyIncome))
from hr_employee_attrition
) *100,2) as Percentage_contribution
from hr_employee_attrition
group by Department;
/*Find the employee(s) with the longest tenure in the company.*/
select EmployeeNumber,Department, YearsAtCompany from hr_employee_attrition
where YearsAtCompany = 
(
select max(YearsAtCompany)
from hr_employee_attrition
);
/*Find departments where the average training sessions are below the company average.*/
with deptavg as
(
select Department, Avg(TrainingTimesLastYear) as AverageTrainingSessions
from hr_employee_attrition
group by Department
)
select Department, AverageTrainingSessions from deptavg
where AverageTrainingSessions < (
select Avg(TrainingTimesLastYear) from hr_employee_attrition
);
/*Find the relationship between education level and average salary.*/
select EducationField, Round(avg(MonthlyIncome),2) as AverageSalary
from hr_employee_attrition
Group by EducationField
order by AverageSalary desc;
/*Find employees who are above the company average in all three:Salary, Experience, Performance Rating*/
select  EmployeeNumber, Department, MonthlyIncome, TotalWorkingYears, PerformanceRating from hr_employee_attrition
where MonthlyIncome > (
select Round(avg(MonthlyIncome),2) as AverageSalary
from hr_employee_attrition
) and 
TotalWorkingYears > (
select Round(avg(TotalWorkingYears),2) as AverageExperience
from hr_employee_attrition
) and 
PerformanceRating > (
select Round(avg(PerformanceRating),2) as AveragePerformanceRating
from hr_employee_attrition
);
/*Create salary bands (Low, Medium, High, Very High) and calculate the attrition rate for each band.*/
select  
Case
when MonthlyIncome <5000 Then 'Lowest Salary'
When MonthlyIncome between 5000 and 10000 then 'Medium Salary'
when MonthlyIncome between 10001 and 15000 then 'Higher Salary'
Else 'Very Highest Salary'
End as Salary_Band,
Round(sum(case when Attrition = 'Yes' Then 1 else 0 End) * 100.0 / count(*),2) as Attrition_Rate
from hr_employee_attrition
group by Salary_Band;
/*Determine which age group has the highest average salary.*/
select  
Round(avg(MonthlyIncome),2) as AverageSalary,
case
when Age < 30 then 'Young'
when Age between 30 and 45 then 'Mid-Level'
else 'Senior'
end as Age_Category
from hr_employee_attrition
group by Age_Category
Order by AverageSalary desc
limit 1;
/*Identify departments where employees have both below-average work-life balance and above-average overtime.*/
with deptavg as
(
select Department, avg(WorkLifeBalance) as AverageWorkLifeBalance,
avg(Case when OverTime = 'Yes' Then 1 else 0 end) as AverageOverTime
from hr_employee_attrition
group by Department
)
select Department, AverageWorkLifeBalance , AverageOverTime
from deptavg
where AverageWorkLifeBalance < (
select Avg(WorkLifeBalance) from hr_employee_attrition
) and 
AverageOverTime > (
select Avg(Case when OverTime = 'Yes' Then 1 else 0 end) from hr_employee_attrition
);
/*Find the top-performing employee(s) in each department. If multiple employees have the same performance rating, rank them by salary.*/
with EmployeeRank as(
select EmployeeNumber, Department, MonthlyIncome, PerformanceRating,
row_number() Over(
partition by Department 
order by PerformanceRating desc, MonthlyIncome desc
) as Ranking
from hr_employee_attrition
)
select * from EmployeeRank
where Ranking = 1;
/*Create a summary report for each department containing:
Total Employees
Employees Left
Attrition Rate
Average Salary
Average Job Satisfaction
Average Performance Rating
Average Years at Company*/
create view department_Report as
select Department, count(*) TotalEmployees, sum(case when Attrition = 'Yes' Then 1 else 0 End) as EmployeesLeft,
Round(avg(MonthlyIncome),2) as AverageSalary, Round(avg(JobSatisfaction),2) as AverageJobsatisfaction,
Round(sum(case when Attrition = 'Yes' Then 1 else 0 End) * 100.0 / count(*),2) as Attrition_Rate, Round(avg(PerformanceRating),2) as AveragePerformanceRating,
Round(avg(YearsAtCompany),2) as AverageYearsAtCompany
from hr_employee_attrition
Group by Department;
SELECT * FROM department_Report;