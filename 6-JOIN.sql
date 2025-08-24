-- 1. Modify it to show the matchid and player name for all goals scored by Germany.
-- To identify German players, check for: teamid = 'GER'.
SELECT
    matchid,
    player
FROM
    goal
WHERE
    teamid = 'GER';

-- 2. Show id, stadium, team1, team2 for just game 1012.
SELECT
    id,
    stadium,
    team1,
    team2
FROM
    game
WHERE
    id = 1012;

-- 3. Modify it to show the player, teamid, stadium and mdate for every German goal.
SELECT
    player,
    teamid,
    stadium,
    mdate
FROM
    game
    JOIN goal ON (id = matchid)
WHERE
    teamid = 'GER';

-- 4. Show the team1, team2 and player for every goal scored by a player
-- called Mario player LIKE 'Mario%'.
SELECT
    team1,
    team2,
    player
FROM
    game
    JOIN goal ON (id = matchid)
WHERE
    player LIKE 'Mario%';

-- 5. Show player, teamid, coach, gtime for all goals scored in the first 10 minutes gtime<=10
SELECT
    player,
    teamid,
    coach,
    gtime
FROM
    goal
    JOIN game ON goal.matchid = game.id
    JOIN eteam ON eteam.id = goal.teamid
WHERE
    gtime <= 10;

-- 6. List the dates of the matches and the name of the team
-- in which 'Fernando Santos' was the team1 coach.
SELECT
    mdate,
    team1
FROM
    game
WHERE
    team1 IN (
        SELECT
            id
        FROM
            eteam
        WHERE
            coach = 'Fernando Santos'
    );

SELECT
    mdate,
    teamname
FROM
    game
    JOIN eteam ON game.team1 = eteam.id
WHERE
    eteam.coach = 'Fernando Santos';

-- 7. List the player for every goal scored in a game where
-- the stadium was 'National Stadium, Warsaw'
SELECT
    player
FROM
    goal
    JOIN game ON goal.matchid = game.id
WHERE
    stadium = 'National Stadium, Warsaw';

-- The example query shows all goals scored in the Germany-Greece quarterfinal.
SELECT
    player
FROM
    game
    JOIN goal ON matchid = id
WHERE
    (
        team1 = 'GER'
        AND team2 = 'GRE'
    ) -- 8. Instead show the name of all players who scored a goal against Germany.
SELECT
    player
FROM
    game
    JOIN goal ON matchid = id
WHERE
    (
        team1 = 'GER'
        AND team2 = 'GRE'
    );

SELECT DISTINCT
    player
FROM
    game
    JOIN goal ON matchid = id
WHERE
    goal.teamid <> 'GER'
    AND (
        team1 = 'GER'
        OR team2 = 'GER'
    );

-- 9. Show teamname and the total number of goals scored.
SELECT
    teamname,
    COUNT(*) AS total_goals
FROM
    game
    JOIN goal ON matchid = id
GROUP BY
    teamname;

-- 10. Show the stadium and the number of goals scored in each stadium.
SELECT
    stadium,
    COUNT(*)
FROM
    game
    JOIN goal ON game.id = goal.matchid
GROUP BY
    game.stadium;

-- 11. For every match involving 'POL', show the matchid, date and the number of goals scored.
SELECT
    matchid,
    mdate,
    COUNT(*) AS total_goals
FROM
    game
    JOIN goal ON matchid = id
WHERE
    team1 = 'POL'
    OR team2 = 'POL'
GROUP BY
    matchid,
    mdate;

-- Including matches with zero goals
SELECT
    g.id AS matchid,
    g.mdate,
    COUNT(goal.matchid) AS total_goals
FROM
    game g
    LEFT JOIN goal ON g.id = goal.matchid
WHERE
    g.team1 = 'POL'
    OR g.team2 = 'POL'
GROUP BY
    g.id,
    g.mdate;

-- Poland goals only
SELECT
    g.id AS matchid,
    g.mdate,
    COUNT(
        CASE
            WHEN goal.teamid = 'POL' THEN 1
        END
    ) AS pol_goals
FROM
    game AS g
    LEFT JOIN goal ON goal.matchid = g.id
WHERE
    g.team1 = 'POL'
    OR g.team2 = 'POL'
GROUP BY
    g.id,
    g.mdate;

-- 12. For every match where 'GER' scored,
-- show matchid, match date and the number of goals scored by 'GER'.
SELECT
    matchid,
    mdate,
    COUNT(*)
FROM
    goals
    JOIN game ON goal.matchid = game.id
GROUP BY
    id
HAVING
    id = 'GER';

-- Using LEFT JOIN and CASE
SELECT
    g.id AS matchid,
    g.mdate,
    COUNT(
        CASE
            WHEN goal.teamid = 'GER' THEN 1
        END
    ) AS ger_goals
FROM
    game AS g
    LEFT JOIN goal ON goal.matchid = g.id
WHERE
    g.team1 = 'GER'
    OR g.team2 = 'GER'
GROUP BY
    g.id,
    g.mdate;

-- 13. List every match with the goals scored by each team as shown.
-- This will use "CASE WHEN" which has not been explained in any previous exercises.
-- Sort your result by mdate, matchid, team1 and team2.
-- This works but leaves out matches with no goals.
SELECT
    mdate,
    matchid,
    team1,
    SUM(
        CASE
            WHEN teamid = team1 THEN 1
            ELSE 0
        END
    ) AS score1,
    team2,
    SUM(
        CASE
            WHEN teamid = team2 THEN 1
            ELSE 0
        END
    ) AS score2
FROM
    game
    JOIN goal ON matchid = id
GROUP BY
    matchid,
    mdate,
    team1,
    team2
ORDER BY
    mdate,
    matchid,
    team1,
    team2;

-- Including matches with no goals
SELECT
    mdate,
    matchid,
    team1,
    SUM(
        CASE
            WHEN teamid = team1 THEN 1
            ELSE 0
        END
    ) AS score1,
    team2,
    SUM(
        CASE
            WHEN teamid = team2 THEN 1
            ELSE 0
        END
    ) AS score2
FROM
    game
    LEFT JOIN goal ON matchid = id
GROUP BY
    matchid,
    mdate,
    team1,
    team2
ORDER BY
    mdate,
    matchid,
    team1,
    team2;