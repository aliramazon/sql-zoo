-- https://www.sqlzoo.net/wiki/More_JOIN_operations
-- Movie Database
-- This database features two entities (movies and actors) in a many-to-many relation. Each entity has its own table. A third table, casting , is used to link them. The relationship is many-to-many because each film features many actors and each actor has appeared in many films.
-- movie(id, title, yr, director, budget, gross)
-- actor(id, name)
-- casting(movieid, actorid, ord)
--  --  -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -
-- 1: Write a query that lists the unfortunate directors of the movies which caused financial loses (gross < budget)
SELECT
    director
FROM
    movie
WHERE
    gross < budget;


-- Some how below query is correct one. It probably mean actors can be directors as well. Hmm.
SELECT
    name
FROM
    actor
    INNER JOIN movie ON actor.id = director
WHERE
    gross < budget;


-- 2: Write a correct example of joining three tables
SELECT
    *
FROM
    actor
    JOIN casting ON (actor.id = casting.actorid)
    JOIN movie ON (movie.id = casting.movieid);


-- 3: Write a query that shows the list of actors called 'John' by order of number of movies in which they acted
SELECT
    actor.name,
    COUNT(casting.movieid)
FROM
    actor
    JOIN casting ON (actor.id = casting.actorid)
WHERE
    actor.name LIKE 'John%'
GROUP BY
    actor.name
ORDER BY
    COUNT(casting.movieid) DESC;


-- 4: Write a query that shows the titles of movies in which Paul Hogan starred
SELECT
    title
FROM
    movie
    JOIN casting ON (casting.movieid = movie.id)
    JOIN actor ON (casting.actorid = actor.id)
WHERE
    name = 'Paul Hogan'
    AND casting.ord = 1;


-- 5: Write a query that lists all the actors that starred in movies directed by Ridley Scott who has id 351
SELECT
    name
FROM
    movie
    JOIN casting ON (casting.movieid = movie.id)
    JOIN actor ON (casting.actorid = actor.id)
WHERE
    casting.ord = 1
    AND movie.director = 351;


-- 6: Write a query that shows the list of movie titles and years for movies where Robert De Niro had the third billing (ord = 3).
SELECT
    title,
    yr
FROM
    movie
    JOIN casting ON casting.movieid = movie.id
    JOIN actor ON casting.actorid = actor.id
WHERE
    actor.name = 'Robert De Niro'
    AND casting.ord = 3;


-- Below is the old syntax
SELECT
    title,
    yr
FROM
    movie,
    casting,
    actor
WHERE
    name = 'Robert De Niro'
    AND movieid = movie.id
    AND actorid = actor.id
    AND ord = 3;