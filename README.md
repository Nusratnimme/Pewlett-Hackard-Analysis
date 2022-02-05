# Pewlett Hackard Analysis

## Overview

Pewlett Hackard, a large company employing thousands of people, is facing a situation where a large number of employees are going to retire around the same time. The company needs to determine how many employees will be retiring, what are their roles, decide retirement packages for them, find out which positions will need to fille in the future, and how to retain institutional knowledge by mentoring the newcomers. All these will help Pewlett Hackard remain functional during and in the aftermath of the "Silver Tsunami", the large wave of retirements.

The HR department is tasked with analyzing employees' data in SQL and advise Pewlett Hackard management on preparing for the upcoming Silver Tsunami.

## Resources

- Data Source:

The data consist of six csv files as below:
- departments.csv           - dept_emp.csv
- employees.csv             - dept_managers.csv
- salaries.csv              - titles.csv

Softwares:

- PostgreSQL13
- pgAdmin 4
- VS Code

## Pupose

The purpose of the analyses are as below:

- to create a table of employees to retire;
- to calculate the number of retiring employees by title;
- to identify employees eligible to participate in the mentorship program.

## Results

### 1. Initial list of retiring employees

- To determine the number of retiring employees by their title, emp_no, first_name, last_name columns from the Employees table and the title, from_date, to_date columns from the Titles table were retrieved.

- A new table was created by Joining the two tables on the primary key *emp_no*.

- The data was filterd on the *birth_date* column to retrieve the employees who were born between 1 Jan 1952 and 31 Dec 1955. The table was then ordered by employee number.

- The query returned **133,776** rows. However, this is **NOT** the number of employees eligible for retirement as there may be duplicates in the data.

![Retirement_titles](https://github.com/Nusratnimme/Pewlett-Hackard-Analysis/blob/main/Resources/Retirement_titles.png)

### 2. Final list of retiring employees (excluding duplicates)

- To avoid duplicate entries as some employees progressed in their career over the years assuming new roles, *DISTINCT ON* function was used to create a new table containing latest titles for duplicates. 

- That the record with latest title was retained was ensured by keeping records where *to_date* column's value is '9999-01-01'indicating current title. Then the table was sorted in by the employee number in asending order and by to_date in descending order.

![Unique_titles](https://github.com/Nusratnimme/Pewlett-Hackard-Analysis/blob/main/Resources/Unique_titles.png)

- This query returned **72,458** rows which is the number of employees who are going to retire in the next few years.

### 3. The number of employees to retire by title

- Using *GROUP BY*, the records were aggregated by titles and sorted in descending order.

- The table below shows the number employees to retire by titles. As can be seen, a very high number of employees with Senior Engineer and Senior Staff titles - **25,916** and **24,926** respectively - are up for retirement.

![Retiring_titles](https://github.com/Nusratnimme/Pewlett-Hackard-Analysis/blob/main/Resources/Retiring_titles.png)

### 4. The number of employees eligible for the mentorship program

- Next, a mentorship eligibility table was created containing current employees who were born in the year 1965.

- This was done by merging three tables on employees, departments, and employee titles using primary key. The records were filtered on date of birth and to_date to include only current employees born between January 1, 1965 and December 31, 1965. Duplicates were also removed. 

- The resulting table is as below:

![Mentorship_eligibility](https://github.com/Nusratnimme/Pewlett-Hackard-Analysis/blob/main/Resources/Mentorship_program.png)

- According to the mentorship eligibility criteria, **1,549** current employees are eligible for the program.


## Summary

The findings from the analyses provide us with insight to address following issues:

### Roles to be filled as the "silver tsunami" begins to make an impact

From the aggregates of soon-to-retire employees by title, we know that the titles to be most affected by the silver tsunami are **Senior Engineer** and **Senior Staff** with **25,916** and **24,926** retiring employees respectively.   

However, in addition to considering employees to retire by title, we also need to know their breakdown by department to plan better. To do this, tables generated in the earlier steps were merged with department data and aggregated by department and title.   

The resulting table is as below:   

![Retiring_employees](https://github.com/Nusratnimme/Pewlett-Hackard-Analysis/blob/main/Resources/Retiries_by_dept.png)

As we can see, **Production**, **Development** and **Sales** departments are going to be most affected. **12,308** and **11,256** Senior Enginners will retire in the Development and Production departments respectively, and **8,802** Senior Staff in the Sales department will retire.

It can be concluded that the recruitment of Senior Engineers with experience in Production and development, and Senior Staffs with experience in Sales should be prioritized to minimize the impact of the silver tsunami. 

### Availability of qualified mentors for the next generation of employees

As we have found in earlier analyses, there are over **70,000** thousand positions to be vacant soon and there are just over **1,500** mentors available to guide the next generation of employees as per the mentorship criteria. This gives us an approximately **50 to 1** mentee-mentor ratio. This is, of course, not ideal.

A good solution could be to relax the criteria for mentorship by widening the range of date of birth for potential mentors. If we include all employees who were born in *1963-1965* instead of only those born in 1965 in mentorship eligibility, we get a pool of more than **38,000** employees. This certainly gives us a more practical mentor-mentee ratio to work with.

![Retiring_employees](https://github.com/Nusratnimme/Pewlett-Hackard-Analysis/blob/main/Resources/Qualified_mentors.png)
