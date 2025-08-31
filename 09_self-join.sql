-- https://sqlzoo.net/wiki/Edinburgh_Buses.
-- Table: stops
-- =======================
-- id  | name
-- ----+------------------------------
-- 1   | Princes Street
-- 2   | Leith
-- 3   | Portobello
-- ...
--
-- Columns:
--   id   : arbitrary unique identifier for the area
--   name : name of an area or town served by at least one bus
--
--
-- =======================
-- Table: route
-- =======================
-- num  | company | pos | stop
-- -----+---------+-----+------
-- 22   | LRT     | 1   | 1
-- 22   | LRT     | 2   | 2
-- 22   | LRT     | 3   | 3
-- ...
--
-- Columns:
--   num     : bus number as displayed on the vehicle (may include letters)
--   company : bus company (e.g., LRT = Lothian Region Transport)
--   pos     : order of the stop within the route
--   stop    : foreign key → stops.id (area served)
--
-- Notes:
-- - A route is uniquely identified by (num + company).
-- - Some routes revisit the same stop.
-- - Most buses run in both directions.
--
-- 1: How many stops are in the database?
SELECT
    COUNT(*)
FROM
    stops;


-- 2: Find the id value for the stop 'Craiglockhart'
SELECT
    id
FROM
    stops
WHERE
    name = 'Craiglockhart';


-- 3: List the id and the name for the stops on the '4' 'LRT' service.
SELECT
    stops.id,
    stops.name
FROM
    stops
    JOIN route ON (stops.id = route.stop)
WHERE
    route.num = 4
    AND route.company = 'LRT'
ORDER BY
    route.pos;


-- 4: The query shown gives the number of routes that visit either London Road (149) or Craiglockhart (53). Run the query and notice the two services that link these stops have a count of 2. Add a HAVING clause to restrict the output to these two routes.
SELECT
    company,
    num,
    COUNT(*)
FROM
    route
WHERE
    stop = 53
    OR stop = 149
GROUP BY
    company,
    num
HAVING
    COUNT(stop) = 2;


-- 5: Execute the self join shown and observe that b.stop gives all the places you can get to from Craiglockhart, without changing routes. Change the query so that it shows the services from Craiglockhart to London Road.
SELECT
    a.company,
    a.num,
    a.stop 'stop - a',
    b.stop 'stop - b'
FROM
    route a
    JOIN route b ON a.company = b.company
    AND a.num = b.num
WHERE
    a.stop = 53
    AND b.stop = 149;


-- 6: The query shown is similar to the previous one, however by joining two copies of the stops table we can refer to stops by name rather than by number. Change the query so that the services between 'Craiglockhart' and 'London Road' are shown. If you are tired of these places try 'Fairmilehead' against 'Tollcross'
SELECT
    a.company,
    a.num,
    stopa.name,
    stopb.name
FROM
    route a
    JOIN route b ON (
        a.company = b.company
        AND a.num = b.num
    )
    JOIN stops stopa ON (stopa.id = a.stop)
    JOIN stops stopb ON (stopb.id = b.stop)
WHERE
    stopa.name = 'Craiglockhart'
    AND stopb.name = 'London Road';


-- 7: Give a list of all the services which connect stops 115 and 137 ('Haymarket' and 'Leith')
SELECT DISTINCT
    a.company,
    a.num
FROM
    route a
    JOIN route b ON (
        a.company = b.company
        AND a.num = b.num
    )
WHERE
    a.stop = 115
    AND b.stop = 137;


-- 8: Give a list of the services which connect the stops 'Craiglockhart' and 'Tollcross'
SELECT
    a.company,
    a.num
FROM
    route a
    JOIN route b ON (
        a.company = b.company
        AND a.num = b.num
    )
    JOIN stops stopa ON stopa.id = a.stop
    JOIN stops stopb ON stopb.id = b.stop
WHERE
    stopa.name = 'Craiglockhart'
    AND stopb.name = 'Tollcross';


-- 9: Give a distinct list of the stops which may be reached from 'Craiglockhart' by taking one bus, including 'Craiglockhart' itself, offered by the LRT company. Include the company and bus no. of the relevant services.
SELECT
    stopb.name,
    b.company,
    b.num
FROM
    route a
    JOIN route b ON (
        a.company = b.company
        AND a.num = b.num
    )
    JOIN stops stopa ON stopa.id = a.stop
    JOIN stops stopb ON stopb.id = b.stop
WHERE
    stopa.name = 'Craiglockhart';


-- 10: Find the routes involving two buses that can go from Craiglockhart to Lochend.
-- Show the bus no. and company for the first bus, the name of the stop for the transfer, and the bus no. and company for the second bus.
--
-- Hint: Self-join twice to find buses that visit Craiglockhart and Lochend, then join those on matching stops.