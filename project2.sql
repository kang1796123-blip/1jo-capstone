USE trade_db;

SELECT
    c.company_name,
    c.country,
    t.contact_name,
    t.email,
    t.last_contact_date
FROM company c
JOIN contact t ON c.company_id = t.company_id;

SELECT
    contact_name,
    last_contact_date,
    notes
FROM contact
ORDER BY last_contact_date DESC;

SELECT
    c.company_name,
    t.contact_name,
    t.last_contact_date
FROM company c
JOIN contact t ON c.company_id = t.company_id
WHERE t.last_contact_date < '2026-03-01'
ORDER BY t.last_contact_date ASC;
