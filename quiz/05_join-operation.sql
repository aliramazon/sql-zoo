-- 1: Write a query that finds the stadium where player Dimitris Salpingidis scored.
SELECT
    stadium
FROM
    game
    JOIN goal ON (game.id = goal.matchId)
WHERE
    goal.player = "Dimitris Salpingidis";


-- 2: You JOIN the tables goal and eteam in an SQL statement. Indicate the list of column names that may be used in the SELECT line:
--  matchid, teamid, player, gtime, id, teamname, coach
--
-- 3: Write a query that shows players, their team and the amount of goals they scored against Greece(GRE).
SELECT
    player,
    teamid,
    COUNT(player)
FROM
    goal
    LEFT JOIN game ON (id = matchid)
WHERE
    teamid <> "GRE"
    AND (
        team1 = "GRE"
        OR team2 = "GRE"
    )
GROUP BY
    player,
    teamid;


-- 4: Write a query retrieves a distinct list of teams that scored goals on 9 June 2012, along with the date of the match.
SELECT DISTINCT
    teamid,
    mdate
FROM
    goal
    JOIN game ON matchid = id
WHERE
    mdate = "9 June 2012";


-- 5: Write a query which would show the player and their team for those who have scored against Poland(POL) in National Stadium, Warsaw.
SELECT DISTINCT
    player,
    teamid
FROM
    goal
    JOIN game ON id = matchid
WHERE
    teamid <> 'POL'
    AND (
        team1 = 'POL'
        OR team2 = 'POL'
    )
    AND stadium = 'National Stadium, Warsaw';


-- 6: Write a query shows the player, their team and the time they scored, for players who have played in Stadion Miejski (Wroclaw) but not against Italy(ITA).
SELECT DISTINCT
    player,
    teamid,
    gtime
FROM
    goal
    JOIN game ON matchid = id
WHERE
    stadium = "Stadion Miejski (Wroclaw)"
    AND (
        teamid = team1
        AND team2 <> "ITA"
    )
    OR (
        teamid = team2
        AND team1 <> "ITA"
    );


-- 7: Write a query that shows the team name and the number of goals they scored, for teams that scored fewer than 3 goals in total.
SELECT
    teamname,
    COUNT(*)
FROM
    eteam
    JOIN goal ON eteam.id = goal.teamid
GROUP BY
    teamname
HAVING
    COUNT(*) < 3