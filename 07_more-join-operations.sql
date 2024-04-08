-- https://www.sqlzoo.net/wiki/More_JOIN_operations
-- Movie Database
-- This database features two entities (movies and actors) in a many-to-many relation. Each entity has its own table. A third table, casting , is used to link them. The relationship is many-to-many because each film features many actors and each actor has appeared in many films.
-- movie(id, title, yr, director, budget, gross)
-- actor(id, name)
-- castin(movieid, actorid, ord)
--  --  -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -
-- 1:
-- List the films where the yr is 1962 [Show id, title]
SELECT
    id,
    title
FROM
    movie
WHERE
    yr = 1962;

-- 2: 
-- When was Citizen Kane released? Give year of 'Citizen Kane'.
SELECT
    yr
FROM
    movie
WHERE
    title = 'Citizen Kane';

-- 3: 
-- List all of the Star Trek movies, include the id, title and yr (all of these movies include the words Star Trek in the title). Order results by year.
SELECT
    id,
    title,
    yr
FROM
    movie
WHERE
    title LIKE '%Star Trek%'
ORDER BY
    yr;

-- 4:
-- What id number does the actor 'Glenn Close' have ?
SELECT
    id
FROM
    actor
WHERE
    name = 'Glenn Close';

-- 5:
-- What is the id of the film 'Casablanca'
SELECT
    id
FROM
    movie
WHERE
    title = 'Casablanca';