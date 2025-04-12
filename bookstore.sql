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

-- Table: shipping_method
CREATE TABLE shipping_method (
    method_id INT AUTO_INCREMENT PRIMARY KEY,
    method_name VARCHAR(100)
);

-- Table: order_status
CREATE TABLE order_status (
    status_id INT AUTO_INCREMENT PRIMARY KEY,
    status_name VARCHAR(50)
);

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

-- Table: order_line
CREATE TABLE order_line (
    order_id INT,
    book_id INT,
    quantity INT,
    PRIMARY KEY (order_id, book_id),
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id)
);

-- Table: order_history
CREATE TABLE order_history (
    history_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    status_id INT,
    update_time DATETIME,
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
    FOREIGN KEY (status_id) REFERENCES order_status(status_id)
);
