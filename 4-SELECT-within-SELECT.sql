-- ┌────────────┬──────────┬────────┬───────────┬─────────────┐
-- │   name	    │continent │ area   │population │	gdp       │
-- ├────────────┼──────────┼────────┼───────────┼─────────────┤
-- │Afghanistan │Asia      │652230  │25500100   │20343000000  │
-- │Albania     │Europe    │28748   │2831741    │12960000000  │
-- │Algeria     │Africa    │2381741 │37100000   │188681000000 │
-- │Andorra     │Europe    │468     │78115      │3712000000   │
-- │Angola      │Africa    │1246700 │20609294   │100990000000 │
-- │....                                                      │
-- └──────────────────────────────────────────────────────────┘
-- 1. Bigger than Russia
-- List each country name where the population is larger than that of 'Russia'.
SELECT name
FROM world
WHERE population > (
        SELECT population
        FROM world
        WHERE name = 'Russia'
    );

-- 2. Richer than UK
-- Show the countries in Europe with a per capita GDP greater than 'United Kingdom'.
SELECT name
FROM world
WHERE continent = 'Europe'
    AND gdp / population > (
        SELECT gdp / population
        FROM world
        WHERE name = 'United Kingdom'
    );

-- 3. Neighbours of Argentina and Australia
-- List the name and continent of countries in the continents containing either Argentina or Australia. Order by name of the country.
SELECT name,
    continent
FROM world
WHERE continent IN (
        SELECT continent
        FROM world
        WHERE name IN ('Argentina', 'Australia')
    )
ORDER BY name;

-- 4. Between Canada and Poland
-- Which country has a population that is more than United Kingdom but less than Germany?
-- Show the name and the population.
SELECT name,
    population
FROM world
WHERE population > (
        SELECT population
        FROM world
        WHERE name = 'United Kingdom'
    )
    AND population < (
        SELECT population
        FROM world
        WHERE name = 'Germany'
    );

-- 5. Percentages of Germany
-- Show the name and the population of each country in Europe.
-- Show the population as a percentage of the population of Germany.
SELECT name,
    CONCAT(
        ROUND(
            100 * population / (
                SELECT population
                FROM world
                WHERE name = 'Germany'
            ),
            0
        ),
        '%'
    ) AS percentage
FROM world
WHERE continent = 'Europe';

-- Another way (incorrect)
WITH Germany AS (
    SELECT *
    FROM world
    WHERE name = 'Germany'
)
SELECT name,
    CONCAT(
        ROUND(100 * population / Germany.population, 0),
        '%'
    ) AS percentage
FROM world
WHERE continent = 'Europe';

-- Another way (correct), using JOIN
WITH Germany AS (
    SELECT *
    FROM world
    WHERE name = 'Germany'
)
SELECT name,
    CONCAT(
        ROUND(100 * population / Germany.population, 0),
        '%'
    ) AS percentage
FROM world
WHERE continent = 'Europe'
    CROSS JOIN Germany;

-- Another way (CTE)
WITH EuropePopulation AS (
    -- Step 1: Get the population for each country in Europe
    SELECT name,
        population
    FROM world
    WHERE continent = 'Europe'
),
GermanyPopulation AS (
    -- Step 2: Get Germany's population as a single value
    SELECT population AS germany_population
    FROM world
    WHERE name = 'Germany'
) -- Step 3: Combine the data and calculate the percentage
SELECT E.name,
    CONCAT(
        ROUND(100 * E.population / G.germany_population, 0),
        '%'
    ) AS percentage
FROM EuropePopulation AS E
    CROSS JOIN GermanyPopulation AS G;

-- 6. Bigger than every country in Europe
-- Which countries have a GDP greater than every country in Europe? [Give the name only.]
-- (Some countries may have NULL gdp values)
SELECT name
FROM world
WHERE gdp > ALL (
        SELECT gdp
        FROM world
        WHERE continent = 'Europe'
            AND gdp IS NOT NULL
    );

SELECT name
FROM world
WHERE gdp > (
        SELECT MAX(gdp)
        FROM world
        WHERE continent = 'Europe'
    );

-- 7. Largest in each continent
-- Find the largest country (by area) in each continent, show the continent, the name and the area
SELECT continent,
    name,
    area
FROM world
WHERE area >= ALL (
        SELECT area
        FROM world AS w2
        WHERE w2.continent = w2.continent
            AND area > 0
    )
-- 8. First country of each continent (alphabetically)
-- List each continent and the name of the country that comes first alphabetically.
SELECT continent,
    MIN(name) AS name
FROM world
GROUP BY continent;

-- Matching to subquery
SELECT continent,
    name
FROM world
WHERE (continent, name) IN (
        SELECT continent,
            MIN(name)
        FROM world
        GROUP BY continent
    );

-- Using a CTE
WITH FirstCountryPerContinent AS (
    SELECT continent,
        MIN(name) AS name
    FROM world
    GROUP BY continent
)
SELECT continent,
    name
FROM FirstCountryPerContinent;

-- Note
SELECT UNIQUE(continent)
FROM world;

-- works the same as
SELECT continent
FROM world
GROUP BY continent;

-- 9. Difficult Questions That Utilize Techniques Not Covered In Prior Sections
-- Find the continents where all countries have a population <= 25000000.
-- Then find the names of the countries associated with these continents.
-- Show name, continent and population.
SELECT name,
    continent,
    population
FROM world
WHERE continent IN (
        SELECT continent
        FROM world
        GROUP BY continent
        HAVING MAX(population) <= 25000000
    );

-- Using CTE
WITH ContinentsWithSmallPopulation AS (
    SELECT continent
    FROM world
    GROUP BY continent
    HAVING MAX(population) <= 25000000
)
SELECT name,
    continent,
    population
FROM world
WHERE continent IN (
        SELECT continent
        FROM ContinentsWithSmallPopulation
    );

-- 10. Three time bigger
-- Some countries have populations more than three times
-- that of all of their neighbours (in the same continent).
-- Give the countries and continents.
SELECT name,
    continent
FROM world AS w1
WHERE population > 3 ALL (
        SELECT population
        FROM world AS w2
        WHERE w1.continent = w2.continent
            AND w1.name != w2.name
            AND w2.population > 0
    )
SELECT name,
    continent
FROM world x
WHERE population > 3 * ALL (
        SELECT population
        FROM world y
        WHERE y.continent = x.continent
            AND population > 0
    );