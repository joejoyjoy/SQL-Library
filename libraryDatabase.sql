--  Sample Library DataBase
--  MySQL database with different tables and different connections.
--  We use One-To-One (1:1), One-To-Many (1:M) and using Many-To-Many (M:M)
--  To get a connection between the different tables
--  
--  Created by Joe Alt
--  Assembler Institute of Technology | Másters de Tecnología
--  Copyright © 2022 | Assembler School, S.L.


DROP DATABASE IF EXISTS library;
CREATE DATABASE IF NOT EXISTS library;
USE library;

SELECT 'CREATING DATABASE STRUCTURE' as 'INFO';

DROP TABLE IF EXISTS buyer,
                     details_buyer,
                     orders,
                     writer,
                     books_writer;

/*!50503 set default_storage_engine = InnoDB */;
/*!50503 select CONCAT('storage engine: ', @@default_storage_engine) as INFO */;

CREATE TABLE buyer (
    buyer_no INT NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(14) NOT NULL,
    last_name VARCHAR(16) NOT NULL, 
    email VARCHAR(50) NOT NULL,
    PRIMARY KEY (buyer_no)
);

INSERT INTO buyer (first_name, last_name, email) 
	VALUES ('Jhon', 'Smith', 'jhonsmith@hotmail.com'),
		('Rohard', 'Smith', 'rohardsmith@icloud.com'),
        ('Sarah', 'Williams', 'sarahwilliams@gmail.com'),
        ('Jennifer', 'Brown', 'jenniferbrown@hotmail.com'),
        ('David', 'Lopez', 'davidlopez@hotmail.com'),
        ('Sarah', 'Wilson', 'sarahwilson@gmail.com'),
        ('Thomas', 'Davis', 'thomasdavis@gmail.com'),
        ('Betty', 'Johnson', 'b.johnson@arias.com');



CREATE TABLE details_buyer (
    buyer_no INT NOT NULL,
    buyer_address varchar(255),  
    city varchar(255),
    country varchar(255),
    post_code int(11),
    FOREIGN KEY (buyer_no)  REFERENCES buyer (buyer_no)    ON DELETE CASCADE,
    PRIMARY KEY (buyer_no)
); 

INSERT INTO details_buyer (buyer_no, buyer_address, city, country, post_code) 
	VALUES (1, 'Carrer Nayara, 227, 9º 2º', 'Bonilla del Pozo', 'Spain', '58590'),
		(2, 'Ronda Elena, 4, Bajos', 'Villa Villa', 'Spain', '16966'),
        (3, 'Passeig Almaráz, 26, 31º D', 'Clemente Medio', 'Spain', '05630'),
        (4, 'Praza Bautista, 23, 2º F', 'La Sánchez', 'Spain', '47280'),
        (5, 'Travesía Guerrero, 35, 4º 0º', 'Segura de las Torres', 'Spain', '42887'),
        (6, 'Camino Héctor, 4, 38º C', 'A Iglesias Alta', 'Spain', '80826'),
        (7, 'Plaça Juan, 839, 40º C', 'Salcido de Arriba', 'Spain', '46667'),
        (8, 'Plaza Navarrete, 358, 02º A', "L' Deleón", 'Spain', '27065');



CREATE TABLE orders (
    buyer_no INT NOT NULL,
    orders_no INT NOT NULL,
    book CHAR(4) NOT NULL,
    purchase_date DATE NOT NULL,
    value_book DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (buyer_no)  REFERENCES buyer   (buyer_no)  ON DELETE CASCADE
);

INSERT INTO orders (buyer_no, orders_no, book, purchase_date, value_book) 
	VALUES (1, 1, 'B100', '2023-01-15', 52),
        (6, 2, 'B105', '2023-01-24', 67),
        (8, 3, 'B103', '2023-01-12', 34),
        (3, 4, 'B105', '2023-01-23', 67),
        (6, 5, 'B101', '2023-01-21', 24),
        (2, 6, 'B104', '2023-01-03', 24),
        (4, 7, 'B102', '2023-01-09', 24),
        (1, 8, 'B100', '2023-01-20', 52),
        (5, 9, 'B105', '2023-01-19', 67),
        (8, 10, 'B102', '2023-01-17', 24),
        (6, 11, 'B104', '2023-01-15', 24),
        (7, 12, 'B103', '2023-01-07', 34);



CREATE TABLE writer (
    writer CHAR(4) NOT NULL,
    first_name VARCHAR(14) NOT NULL,
    last_name VARCHAR(16) NOT NULL, 
    publish_date DATE NOT NULL,
    PRIMARY KEY (writer)
);

INSERT INTO writer (writer, first_name, last_name, publish_date) 
	VALUES ('W100', 'Jane', 'Austen', '2003-06-13'),
        ('W101', 'F. Scott', 'Fitzgerald', '2012-02-20'),
        ('W102', 'James', 'Joyce', '2020-01-07'),
        ('W103', 'George', 'Orwell', '2021-11-04'),
        ('W104', 'Charles', 'Dickens', '2008-10-12'),
        ('W105', 'Fyodor', 'Dostoevsky', '2023-01-23'),
        ('W106', 'Franz', 'Kafka', '1998-07-17');



CREATE TABLE books_writer (
    orders_no CHAR(4) NOT NULL,
    writer CHAR(4) NOT NULL,
    FOREIGN KEY (orders_no) REFERENCES orders (orders_no) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (writer) REFERENCES writer (writer) ON DELETE RESTRICT ON UPDATE CASCADE,
    PRIMARY KEY (orders_no, writer)
);

INSERT INTO books_writer (orders_no, writer) 
	VALUES ('B100', 'W105'),
		('B101', 'W104'),
        ('B102', 'W103'),
        ('B103', 'W102'),
        ('B101', 'W104'),
        ('B104', 'W101'),
        ('B105', 'W100'),
        ('B104', 'W106');