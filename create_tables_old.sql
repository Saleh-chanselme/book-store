-- Création des tables

CREATE TABLE theme (
    theme_id INT PRIMARY KEY,
    theme_name VARCHAR(100) NOT NULL
);

CREATE TABLE author (
    author_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    birth_year YEAR
);

CREATE TABLE book (
book_id INT PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    publication_date DATE NOT NULL,
    theme_id INT NOT NULL ,
    author_id INT  NOT NULL,
    price DECIMAL(20,2) NOT NULL,
    FOREIGN KEY (theme_id) REFERENCES theme(theme_id),
    FOREIGN KEY (author_id) REFERENCES author(author_id),
    stock INT NOT NULL,
);

CREATE TABLE client (
    customer_id INT PRIMARY KEY,
    email VARCHAR(100) NOT NULL UNIQUE,
    registration_date DATE NOT NULL,
);

CREATE TABLE customer_order (
    order_id INT PRIMARY KEY,
    client_id INT NOT NULL,
    book_id INT NOT NULL,
    order_date DATE NOT NULL,
    total_amount DECIMAL(10,2) NOTNULL,
    FOREIGN KEY (client_id) REFERENCES customer(customer_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id),
    amount DECIMAL(2,1000) NOT NULL > 0
);

CREATE TABLE review (
review_id INT PRIMARY KEY,
rating INT(1,5) NOT NULL,
commaet VARCHAR(500) NOTNULL,
review_date DATE NOTNULL, 
client_id INT NOTNULL, 
book_id INT NOTNULL,
    FOREIGN KEY (client_id) REFERENCES customer(customer_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id),
);

