-- +----------------+-------------+-----------+-------------+------------------+
-- | name           | region      | area      | population  | gdp              |
-- +----------------+-------------+-----------+-------------+------------------+
-- | Afghanistan    | South Asia  | 652,225   | 26,000,000  | NULL             |
-- | Albania        | Europe      | 28,728    | 3,200,000   | 6,656,000,000    |
-- | Algeria        | Middle East | 2,400,000 | 32,900,000  | 75,012,000,000   |
-- | Andorra        | Europe      | 468       | 64,000      | NULL             |
-- | Bangladesh     | South Asia  | 143,998   | 152,600,000 | 67,144,000,000   |
-- | United Kingdom | Europe      | 242,514   | 59,600,000  | 2,022,824,000,000|
-- +----------------+-------------+-----------+-------------+------------------+
-- 
-- COLUMNS:
-- - name:       Country name (VARCHAR) - Primary identifier
-- - region:     Geographic/political region (VARCHAR) 
-- - area:       Total land area in square kilometers (INTEGER)
-- - population: Total population count (INTEGER)
-- - gdp:        Gross Domestic Product in USD (BIGINT)
--
-- 1:  Write a query that returns the sum of population of all countries in 'Europe'
SELECT
    SUM(population)
FROM
    bbc
WHERE
    region = "Europe";


-- 2: Write a query that returns number of countries with population smaller than 150000
SELECT
    COUNT(name)
FROM
    bbc
WHERE
    population < 150000;


--3 : List the list of core SQL aggregate functions
-- AVG(), COUNT(), MAX(), MIN(), SUM()
--
-- 4: Write a query that returns the list of regions and their total area where the total area is greater than 15,000,000.
SELECT
    region,
    SUM(area)
FROM
    bbc
GROUP BY
    region
HAVING
    SUM(area) > 15000000;


-- 5:  Write a query that returns the average population of 'Poland', 'Germany' and 'Denmark'
SELECT
    AVG(population)
FROM
    bbc
WHERE
    name IN ('Poland', 'Germany', 'Denmark');


-- 6: Write a query that returns the population density of each region
SELECT
    region,
    SUM(population) / SUM(area) AS density
FROM
    bbc
GROUP BY
    region;


-- 7: Write a query that returns the name and population density of the country with the largest population;
SELECT
    name,
    population / area
FROM
    bbc
WHERE
    population = (
        SELECT
            MAX(population)
        FROM
            bbc
    );


-- 8: Show the total area of regions whose total area is at most 20 million.
SELECT
    region,
    SUM(area)
FROM
    bbc
GROUP BY
    region
HAVING
    SUM(area) > 20000000