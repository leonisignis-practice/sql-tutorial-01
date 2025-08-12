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
-- 1. Introduction
-- Observe the result of running this SQL command to show the name, continent and population of all countries.
SELECT name,
    continent,
    population
FROM world;

-- 2. Large Countries
-- Show the name for the countries that have a population of at least 200 million. 200 million is 200000000, there are eight zeros.
SELECT name
FROM world
WHERE population >= 200000000;

-- 3. Per capita GDP
-- Give the name and the per capita GDP for those countries with a population of at least 200 million.
SELECT name,
    gdp / population AS "per capita GDP"
FROM world
WHERE population >= 200000000;

-- 4. South America In millions
-- Show the name and population in millions for the countries of the continent 'South America'.
SELECT name,
    population / 1000000 AS population
FROM world
WHERE continent = "South America";

-- 5. France, Germany, Italy
-- Show the name and population for France, Germany, Italy
SELECT name,
    population
FROM world
WHERE name IN ("France", "Germany", "Italy");

-- 6. United
-- Show the countries which have a name that includes the word 'United'
SELECT name
FROM world
WHERE name LIKE '%United%';

-- 7. Two ways to be big
-- Show the countries that are big by area or big by population. Show name, population and area.
SELECT name,
    population,
    area
FROM world
WHERE population >= 250000000
    OR area >= 3000000;

-- 8. One or the other (but not both)
-- Show the countries that are big by area (more than 3 million) or big by population (more than 250 million) but not both.
-- Show name, population and area.
SELECT name,
    population,
    area
FROM world
WHERE (
        population >= 250000000
        AND area < 3000000
    )
    OR (
        population < 250000000
        AND area >= 3000000
    );

-- 9. Rounding
-- For Americas show population in millions and GDP in billions both to 2 decimal places.
SELECT name,
    ROUND(population / 1000000, 2) AS population,
    ROUND(gdp / 1000000000, 2) AS gdp
FROM world
WHERE continent = "South America";

-- 10. Trillion dollar economies
-- Show per-capita GDP for the trillion dollar countries to the nearest $1000
SELECT name,
    ROUND(gdp / population, -3) AS "per capita GDP"
FROM world
WHERE gdp >= 1000000000000;

-- 11. Name and capital have the same length
-- Show the name and capital where the name and the capital have the same number of characters.
SELECT name,
    capital
FROM world
WHERE LENGTH(name) = LENGTH(capital);

-- 12. Matching name and capital
--Show the name and the capital where the first letters of each match.
-- Don't include countries where the name and the capital are the same word.
SELECT name,
    capital
FROM world
WHERE (name <> capital)
    AND (LEFT(name, 1) = LEFT(capital, 1));

-- 13. All the vowels
-- Find the country that has all the vowels and no spaces in its name.
SELECT name
FROM world
WHERE name NOT LIKE '% %'
    AND name LIKE '%a%'
    AND name LIKE '%e%'
    AND name LIKE '%i%'
    AND name LIKE '%o%'
    AND name LIKE '%u%';