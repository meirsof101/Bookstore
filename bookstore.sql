-- Create the database
CREATE DATABASE BookstoreDB;
USE BookstoreDB;

-- Table: author
CREATE TABLE author (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

INSERT INTO author (name) VALUES
('Kamau Mwangi'),
('Achieng Odhiambo'),
('Wanjiku Cheruiyot'),
('Barasa Simiyu'),
('Njenga Mutiso');

-- Table: book_language
CREATE TABLE book_language (
    language_id INT AUTO_INCREMENT PRIMARY KEY,
    language_name VARCHAR(50)
);

INSERT INTO book_language (language_name) VALUES
('Swahili'),
('English'),
('Kikuyu'),
('Luo'),
('Kalenjin');

-- Table: publisher
CREATE TABLE publisher (
    publisher_id INT AUTO_INCREMENT PRIMARY KEY,
    publisher_name VARCHAR(100)
);

INSERT INTO publisher (publisher_name) VALUES
('Phoenix Publishers'),
('Longhorn Publishers'),
('East African Educational Publishers'),
('Storymoja Africa'),
('Oxford Kenya');

-- Table: book
CREATE TABLE book (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255),
    publisher_id INT,
    language_id INT,
    FOREIGN KEY (publisher_id) REFERENCES publisher(publisher_id),
    FOREIGN KEY (language_id) REFERENCES book_language(language_id)
);

INSERT INTO book (title, publisher_id, language_id) VALUES
('Shujaa wa Nairobi', 1, 1),           -- Swahili book by Phoenix Publishers
('The Matatu Chronicles', 2, 2),       -- English book by Longhorn Publishers
('Mugithi Melodies', 3, 3),            -- Kikuyu book by East African Publishers
('Adventures in Kisumu', 4, 4),        -- Luo book by Storymoja
('Rift Valley Riders', 5, 5);          -- Kalenjin book by Oxford Kenya

-- Table: book_author (many-to-many)
CREATE TABLE book_author (
    book_id INT,
    author_id INT,
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id),
    FOREIGN KEY (author_id) REFERENCES author(author_id)
);

INSERT INTO book_author (book_id, author_id) VALUES
(1, 1), -- Shujaa wa Nairobi by Wanjiru Njeri
(2, 2), -- The Matatu Chronicles by Otieno Juma
(3, 3), -- Mugithi Melodies by Kiptoo Langat
(4, 4), -- Adventures in Kisumu by Wambui Mwangi
(5, 5); -- Rift Valley Riders by Hassan Abdi

-- Table: country
CREATE TABLE country (
    country_id INT AUTO_INCREMENT PRIMARY KEY,
    country_name VARCHAR(100)
);

INSERT INTO country (country_name) VALUES
('Kenya'),
('Uganda'),
('Tanzania'),
('Rwanda'),
('South Sudan');


-- Table: address
CREATE TABLE address (
    address_id INT AUTO_INCREMENT PRIMARY KEY,
    street VARCHAR(255),
    city VARCHAR(100),
    zip_code VARCHAR(20),
    country_id INT,
    FOREIGN KEY (country_id) REFERENCES country(country_id)
);

INSERT INTO address (street, city, zip_code, country_id) VALUES
('Kenyatta Avenue', 'Nairobi', '00100', 1),
('Moi Avenue', 'Mombasa', '80100', 1),
('Kisumu-Busia Road', 'Kisumu', '40100', 1),
('Kangundo Road', 'Machakos', '90100', 1),
('Oginga Odinga Street', 'Eldoret', '30100', 1);

-- Table: address_status
CREATE TABLE address_status (
    status_id INT AUTO_INCREMENT PRIMARY KEY,
    status_name VARCHAR(50)
);

INSERT INTO address_status (status_name) VALUES
('Current'),
('Old'),
('Billing'),
('Shipping'),
('Temporary');

-- Table: customer
CREATE TABLE customer (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    email VARCHAR(100)
);

INSERT INTO customer (first_name, last_name, email) VALUES
('Wanjiku', 'Kamau', 'wanjiku.kamau@example.com'),
('Brian', 'Otieno', 'brian.otieno@example.com'),
('Amina', 'Mohamed', 'amina.mohamed@example.com'),
('Peter', 'Njoroge', 'peter.njoroge@example.com'),
('Joyce', 'Wambui', 'joyce.wambui@example.com');

-- Table: customer_address
CREATE TABLE customer_address (
    customer_id INT,
    address_id INT,
    status_id INT,
    PRIMARY KEY (customer_id, address_id),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (address_id) REFERENCES address(address_id),
    FOREIGN KEY (status_id) REFERENCES address_status(status_id)
);

INSERT INTO customer_address (customer_id, address_id, status_id) VALUES
(1, 1, 1),  -- Wanjiku Kamau, Kenyatta Avenue, Current
(2, 2, 4),  -- Brian Otieno, Moi Avenue, Shipping
(3, 3, 3),  -- Amina Mohamed, Kisumu-Busia Road, Billing
(4, 4, 5),  -- Peter Njoroge, Kangundo Road, Temporary
(5, 5, 2);  -- Joyce Wambui, Oginga Odinga Street, Old

-- Table: shipping_method
CREATE TABLE shipping_method (
    method_id INT AUTO_INCREMENT PRIMARY KEY,
    method_name VARCHAR(100)
);

INSERT INTO shipping_method (method_name) VALUES
('G4S Courier'),
('Posta Kenya'),
('Jumia Express'),
('Motorbike Delivery'),
('Pick-up from Store');

-- Table: order_status
CREATE TABLE order_status (
    status_id INT AUTO_INCREMENT PRIMARY KEY,
    status_name VARCHAR(50)
);

INSERT INTO order_status (status_name) VALUES
('Pending'),
('Processing'),
('Shipped'),
('Delivered'),
('Cancelled');

-- Table: cust_order
CREATE TABLE cust_order (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    shipping_method_id INT,
    status_id INT,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (shipping_method_id) REFERENCES shipping_method(method_id),
    FOREIGN KEY (status_id) REFERENCES order_status(status_id)
);

INSERT INTO cust_order (customer_id, order_date, shipping_method_id, status_id) VALUES
(1, '2025-04-01', 1, 2),
(2, '2025-04-02', 2, 3),
(3, '2025-04-03', 3, 4),
(4, '2025-04-04', 4, 1),
(5, '2025-04-05', 5, 5);

-- Table: order_line
CREATE TABLE order_line (
    order_id INT,
    book_id INT,
    quantity INT,
    PRIMARY KEY (order_id, book_id),
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id)
);

INSERT INTO order_line (order_id, book_id, quantity) VALUES
(1, 1, 2),
(2, 2, 1),
(3, 3, 3),
(4, 4, 1),
(5, 5, 2);

-- Table: order_history
CREATE TABLE order_history (
    history_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    status_id INT,
    update_time DATETIME,
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
    FOREIGN KEY (status_id) REFERENCES order_status(status_id)
);

INSERT INTO order_history (order_id, status_id, update_time) VALUES
(1, 2, '2025-04-01 10:00:00'),
(2, 3, '2025-04-02 11:00:00'),
(3, 4, '2025-04-03 12:00:00'),
(4, 1, '2025-04-04 13:00:00'),
(5, 5, '2025-04-05 14:00:00');

-- Admin user (full access)
CREATE USER 'admin_user'@'localhost' IDENTIFIED BY 'AdminPass123!';
GRANT ALL PRIVILEGES ON BookstoreDB.* TO 'admin_user'@'localhost';

-- Staff user (can manage books/orders, but no DROP or full admin)
CREATE USER 'staff_user'@'localhost' IDENTIFIED BY 'StaffPass123!';
GRANT SELECT, INSERT, UPDATE, DELETE ON BookstoreDB.book TO 'staff_user'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON BookstoreDB.cust_order TO 'staff_user'@'localhost';
GRANT SELECT ON BookstoreDB.customer TO 'staff_user'@'localhost';
GRANT SELECT ON BookstoreDB.order_line TO 'staff_user'@'localhost';
GRANT SELECT ON BookstoreDB.order_history TO 'staff_user'@'localhost';
GRANT SELECT ON BookstoreDB.book_author TO 'staff_user'@'localhost';
GRANT SELECT, INSERT ON BookstoreDB.order_status TO 'staff_user'@'localhost';
GRANT SELECT, INSERT ON BookstoreDB.shipping_method TO 'staff_user'@'localhost';

-- Read-only customer user (can view books and their own orders)
CREATE USER 'customer_user'@'localhost' IDENTIFIED BY 'CustomerPass123!';
GRANT SELECT ON BookstoreDB.book TO 'customer_user'@'localhost';
GRANT SELECT ON BookstoreDB.book_author TO 'customer_user'@'localhost';
GRANT SELECT ON BookstoreDB.cust_order TO 'customer_user'@'localhost';

-- Staff cannot delete books
REVOKE DELETE ON BookstoreDB.book FROM 'staff_user'@'localhost'; 

-- Applying Priveleges
FLUSH PRIVILEGES;

-- Querying for Insights
SELECT b.title, SUM(ol.quantity) AS total_ordered 
FROM order_line ol
JOIN book b ON ol.book_id = b.book_id
GROUP BY ol.book_id
ORDER BY total_ordered DESC
LIMIT 3; -- This query retrieves the top 3 most ordered books along with their total ordered quantity.

-- Number of Books per Language
SELECT bl.language_name, COUNT(*) AS book_count
FROM book b
JOIN book_language bl ON b.language_id = bl.language_id
GROUP BY bl.language_name;

-- Order Summary by Customer
SELECT c.first_name, c.last_name, COUNT(o.order_id) AS total_orders
FROM customer c
JOIN cust_order o ON c.customer_id = o.customer_id
GROUP BY c.customer_id;

-- Most Popular Authors (by books sold)
SELECT a.name, SUM(ol.quantity) AS total_books_sold
FROM order_line ol
JOIN book_author ba ON ol.book_id = ba.book_id
JOIN author a ON ba.author_id = a.author_id
GROUP BY a.author_id
ORDER BY total_books_sold DESC;
