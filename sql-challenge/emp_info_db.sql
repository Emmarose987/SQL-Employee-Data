CREATE TABLE "departments" (
    "dept_no" VARCHAR(30)   NOT NULL,
    "dept_name" VARCHAR(30)   NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE "employees" (
    "emp_no" INT   NOT NULL,
    "emp_title" VARCHAR(30)   NOT NULL,
    "birth_date" DATE   NOT NULL,
    "first_name" VARCHAR(30)   NOT NULL,
    "last_name" VARCHAR(30)   NOT NULL,
    "sex" VARCHAR(30)   NOT NULL,
    "hire_date" DATE   NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "employee_department" (
    "emp_no" INT   NOT NULL,
    "dept_no" VARCHAR(30)   NOT NULL
);

CREATE TABLE "manager" (
    "dept_no" VARCHAR(30)   NOT NULL,
    "emp_no" INT   NOT NULL
);

CREATE TABLE "salaries" (
    "emp_no" INT   NOT NULL,
    "salary" INT   NOT NULL
);

CREATE TABLE "titles" (
    "title_id" VARCHAR(30)   NOT NULL,
    "title" VARCHAR(30)   NOT NULL
);

ALTER TABLE "employee_department" ADD CONSTRAINT "fk_employee_department_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "employee_department" ADD CONSTRAINT "fk_employee_department_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "manager" ADD CONSTRAINT "fk_manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "manager" ADD CONSTRAINT "fk_manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "salaries" ADD CONSTRAINT "fk_salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

---List employees and salary

SELECT * FROM employees;

SELECT employees.emp_no, employees.first_name, employees.last_name, employees.sex, salaries.salary
FROM employees
INNER JOIN salaries
ON employees.emp_no=salaries.emp_no;

---list first name, last name, and hire date for employees who were hired in 1986

SELECT first_name, last_name, hire_date
FROM employees
WHERE "hire_date" >= '1986-01-01' AND "hire_date" < '1986-12-31';

---List the manager of each department...

SELECT departments.dept_no, departments.dept_name, manager.emp_no, employees.last_name, employees.first_name
FROM departments
INNER JOIN manager ON 
departments.dept_no=manager.dept_no
INNER JOIN employees ON
manager.emp_no=employees.emp_no;

---List the department of each employee with the following information...

SELECT employee_department.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM employee_department
INNER JOIN employees ON 
employee_department.emp_no=employees.emp_no
INNER JOIN departments ON
departments.dept_no=employee_department.dept_no;

---list first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."
SELECT first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules'
AND last_name LIKE 'B%';

---List all employees in the Sales department, including their employee number, last name, first name, and department name

SELECT employee_department.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM employee_department 
INNER JOIN employees ON
employee_department.emp_no=employees.emp_no
INNER JOIN departments ON
departments.dept_no=employee_department.dept_no
WHERE departments.dept_name = 'Sales';

---List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.

SELECT employee_department.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM employee_department 
INNER JOIN employees ON
employee_department.emp_no=employees.emp_no
INNER JOIN departments ON
departments.dept_no=employee_department.dept_no
WHERE departments.dept_name = 'Sales' 
OR departments.dept_name = 'Development';

---In descending order, list the frequency count of employee last names, i.e., how many employees share each last name
SELECT last_name,
COUNT(last_name) AS "frequency"
FROM employees
GROUP BY last_name
ORDER BY
COUNT(last_name) DESC;




