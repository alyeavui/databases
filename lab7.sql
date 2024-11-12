CREATE DATABASE lab7;

SELECT * FROM countries WHERE name = 'string';
CREATE INDEX idx_countries_name ON countries (name);

SELECT * FROM employees WHERE name = 'string' AND surname = 'string';
CREATE INDEX idx_employees_name_surname ON employees (name, surname);

SELECT * FROM employees WHERE salary < value1 AND salary > value2;
CREATE UNIQUE INDEX idx_employees_salary_range ON employees (salary);

SELECT * FROM employees WHERE substring(name from 1 for 4) = 'abcd';
CREATE INDEX idx_employees_name_substring ON employees ((substring(name FROM 1 FOR 4)));

SELECT * FROM employees e JOIN departments d ON d.department_id = e.department_id
WHERE d.budget > value2 AND e.salary < value2;
CREATE INDEX idx_departments_budget ON departments (budget);
CREATE INDEX idx_employees_salary_department_id ON employees (salary, department_id);
