drop database if exists lab9;
create database lab9;
drop table if exists employees;
create table employees(
    first_name text,
    last_name text,
    company text,
    salary numeric
);
insert into employees values('Asdf','asddf','adsfdg',12345),
                            ('Qwer','asff','asdfdg',12345),
                            ('Zxcv','asdfgd','asfdgh',1235);
drop table if exists products;
create table products (
    product_id serial,
    product_name text,
    category text,
    price numeric
);
insert into products (product_name, category, price) values
    ('Laptop', 'Electronics', 1000.00),
    ('Smartphone', 'Electronics', 800.00),
    ('Refrigerator', 'Appliances', 500.00),
    ('Blender', 'Appliances', 50.00),
    ('Table', 'Furniture', 150.00),
    ('Chair', 'Furniture', 75.00);

DROP FUNCTION IF EXISTS increase_value(INTEGER);
CREATE OR REPLACE FUNCTION increase_value(val INTEGER)
    RETURNS INTEGER AS
$$
BEGIN
    RETURN val + 10;
END;
$$
    LANGUAGE plpgsql;

DROP FUNCTION IF EXISTS compare_numbers(INTEGER, INTEGER);
CREATE OR REPLACE FUNCTION compare_numbers(a INTEGER, b INTEGER, OUT result TEXT)
AS $$
BEGIN
    IF a > b THEN
        result := 'Greater';
    ELSIF a < b THEN
        result := 'Lesser';
    ELSE
        result := 'Equal';
    END IF;
END; $$
LANGUAGE plpgsql;

DROP FUNCTION IF EXISTS number_series(INTEGER);
CREATE OR REPLACE FUNCTION number_series(n INTEGER)
RETURNS TABLE(series INTEGER) AS $$
BEGIN
    FOR series IN 1..n LOOP
        RETURN QUERY SELECT series;
    END LOOP;
END; $$
LANGUAGE plpgsql;

DROP FUNCTION IF EXISTS find_employee(VARCHAR);
CREATE OR REPLACE FUNCTION find_employee(emp_name VARCHAR)
RETURNS TABLE(first_name TEXT, last_name TEXT, company TEXT, salary NUMERIC) AS $$
BEGIN
    RETURN QUERY SELECT * FROM employees WHERE employees.first_name = emp_name;
END; $$
LANGUAGE plpgsql;

select * from find_employee('Asdf');

DROP FUNCTION IF EXISTS list_products(TEXT);
CREATE OR REPLACE FUNCTION list_products(given_category TEXT)
RETURNS TABLE(product_id INT, product_name TEXT, category TEXT, price NUMERIC) AS $$
BEGIN
    RETURN QUERY
    SELECT * FROM products WHERE products.category = given_category;
END; $$
LANGUAGE plpgsql;

select * from list_products('Electronics');
DROP FUNCTION IF EXISTS calculate_bonus(TEXT);
CREATE OR REPLACE FUNCTION calculate_bonus(emp_name TEXT)
RETURNS NUMERIC AS $$
DECLARE
    bonus NUMERIC;
BEGIN
    SELECT salary * 0.10 INTO bonus FROM employees
    WHERE employees.first_name = emp_name;
    RETURN bonus;
END; $$
LANGUAGE plpgsql;

DROP FUNCTION IF EXISTS update_salary(TEXT);
CREATE OR REPLACE FUNCTION update_salary(emp_name TEXT)
RETURNS VOID AS $$
DECLARE
    bonus NUMERIC;
BEGIN
    bonus := calculate_bonus(emp_name);
    UPDATE employees
    SET salary = salary + bonus
    WHERE employees.first_name = emp_name;
END; $$
LANGUAGE plpgsql;

SELECT calculate_bonus('Asdf');
SELECT update_salary('Asdf');
SELECT * FROM employees;

--7
DROP PROCEDURE IF EXISTS complex_calculation;
CREATE OR REPLACE PROCEDURE complex_calculation(input_number INTEGER, input_text VARCHAR)
LANGUAGE plpgsql
AS $$
DECLARE
    reversed_text VARCHAR;
    factorial_result BIGINT := 1;
    i INTEGER;
BEGIN
    <<string_manipulation>>
    BEGIN
        reversed_text := reverse(input_text);
        RAISE NOTICE 'Reversed text: %', reversed_text;
    END string_manipulation;

    <<numeric_computation>>
    BEGIN
        FOR i IN 1..input_number LOOP
            factorial_result := factorial_result * i;
        END LOOP;
        RAISE NOTICE 'Factorial of %: %', input_number, factorial_result;
    END numeric_computation;

    RAISE NOTICE 'Final Result: Reversed Text: %, Factorial: %', reversed_text, factorial_result;
END;
$$;

CALL complex_calculation(5, 'Hello');