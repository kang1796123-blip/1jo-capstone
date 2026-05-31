CREATE DATABASE IF NOT EXISTS my_business DEFAULT CHARACTER SET utf8mb4;
USE my_business;
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS contact;
DROP TABLE IF EXISTS company;
SET FOREIGN_KEY_CHECKS = 1;
CREATE TABLE company (
    company_id INT NOT NULL AUTO_INCREMENT,
    company_name VARCHAR(100) NOT NULL,
    country VARCHAR(50),
    partner_type VARCHAR(50),
    credit_grade CHAR(1) DEFAULT 'A',
    trade_currency VARCHAR(10),
    PRIMARY KEY (company_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
CREATE TABLE contact (
    contact_id INT NOT NULL AUTO_INCREMENT,
    contact_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    last_contact_date DATE,
    notes TEXT,
    company_id INT NOT NULL,
    PRIMARY KEY (contact_id),
    CONSTRAINT fk_company_contact FOREIGN KEY (company_id) 
    REFERENCES company(company_id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
INSERT INTO company (company_name, country, partner_type, credit_grade, trade_currency)
VALUES ('Global Tech Inc.', 'USA', 'Manufacturer', 'A', 'USD');
INSERT INTO contact (contact_name, email, last_contact_date, notes, company_id)
VALUES ('John Doe', 'john@globaltech.com', '2026-05-15', 'Initial meeting.', 1);
SELECT * FROM company;
SELECT * FROM contact;
DROP DATABASE IF EXISTS trade_db;
CREATE DATABASE trade_db;
USE trade_db;
CREATE TABLE company (
    company_id INT NOT NULL AUTO_INCREMENT,
    company_name VARCHAR(100) NOT NULL,
    country VARCHAR(50),
    partner_type VARCHAR(50),
    credit_grade CHAR(1) DEFAULT 'A',
    trade_currency VARCHAR(10),
    PRIMARY KEY (company_id)
);
CREATE TABLE contact (
    contact_id INT NOT NULL AUTO_INCREMENT,
    contact_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    last_contact_date DATE,
    notes TEXT,
    company_id INT NOT NULL,
    PRIMARY KEY (contact_id),
    CONSTRAINT fk_company_contact FOREIGN KEY (company_id) 
    REFERENCES company(company_id) ON DELETE CASCADE
);
INSERT INTO company (company_name, country, partner_type, credit_grade, trade_currency)
VALUES 
('Global Tech Inc.', 'USA', 'Manufacturer', 'A', 'USD'),
('Tokyo Logistics', 'Japan', 'Forwarder', 'B', 'JPY'),
('Seoul Trade Co.', 'Korea', 'Trader', 'A', 'KRW');
INSERT INTO contact (contact_name, email, last_contact_date, notes, company_id)
VALUES 
('John Doe', 'john@globaltech.com', '2026-05-15', 'Initial meeting.', 1),
('Sato Kenji', 'sato@tokyolog.jp', '2026-04-20', 'Shipping inquiry.', 2),
('Kim Min-su', 'mskim@seoultrade.kr', '2026-05-10', 'Sample request.', 3);
SELECT * FROM company;
SELECT * FROM contact;
SELECT c.company_name, c.country, t.contact_name, t.email 
FROM company c
JOIN contact t ON c.company_id = t.company_id;
SELECT * FROM company WHERE country = 'USA';
SELECT contact_name, last_contact_date, notes 
FROM contact 
ORDER BY last_contact_date DESC;
SET SQL_SAFE_UPDATES = 0;
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS contact;
DROP TABLE IF EXISTS company;
SET FOREIGN_KEY_CHECKS = 1;
CREATE TABLE company (
    company_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    company_name VARCHAR(100),
    country VARCHAR(50),
    partner_type VARCHAR(50)
);
CREATE TABLE contact (
    contact_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    contact_name VARCHAR(50),
    email VARCHAR(100),
    company_id INT,
    FOREIGN KEY (company_id) REFERENCES company(company_id)
);
INSERT INTO company (company_name, country, partner_type) 
VALUES ('Global Tech Inc.', 'USA', 'Manufacturer');
INSERT INTO contact (contact_name, email, company_id) 
VALUES ('John Doe', 'john@old-email.com', 1);
UPDATE contact 
SET email = 'john_new@globaltech.com' 
WHERE contact_name = 'John Doe';
SELECT * FROM contact;
SELECT * FROM company;
SELECT * FROM contact;
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS contact;
DROP TABLE IF EXISTS company;
SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE company (
    company_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    company_name VARCHAR(100),
    country VARCHAR(50),
    partner_type VARCHAR(50)
);
INSERT INTO company (company_name, country, partner_type)
VALUES 
('Global Tech', 'USA', 'Manufacturer'),
('Hanoi Logistics', 'Vietnam', 'Forwarder'),
('Seoul Trade', 'Korea', 'Trader');
SELECT * FROM company 
WHERE country = 'Vietnam';
CREATE DATABASE IF NOT EXISTS trade_db;
USE trade_db;
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS contact;
DROP TABLE IF EXISTS company;
SET FOREIGN_KEY_CHECKS = 1;
CREATE TABLE company (
    company_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    company_name VARCHAR(100),
    country VARCHAR(50)
);
CREATE TABLE contact (
    contact_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    contact_name VARCHAR(50),
    email VARCHAR(100),
    company_id INT,
    FOREIGN KEY (company_id) REFERENCES company(company_id)
);
INSERT INTO company (company_name, country) VALUES ('Seoul Trade', 'Korea');
INSERT INTO contact (contact_name, email, company_id) VALUES ('Kim Min-su', 'mskim@seoultrade.kr', 1);
SELECT company.company_name, contact.contact_name, contact.email
FROM company
JOIN contact ON company.company_id = contact.company_id;
INSERT IGNORE INTO company (company_name, country) 
VALUES ('Hanoi Trading', 'Vietnam');
SELECT company_name, country 
FROM company 
WHERE country = 'Vietnam';