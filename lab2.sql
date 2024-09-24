CREATE DATABASE lab2;
CREATE TABLE countries (
    country_id SERIAL PRIMARY KEY,
    country_name VARCHAR(100),
    region_id INT,
    population INT
);
INSERT INTO countries (country_name, region_id, population)
VALUES ('Canada', 2, 37000000);
INSERT INTO countries (country_id, country_name)
VALUES (1, 'Brazil');
INSERT INTO countries (country_name, region_id, population)
VALUES ('Argentina', NULL, 45000000);
INSERT INTO countries (country_name, region_id, population)
VALUES ('Japan', 3, 126000000),
       ('Germany', 4, 83000000),
       ('Mexico', 1, 127000000);
ALTER TABLE countries ALTER COLUMN country_name SET DEFAULT 'Kazakhstan';
INSERT INTO countries (country_name, region_id, population)
VALUES (DEFAULT, NULL, NULL);
INSERT INTO countries DEFAULT VALUES;
CREATE TABLE countries_new (LIKE countries);
INSERT INTO countries_new SELECT * FROM countries;
UPDATE countries SET region_id = 1 WHERE region_id IS NULL;
SELECT country_name, (population * 1.10) AS "New Population" FROM countries;
DELETE FROM countries WHERE population < 100000;
DELETE FROM countries_new
WHERE country_id IN (SELECT country_id FROM countries)
RETURNING *;
DELETE FROM countries
RETURNING *;


