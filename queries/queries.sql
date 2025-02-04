--Creating tables for PH-EmployeeDB
Create Table Departments (
	dept_no VARCHAR(4) NOT NULL,
	dept_name VARCHAR(40) NOT NULL,
PRIMARY KEY (dept_no),
UNIQUE (dept_name)
	);
--Creating Employees table for PH-EmployeeDB
Create Table Employees (
	emp_no INT NOT Null,
	birth_date DATE NOT Null,
	first_name VARCHAR NOT Null,
	last_name VARCHAR NOT Null,
	gender VARCHAR NOT Null,
	hire_date DATE NOT Null,
PRIMARY KEY (emp_no)
);
--Creating manager table
Create Table dept_manager(
	emp_no INT NOT Null,
	dept_no VARCHAR(4) NOT Null,
	from_date DATE NOT Null,
	to_date DATE NOT Null,
FOREIGN KEY (emp_no) REFERENCES Employees (emp_no),
FOREIGN KEY (dept_no) REFERENCES Departments (dept_no),
PRIMARY KEY (emp_no , dept_no)
);
--Creating Salary Table
Create Table Salaries(
	emp_no INT NOT Null,
	salary INT NOT Null,
	from_date DATE NOT Null,
	to_date DATE NOT Null,
FOREIGN KEY (emp_no) REFERENCES Employees (emp_no),
PRIMARY KEY (emp_no)
);
--Creating Dept_Emp Table
Create Table Dept_Emp(
	emp_no INT NOT Null,
	dept_no VARCHAR(4)NOT Null,
	from_date DATE NOT Null,
	to_date DATE NOT Null,
FOREIGN KEY (emp_no) REFERENCES Employees (emp_no),
FOREIGN KEY (emp_no) REFERENCES Salaries (emp_no)
);
--Creating Titles Table
Create Table Titles(
	emp_no INT NOT Null,
	title VarChar(25) NOT Null,
	from_date DATE NOT Null,
	to_date DATE NOT Null,
FOREIGN KEY (emp_no) REFERENCES Employees (emp_no),
FOREIGN KEY (emp_no) REFERENCES Salaries (emp_no)
);
SELECT first_name , last_name
From Employees
Where (birth_date BETWEEN '1952-01-01' AND '1955-12-31') AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');
SELECT COUNT(first_name)
FROM Employees
Where (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');
--build a table
SELECT emp_no, first_name , last_name
INTO retirement_info
From Employees
Where (birth_date BETWEEN '1952-01-01' AND '1955-12-31') AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');
-- query new retirement table
SELECT * FROM retirement_info;
DROP TABLE retirement_info;
--Joining departments and dept_manager tables
SELECT d.dept_name,
	dm.emp_no,
	dm.from_date,
	dm.to_date	
FROM departments as d
INNER JOIN dept_manager as dm
ON d.dept_no = dm.dept_no;
--Joining retirement_info and dept_emp tables
SELECT ri.emp_no,
	ri.first_name,
ri.last_name,
	de.to_date
FROM retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.emp_no = de.emp_no;
--To determine if employees still work at the organization
SELECT ri.emp_no,
	ri.first_name,
	ri.last_name,
de.to_date
INTO current_emp
FROM retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.emp_no = de.emp_no
WHERE de.to_date = ('9999-01-01');
--Employee count by department number
SELECT COUNT(ce.emp_no), de.dept_no
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no;
SELECT * FROM salaries
ORDER BY to_date DESC;
SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');
SELECT emp_no
	first_name,
last_name,
	gender
INTO emp_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');
SELECT e.emp_no,
	e.first_name,
e.last_name,
	e.gender,
	s.salary,
	de.to_date
INTO emp_info
FROM employees as e
INNER JOIN salaries as s
ON (e.emp_no = s.emp_no)
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
	AND (e.hire_date BETWEEN '1985-01-01'AND '1988-12-31')
	AND (de.to_date = '9999-01-01');
-- List of managers by department
SELECT dm.dept_no,
	   d.dept_name,
	   dm.emp_no,
	   ce.last_name,
	   ce.first_name,
	   dm.from_date,
	   dm.to_date
INTO manager_info
FROM dept_manager AS dm
	INNER JOIN departments AS d
		ON (dm.dept_no = d.dept_no)
	INNER JOIN current_emp AS ce
		ON (dm.emp_no = ce.emp_no);
SELECT ce.emp_no,
		ce.first_name,
		ce.last_name,
		d.dept_name
INTO dept_info
FROM current_emp as ce
INNER JOIN dept_emp AS de
ON (ce.emp_no = de.emp_no)
INNER JOIN departments AS d
ON (de.dept_no = de