-- https://www.sqlzoo.net/wiki/More_JOIN_operations
-- Movie Database
-- This database features two entities (movies and actors) in a many-to-many relation. Each entity has its own table. A third table, casting , is used to link them. The relationship is many-to-many because each film features many actors and each actor has appeared in many films.
-- movie(id, title, yr, director, budget, gross)
-- actor(id, name)
-- casting(movieid, actorid, ord)
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

-- 6:
--Obtain the cast list for 'Casablanca'.
-- what is a cast list?
-- Use movieid=11768, (or whatever value you got from the previous question)
SELECT
    name
FROM
    actor
    JOIN casting ON (id = actorid)
WHERE
    movieid = 11768;

-- 7: 
-- Obtain the cast list for the film 'Alien'
SELECT
    name
FROM
    actor
    JOIN casting ON (casting.actorid = actor.id)
    JOIN movie ON (movie.id = casting.movieid)
WHERE
    title = 'Alien';

-- 8:
-- List the films in which 'Harrison Ford' has appeared
SELECT
    title
FROM
    movie
    JOIN casting ON (movie.id = casting.movieid)
    JOIN actor ON (casting.actorid = actor.id)
WHERE
    actor.name = 'Harrison Ford';

-- 9:
-- List the films where 'Harrison Ford' has appeared - but not in the starring role. [Note: the ord field of casting gives the position of the actor. If ord=1 then this actor is in the starring role]
SELECT
    title
FROM
    movie
    JOIN casting ON (
        movie.id = casting.movieid
        AND casting.ord != 1
    )
    JOIN actor ON (casting.actorid = actor.id)
WHERE
    actor.name = 'Harrison Ford';

-- 10: 
-- List the films together with the leading star for all 1962 films.
SELECT
    movie.title,
    actor.name
FROM
    movie
    JOIN casting ON (
        movie.id = casting.movieid
        AND casting.ord = 1
    )
    JOIN actor ON casting.actorid = actor.id
WHERE
    movie.yr = 1962;

-- 11:
-- Original Question: Which were the busiest years for 'Rock Hudson', show the year and the number of movies he made each year for any year in which he made more than 2 movies. 
-- However, Rock Hudson is not director name, it is actor name. Intruction is wrong!
SELECT
    yr,
    COUNT(title) AS num_movies
FROM
    movie
    JOIN casting ON (movie.id = casting.movieid)
    JOIN actor ON (casting.actorid = actor.id)
WHERE
    actor.name = "Rock Hudson"
GROUP BY
    yr
HAVING
    COUNT(title) > 2;

--12: 
-- List the film title and the leading actor for all of the films 'Julie Andrews' played in.
-- Using Joins for Where filtering
SELECT
    title,
    actor.name
FROM
    movie
    JOIN casting ON (
        movie.id = casting.movieid
        AND casting.ord = 1
    )
    JOIN actor ON (casting.actorid = actor.id)
WHERE
    movie.id IN (
        SELECT
            movie.id
        FROM
            movie
            JOIN casting ON (movie.id = casting.movieid)
            JOIN actor ON (
                actor.id = casting.actorid
                AND actor.name = "Julie Andrews"
            )
    );

-- Using Sub Query for Where filtering
SELECT
    title,
    actor.name
FROM
    movie
    JOIN casting ON (
        movie.id = casting.movieid
        AND casting.ord = 1
    )
    JOIN actor ON (casting.actorid = actor.id)
WHERE
    movie.id IN (
        SELECT
            casting.movieid
        FROM
            casting
        WHERE
            casting.actorid = (
                SELECT
                    actor.id
                FROM
                    actor
                WHERE
                    actor.name = "Julie Andrews"
            )
    );

-- Get All movie ids Julie Andrews appeared. Use joins
SELECT
    movie.id
FROM
    movie
    JOIN casting ON (movie.id = casting.movieid)
    JOIN actor ON (
        actor.id = casting.actorid
        AND actor.name = "Julie Andrews"
    );

-- Get All movie ids Julie Andrews appeared. Use sub queries
SELECT
    movie.id
FROM
    movie
WHERE
    movie.id IN (
        SELECT
            casting.movieid
        FROM
            casting
        WHERE
            casting.actorid = (
                SELECT
                    actor.id
                FROM
                    actor
                WHERE
                    actor.name = "Julie Andrews"
            )
    );

-- 13:
-- Obtain a list, in alphabetical order, of actors who've had at least 15 starring roles.
SELECT
    name
FROM
    actor
    JOIN casting ON (
        actor.id = casting.actorid
        AND casting.ord = 1
    )
GROUP BY
    (casting.actorid)
HAVING
    COUNT(casting.ord) >= 15
ORDER BY
    name asc;

-- 14:
-- List the films released in the year 1978 ordered by the number of actors in the cast, then by title.
SELECT
    title,
    COUNT(casting.actorid)
FROM
    movie
    JOIN casting ON (movie.id = casting.movieid)
WHERE
    yr = 1978
GROUP BY
    casting.movieid
ORDER BY
    COUNT(casting.actorid) desc,
    title asc;

-- 15: 
-- List all the people who have worked with 'Art Garfunkel'.
SELECT
    name
FROM
    actor
    JOIN casting ON (actor.id = casting.actorid)
WHERE
    casting.movieid IN (
        SELECT
            casting.movieid
        FROM
            casting
            JOIN actor ON (actor.id = casting.actorid)
        WHERE
            actor.name = "Art Garfunkel"
    )
    AND name != "Art Garfunkel";

-- Find the movies' id Art Garfunkel appeared:'
SELECT
    movie.id
FROM
    movie
    JOIN casting ON (movie.id = casting.movieid)
    JOIN actor ON (
        actor.id = casting.actorid
        AND actor.name = "Art Garfunkel"
    );