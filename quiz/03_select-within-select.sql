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
-- 1: Write a query that shows the name, region and population of the smallest country in each region
SELECT
    name,
    region,
    population
FROM
    bbc x
WHERE
    area < ALL (
        SELECT
            area
        FROM
            bbc y
        WHERE
            x.region = y.region
            AND area > 0
    );


-- 2: Write a query that shows the countries belonging to regions with all populations over 50000
SELECT
    name,
    region,
    population
FROM
    bbc x
WHERE
    50000 < ALL (
        SELECT
            population
        FROM
            bbc y
        WHERE
            x.region = y.region
            AND population > 0
    );


-- 3: Write a query that shows the countries with a less than a third of the population of the countries around it
SELECT
    name,
    region
FROM
    bbc x
WHERE
    population < ALL (
        SELECT
            population / 3
        FROM
            bbc y
        WHERE
            x.region = y.region
            AND x.name <> y.name
    );


-- 4: Write a query that lists the names of countries that have more population than the United Kingdom and are neighbors(same region) of the United Kingdom
SELECT
    name
FROM
    bbc
WHERE
    population > (
        SELECT
            population
        FROM
            bbc
        WHERE
            name = 'United Kingdom'
    )
    AND region = (
        SELECT
            region
        FROM
            bbc
        WHERE
            name = 'United Kingdom'
    );


-- 5: Write a query that would show the countries with a greater GDP than any country in Africa (some countries may have NULL gdp values).
SELECT
    name
FROM
    bbc x
WHERE
    gdp > ALL (
        SELECT
            gdp
        FROM
            bbc y
        WHERE
            y.region = 'Africa'
            AND y.gdp > 0
    )
    AND x.region <> 'Africa';


-- 6: Write a query that shows the countries with population smaller than Russia but bigger than Denmark
SELECT
    name
FROM
    bbc
WHERE
    population < (
        SELECT
            population
        FROM
            bbc
        WHERE
            name = 'Russia'
    )
    AND population > (
        SELECT
            population
        FROM
            bbc
        WHERE
            name = 'Denmark'
    );