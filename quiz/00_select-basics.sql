-- https://sqlzoo.net/wiki/SELECT_Quiz
--
-- 1:
SELECT
    name,
    population
FROM
    world
WHERE
    population BETWEEN 1000000 AND 1250000;


-- 2: 
-- It selects country names and populations from the world table where the name starts with "Al"
SELECT
    name,
    population
FROM
    world
WHERE
    name LIKE "Al%";


-- 3:
-- Select the code which shows the countries that end in "a" or "l"
SELECT
    name
FROM
    world
WHERE
    name LIKE '%a'
    OR name LIKE '%l';


-- 4:
-- Write a  query that selects the names and their lengths from the world table for countries in the Europe region whose names are exactly 5 characters long.
SELECT
    name,
    LENGTH (name)
FROM
    world
WHERE
    region = 'Europe'
    AND LENGTH (name) = 5;


-- 5:
-- Write a query that selects the name and double the area (i.e., area * 2) from the world table for countries whose population is exactly 64,000.
SELECT
    name,
    area * 2
FROM
    world
WHERE
    population = 64000;


--6: 
-- Write a query that would show the countries with an area larger than 50,000 and a population smaller than 10,000,000
SELECT
    name,
    area,
    population
FROM
    world
WHERE
    area > 50000
    AND population < 10000000;


-- 7:
-- Write a query that shows the population density of China, Australia, Nigeria and France
SELECT
    name,
    population / area AS density
FROM
    world
WHERE
    name IN ('China', 'Australia', 'Nigeria', 'France')