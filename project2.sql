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
FROM co
