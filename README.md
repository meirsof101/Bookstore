# Group Members
1. Fidel Mwaro Ngoka
2. Gabriella Wekesa
3. Sospeter Bisera
4. Stanley Chege Thuita

📚 Book Library Database Schema
This project represents a relational database schema for a Book Library System. It captures key entities such as Books, Authors, and Languages, and illustrates how they are interconnected.

Schema Overview
The database is composed of the following tables:

🔹 book
This table stores individual book records.

book_id (Primary Key) – Unique identifier for each book.

title – The title of the book.

isbn – International Standard Book Number for the book.

published_date – Date when the book was published.

author_id (Foreign Key) – Links to the author table.

language_id (Foreign Key) – Links to the book_language table.

🔹 author
This table stores information about authors.

author_id (Primary Key) – Unique identifier for each author.

name – Full name of the author.

🔹 book_language
This table defines the languages available in the system.

language_id (Primary Key) – Unique identifier for the language.

language_name – Name of the language (e.g., English, French).

🔗 Relationships
A book belongs to one author but an author can have many books.

A book is written in one language, and a language can be associated with many books.

These relationships enforce referential integrity using foreign key constraints between:

book.author_id → author.author_id

book.language_id → book_language.language_id

Use Cases
This schema could support:

A digital or physical library system

An online bookstore database

A book tracking app with author and language metadata

🛠 Tools Used
draw.io / diagrams.net – For database ERD visualization.

SQLite / PostgreSQL / MySQL – This schema is compatible with most relational databases.

How to Use
Use the schema to create tables in your RDBMS of choice.

Populate the tables with sample book, author, and language data.

Run queries to retrieve books by language, author, or other criteria.

File Structure
book_library_schema.drawio – Editable ER diagram file.

README.md – This documentation file.

(Optional) schema.sql – SQL DDL commands to generate the schema.




