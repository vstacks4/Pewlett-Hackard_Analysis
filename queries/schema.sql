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
dept_no VARCHAR(4) NOT Null,
	emp_no INT NOT Null,
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
--Creating Managers Table
Create Table Managers(
	dept_no VARCHAR(4) NOT Null,
	emp_no INT NOT Null,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
FOREIGN KEY (emp_no) REFERENCES Employees (emp_no),
PRIMARY KEY (dept_no)
);
--Creating Dept_Emp Table
Create Table Dept_Emp(
	dept_no VARCHAR(4)NOT Null,
	emp_no INT NOT Null,
	from_date DATE NOT Null,
	to_date DATE NOT Null,
FOREIGN KEY (emp_no) REFERENCES Employees (emp_no),
FOREIGN KEY (emp_no) REFERENCES Salaries (emp_no),
PRIMARY KEY (dept_no, emp_no)
);
--Creating Titles Table
Create Table Titles(
	emp_no INT NOT Null,
	title INT NOT Null,
	from_date DATE NOT Null,
	to_date DATE NOT Null,
FOREIGN KEY (emp_no) REFERENCES Employees (emp_no),
FOREIGN KEY (emp_no) REFERENCES Salaries (emp_no),
PRIMARY KEY (emp_no)
);
