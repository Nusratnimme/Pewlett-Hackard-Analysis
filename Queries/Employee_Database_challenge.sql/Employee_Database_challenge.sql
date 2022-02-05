-- Deliverable 1: The Number of Retiring Employees by Title
-- Creating a table of retiring employees by their titles

SELECT e.emp_no,
    e.first_name,
    e.last_name,
    t.title,
	t.from_date,
    t.to_date
INTO retirement_titles
FROM employees AS e
	INNER JOIN titles AS t
	ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no;

SELECT * FROM retirement_titles;

-- Use Dictinct with Orderby to remove duplicate rows

SELECT DISTINCT ON (emp_no) emp_no,
	first_name,
	last_name,
	title
INTO unique_titles
FROM retirement_titles
WHERE to_date = ('9999-01-01')
ORDER BY emp_no, to_date DESC;

SELECT * FROM unique_titles;

-- Count total number of retiring employees by titles

SELECT COUNT(emp_no), title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY COUNT(title) DESC;

SELECT * FROM retiring_titles;


-- Deliverable 2: The Employees Eligible for the Mentorship Program

SELECT DISTINCT ON (e.emp_no) e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	t.title
INTO mentorship_eligibility
FROM employees AS e
	LEFT JOIN dept_emp AS de
	ON (e.emp_no = de.emp_no)
	LEFT JOIN titles AS t
	ON (e.emp_no = t.emp_no)
WHERE de.to_date = ('9999-01-01')
AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY e.emp_no;

SELECT * FROM mentorship_eligibility;


-- Two additional queries

-- 1. Number of retirement employees by department

SELECT DISTINCT ON (rt.emp_no)
	rt.emp_no,
	rt.first_name,
	rt.last_name,
	rt.title,
	d.dept_name
INTO retiring_dept
FROM retirement_titles AS rt
	INNER JOIN dept_emp AS de
	ON (rt.emp_no = de.emp_no)
	INNER JOIN departments AS d
	on (de.dept_no = d.dept_no)
WHERE rt.to_date = ('9999-01-01')
ORDER BY rt.emp_no;

SELECT * FROM retiring_dept;

-- 2. Count total number of retiring employees by department and title

SELECT rd.dept_name, rd.title, count(rd.emp_no) 
INTO retiring_employees
FROM retiring_dept as rd
GROUP BY rd.dept_name, rd.title
ORDER BY rd.dept_name desc, rd.count desc;

SELECT * FROM retiring_employees;

-- Get the number of probable mentors 
SELECT DISTINCT ON (e.emp_no) e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	t.title
INTO qualified_mentor
FROM employees AS e
	LEFT JOIN dept_emp AS de
	ON (e.emp_no = de.emp_no)
	LEFT JOIN titles AS t
	ON (e.emp_no = t.emp_no)
WHERE de.to_date = ('9999-01-01')
AND (e.birth_date BETWEEN '1963-01-01' AND '1965-12-31')
ORDER BY e.emp_no;

SELECT * FROM qualified_mentor;
