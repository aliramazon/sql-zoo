-- https://sqlzoo.net/wiki/BBC_QUIZ
--
-- name         | continent      | area     | population | gdp
-- ---------------------------------------------------------------
-- Afghanistan  | South Asia     | 652225   | 26000000   | NULL
-- Albania      | Europe         | 28728    | 3200000    | 6656000000
-- Algeria      | Middle East    | 2400000  | 32900000   | 75012000000
-- Andorra      | Europe         | 468      | 64000      | NULL
-- Brazil       | South America  | 8550000  | 182800000  | 564852000000
-- Colombia     | South America  | 1140000  | 45600000   | NULL
-- Nauru        | Asia-Pacific   | 21       | 9900       | NULL
-- Uzbekistan   | Central Asia   | 447000   | 26000000   | NULL
-- 
-- 1: Write a query that gets the list of countries beginning with U
SELECT
    name
FROM
    world
WHERE
    name LIKE "U%";


-- 2: Write a query that shows the population of United Kingdom
SELECT
    population
FROM
    world
WHERE
    name = "United Kingdom";


-- 3: Find the continent of France
SELECT
    continent
FROM
    world
WHERE
    name = 'France';


-- 4: What are the names of countries with a population less than 10,000, and what is one-tenth of their population?
SELECT
    name,
    population / 10
FROM
    world
WHERE
    population < 10000;


--5: Write a query which would reveal the name and population of countries in Europe and Asia
SELECT
    name,
    population
FROM
    world
WHERE
    continent IN ("Europe", "Asia");


--6: Which countries in South America have a population greater than 40 million?
SELECT
    name
FROM
    world
WHERE
    continent = "South America"
    AND population > 40000000