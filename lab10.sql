DROP DATABASE IF EXISTS online_bookstore;

CREATE DATABASE online_bookstore;

CREATE TABLE Books (
    book_id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    author VARCHAR(255) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    quantity INTEGER NOT NULL
);

CREATE TABLE Customers (
    customer_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL
);

CREATE TABLE Orders (
    order_id SERIAL PRIMARY KEY,
    book_id INTEGER NOT NULL REFERENCES Books(book_id),
    customer_id INTEGER NOT NULL REFERENCES Customers(customer_id),
    order_date DATE NOT NULL,
    quantity INTEGER NOT NULL
);

INSERT INTO Books (title, author, price, quantity)
VALUES
    ('Database 101', 'A. Smith', 40.00, 10),
    ('Learn SQL', 'B. Johnson', 35.00, 15),
    ('Advanced DB', 'C. Lee', 50.00, 5);

INSERT INTO Customers (name, email)
VALUES
    ('John Doe', 'johndoe@example.com'),
    ('Jane Doe', 'janedoe@example.com');

BEGIN;

INSERT INTO Orders (book_id, customer_id, order_date, quantity)
VALUES (1, 101, CURRENT_DATE, 2);

UPDATE Books
SET quantity = quantity - 2
WHERE book_id = 1;

COMMIT;

BEGIN;

DO $$
BEGIN
    IF (SELECT quantity FROM Books WHERE book_id = 3) >= 10 THEN
        INSERT INTO Orders (book_id, customer_id, order_date, quantity)
        VALUES (3, 102, CURRENT_DATE, 10);

        UPDATE Books
        SET quantity = quantity - 10
        WHERE book_id = 3;
    ELSE
        RAISE EXCEPTION 'Not enough stock for book_id 3. Rolling back transaction.';
    END IF;
END;
$$;

ROLLBACK;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

BEGIN;
UPDATE Books
SET price = 45.00
WHERE book_id = 1;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

BEGIN;
SELECT price FROM Books WHERE book_id = 1;

COMMIT;

SELECT price FROM Books WHERE book_id = 1;

BEGIN;

UPDATE Customers
SET email = 'newemail@example.com'
WHERE customer_id = 101;

COMMIT;

SELECT * FROM Customers WHERE customer_id = 101;
