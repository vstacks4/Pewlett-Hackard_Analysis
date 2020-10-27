--create table from existing tables
SELECT e.emp_no,
	e.first_name,
	e.last_name
INTO retirement_titles
FROM Employees as e
Where (birth_date BETWEEN '1952-01-01' AND '1955-12-31');
SELECT * From retirement_titles
SELECT rt.emp_no,
	rt.first_name,
	rt.last_name,
	t.title,
	t.from_date,
	t.to_date
FROM titles	AS t
INNER JOIN retirement_titles as rt
ON rt.emp_no = t.emp_no
ORDER BY emp_no ASC;
