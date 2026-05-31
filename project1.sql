-- =============================================
-- 1조 캡스톤 프로젝트
-- 프로젝트 1 (기초): 글로벌 거래처 명부 DB
-- =============================================

CREATE DATABASE IF NOT EXISTS trade_db DEFAULT CHARACTER SET utf8mb4;
USE trade_db;

SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS contact;
DROP TABLE IF EXISTS company;
SET FOREIGN_KEY_CHECKS = 1;

-- 업체 테이블 생성
CREATE TABLE company (
    company_id     INT          NOT NULL AUTO_INCREMENT,
    company_name   VARCHAR(100) NOT NULL,
    country        VARCHAR(50),
    partner_type   VARCHAR(50),
    credit_grade   CHAR(1)      DEFAULT 'A',
    trade_currency VARCHAR(10),
    PRIMARY KEY (company_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 담당자 테이블 생성 (1:N 관계)
CREATE TABLE contact (
    contact_id        INT          NOT NULL AUTO_INCREMENT,
    contact_name      VARCHAR(50)  NOT NULL,
    email             VARCHAR(100) UNIQUE,
    last_contact_date DATE,
    notes             TEXT,
    company_id        INT          NOT NULL,
    PRIMARY KEY (contact_id),
    CONSTRAINT fk_company_contact
        FOREIGN KEY (company_id) REFERENCES company(company_id)
        ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 업체 데이터 입력
INSERT INTO company (company_name, country, partner_type, credit_grade, trade_currency)
VALUES
    ('Global Tech Inc.', 'USA',     'Manufacturer', 'A', 'USD'),
    ('Tokyo Logistics',  'Japan',   'Forwarder',    'B', 'JPY'),
    ('Seoul Trade Co.',  'Korea',   'Trader',       'A', 'KRW'),
    ('Hanoi Trading',    'Vietnam', 'Supplier',     'C', 'USD');

-- 담당자 데이터 입력
INSERT INTO contact (contact_name, email, last_contact_date, notes, company_id)
VALUES
    ('John Doe',   'john@globaltech.com',  '2026-05-15', 'Initial meeting.',              1),
    ('Sato Kenji', 'sato@tokyolog.jp',     '2026-01-10', 'Urgent: Long time no see.',     2),
    ('Kim Min-su', 'mskim@seoultrade.kr',  '2026-05-20', 'Sample request.',               3),
    ('Nguyen An',  'an@hanoitrade.vn',     '2025-11-05', 'No response since last year.',  4);

-- [쿼리 1] 전체 업체 목록 조회
SELECT * FROM company;

-- [쿼리 2] 국가가 'USA'인 업체 필터링
SELECT * FROM company WHERE country = 'USA';

-- [쿼리 3] 신용 등급이 'A'인 업체 조회
SELECT company_name, country, credit_grade
FROM company
WHERE credit_grade = 'A';
-- =============================================
-- 1조 캡스톤 프로젝트
-- 프로젝트 2 (활용): 담당자 연락망 및 교신 이력
-- =============================================

USE trade_db;

-- [쿼리 1] 업체와 담당자 JOIN — 전체 연락망 출력
SELECT
    c.company_name,
    c.country,
    t.contact_name,
    t.email,
    t.last_contact_date
FROM company c
JOIN contact t ON c.company_id = t.company_id;

-- [쿼리 2] 최근 교신일 기준 내림차순 정렬 (최신순)
SELECT
    contact_name,
    last_contact_date,
    notes
FROM contact
ORDER BY last_contact_date DESC;

-- [쿼리 3] 오랫동안 연락이 끊긴 업체 추출 (2026년 3월 이전 교신)
SELECT
    c.company_name,
    t.contact_name,
    t.last_contact_date
FROM company c
JOIN contact t ON c.company_id = t.company_id
WHERE t.last_contact_date < '2026-03-01'
ORDER BY t.last_contact_date ASC;
