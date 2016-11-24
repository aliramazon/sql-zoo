--1 Show the population of Germany

SELECT population FROM world
WHERE name = 'Germany'

--2 Show the name and the population for 'Ireland', 'Iceland' and 'Denmark'.

SELECT name, population
FROM world
WHERE name IN ('Luxembourg', 'Mauritius', 'Samoa')


--3 Show the country and the area for countries with an area between 200,000 and 250,000.

SELECT name, area
FROM world
WHERE area BETWEEN 200000 AND 250000
ORDER BY area ASC

-- 4

SELECT name, population
FROM world
WHERE population BETWEEN 1000000 AND 1250000

-- 5 Select countries ending with a or l

SELECT name FROM world
WHERE name LIKE '%a' OR LIKE '%l'

--6

SELECT name, LENGTH(name)
FROM world
WHERE LENGTH(name) = 5 AND region='Europe'

--7

SELECT name, area * 2
FROM world
WHERE population = 64000

--8

SELECT name, area, population
FROM world
where area > 50000 AND population < 10000000

--9 Select the code that shows the population density of China, Australia, Nigeria and France

SELECT name, population/area
FROM world
WHERE name IN ('China', 'Australia', 'Nigeria', 'France')
