-- https://sqlzoo.net/wiki/Nobel_Quiz
--
-- 1: Write a query that shows the name of winner's names beginning with C and ending in n
SELECT
    winner
FROM
    nobel
WHERE
    winner LIKE "C%"
    AND winner LIKE "%n";


--2: Write a query that shows how many Chemistry awards were given between 1950 and 1960
SELECT
    COUNT(subject)
FROM
    nobel
WHERE
    subject = "Chemistry" yr BETWEEN 1950 AND 1960;


-- 3: Write  a query that shows the amount of years where no Medicine awards were given
SELECT
    COUNT(DISTINCT yr)
FROM
    nobel
WHERE
    yr NOT IN (
        SELECT DISTINCT
            yr
        FROM
            nobel
        WHERE
            subject = 'Medicine'
    );


-- 4: Write a query to list the subject and winner names for all Nobel Prize winners in the 1960s whose names start with "Sir"
SELECT
    subject,
    winner
FROM
    nobel
WHERE
    winner LIKE "Sir%"
    AND yr BETWEEN 1960 AND 1969;


--5: Write a query that would show the year when neither a Physics or Chemistry award was given
SELECT
    yr
FROM
    nobel
WHERE
    yr NOT IN (
        SELECT
            yr
        FROM
            nobel
        WHERE
            subject IN ('Physics', 'Chemistry')
    );


--6: Write a query that shows the years when a Medicine award was given but no Peace or Literature award was
SELECT DISTINCT
    yr
FROM
    nobel
WHERE
    subject = 'Medicine'
    AND yr NOT IN (
        SELECT
            yr
        FROM
            nobel
        WHERE
            subject IN ('Peace', 'Literature')
    );


-- 7: Write a query to list each subject and the number of Nobel Prizes awarded in that subject in the year 1960
SELECT
    subject,
    COUNT(subject)
FROM
    nobel
WHERE
    yr = 1960
GROUP BY
    subject