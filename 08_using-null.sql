-- https://sqlzoo.net/wiki/Using_Null
-- Table: dept
-- =======================
-- id   | name
-- -----+-----------------
-- 1    | Computing
-- 2    | Design
-- 3    | Engineering
--
-- Columns:
--   id   : unique department identifier
--   name : department name
--
-- =======================
-- Table: teacher
-- =======================
-- id  | dept | name       | phone | mobile
-- ----+------+------------+-------+-----------------
-- 101 | 1    | Shrivell   | 2753  | 07986 555 1234
-- 102 | 1    | Throd      | 2754  | 07122 555 1920
-- 103 | 1    | Splint     | 2293  | 
-- 104 | NULL | Spiregrain | 3287  | 
-- 105 | 2    | Cutflower  | 3212  | 07996 555 6574
-- 106 | NULL | Deadyawn   | 3345  | 
--
-- Columns:
--   id     : unique employee identifier
--   dept   : foreign key → department.id (nullable)
--   name   : employee full name
--   phone  : office extension
--   mobile : optional mobile number
--  =====================================================================
--
-- 1: Write the query that lists the teachers who have NULL for their department.
SELECT
    name
FROM
    teacher
WHERE
    dept IS NULL;


-- 2: Write a query that retrieves the names of teachers along with the names of the departments they belong to
SELECT
    teacher.name,
    dept.name AS dept
FROM
    teacher
    INNER JOIN dept ON (dept.id = teacher.dept);


-- 3: Write a query that lists all teachers and their departments, even if they do not belong to any department (NULL is allowed)
SELECT
    teacher.name,
    dept.name AS dept
FROM
    teacher
    LEFT JOIN dept ON (dept.id = teacher.dept);


-- 4: Write a query that lists all departments and their teachers. Even if a department has no teachers, the department will still be shown (teacher will be NULL).
SELECT
    teacher.name,
    dept.name AS dept
FROM
    teacher
    RIGHT JOIN dept ON (dept.id = teacher.dept);


-- 5: Write a query that returns teacher names and their mobile numbers, replacing NULL values with the default '07986 444 2266'
SELECT
    name,
    COALESCE(mobile, '07986 444 2266') AS mobile
FROM
    teacher;


-- 6: Use the COALESCE function and a LEFT JOIN to print the teacher name and department name. Use the string 'None' where there is no department.
SELECT
    teacher.name,
    COALESCE(dept.name, "None") AS dept
FROM
    teacher
    LEFT JOIN dept ON (dept.id = teacher.dept);


--7: Use COUNT to show the number of teachers and the number of mobile phones.
SELECT
    COUNT(name),
    COUNT(mobile)
FROM
    teacher;


-- 8: Use COUNT and GROUP BY dept.name to show each department and the number of staff. Use a RIGHT JOIN to ensure that the Engineering department is listed.
SELECT
    dept.name,
    COUNT(teacher.name)
FROM
    teacher
    RIGHT JOIN dept ON (dept.id = teacher.dept)
GROUP BY
    dept.name;


-- 9: Use CASE to show the name of each teacher followed by 'Sci' if the teacher is in dept 1 or 2 and 'Art' otherwise.
SELECT
    name,
    CASE
        WHEN dept = 1
        OR dept = 2 THEN 'Sci'
        ELSE 'Art'
    END AS category
FROM
    teacher;


-- 10: Use CASE to show the name of each teacher followed by 'Sci' if the teacher is in dept 1 or 2, show 'Art' if the teacher's dept is 3 and 'None' otherwise.
SELECT
    name,
    CASE
        WHEN dept = 1
        OR dept = 2 THEN 'Sci'
        WHEN dept = 3 THEN 'Art'
        ELSE 'None'
    END AS category
FROM
    teacher;