use hr_workforce_analytics;
/*Case Statements*/
/*Age and Salary*/
select EmployeeNumber, Age,
case
when Age < 30 then 'Young'
when Age between 30 and 45 then 'Mid-Level'
else 'Senior'
end as Age_Category
from hr_employee_attrition;
select EmployeeNumber, MonthlyIncome, 
Case
when MonthlyIncome <5000 Then 'Lowest Salary'
When MonthlyIncome between 5000 and 10000 then 'Medium Salary'
when MonthlyIncome between 10001 and 15000 then 'Higher Salary'
Else 'Very Highest Salary'
End as Salary_Distribution
from hr_employee_attrition;
/*Sub Queries*/
/*Employees earning above department average*/
select EmployeeNumber, Department, MonthlyIncome 
from hr_employee_attrition e
where MonthlyIncome >
(
select Avg(MonthlyIncome)
from hr_employee_attrition
Where Department = e.Department
);
/*Highest Salary In each Department*/
select EmployeeNumber, Department, MonthlyIncome 
from hr_employee_attrition e
where MonthlyIncome =
(
select Max(MonthlyIncome)
from hr_employee_attrition
Where Department = e.Department
);
/*Common Table Expressions CTE's*/
/*Average Salary by department*/
with DepartmentSalary as
(
select Department, Avg(MonthlyIncome) as AverageSalary
from hr_employee_attrition
group by Department
)
select * from DepartmentSalary;
/*Employees earning above department average*/
with deptavg as
(
select Department, Avg(MonthlyIncome) as AverageSalary
from hr_employee_attrition
group by Department
)
select e.EmployeeNumber, e.Department, e.MonthlyIncome
from hr_employee_attrition e
Join deptavg d on e.department = d.department
where e.MonthlyIncome > d.AverageSalary;
/*Windows Functions*/
/*RowNumber()*/
SELECT
    EmployeeNumber,
    Department,
    MonthlyIncome,
ROW_NUMBER() OVER(
PARTITION BY Department
ORDER BY MonthlyIncome DESC
) AS Row_Num
FROM hr_employee_attrition;
/*Rank()*/
SELECT
    EmployeeNumber,
    Department,
    MonthlyIncome,
RANK() OVER(
PARTITION BY Department
ORDER BY MonthlyIncome DESC
) AS Salary_Rank
FROM hr_employee_attrition;
/*Dense_Rank()*/
SELECT
    EmployeeNumber,
    Department,
    MonthlyIncome,
dense_rank() OVER(
PARTITION BY Department
ORDER BY MonthlyIncome DESC
) AS Salary_Rank
FROM hr_employee_attrition;
/*Views*/
/*Create Depatment Summary Views*/
create view department_summary as
select Department, count(*) TotalEmployees, Round(avg(MonthlyIncome),2) as AverageSalary, Round(avg(JobSatisfaction),2) as AverageJobsatisfaction
from hr_employee_attrition
Group by Department;
SELECT * FROM department_summary;
/*Interview Questions*/
/*Top 5 highest Paid Employees*/
select EmployeeNumber, JobRole, MonthlyIncome from hr_employee_attrition
order by MonthlyIncome desc
Limit 5;
/*Employees above Company average Salary*/
select EmployeeNumber, MonthlyIncome from hr_employee_attrition
where MonthlyIncome>
(
select Avg(MonthlyIncome)
from hr_employee_attrition
);