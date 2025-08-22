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
-- 1. Total world population
-- Show the total population of the world.
SELECT SUM(population)
FROM world;

-- 2. You might want to look at these examples first
-- List all the continents - just once each.
SELECT UNIQUE(continent)
FROM world;

SELECT continent
FROM world
GROUP BY continent;

-- 3. GDP of Africa
-- Give the total GDP of Africa
SELECT sum(gdp)
FROM world
WHERE continent = 'Africa';

-- 4. Count the big countries
-- How many countries have an area of at least 1000000
SELECT COUNT(name)
FROM world
WHERE area >= 1000000;

-- 5. Baltic states population
-- What is the total population of ('Estonia', 'Latvia', 'Lithuania')
SELECT sum(population)
FROM world
WHERE name IN ('Estonia', 'Latvia', 'Lithuania');

-- 6. Counting the countries of each continent
-- For each continent show the continent and number of countries.
SELECT continent,
    COUNT(name)
FROM world
GROUP BY continent;

-- 7. Counting big countries in each continent
-- For each continent show the continent and number of countries with populations
-- of at least 10 million.
SELECT continent,
    COUNT(name)
FROM world
WHERE population >= 10000000
GROUP BY continent;

-- 8. Counting big continents
-- List the continents that have a total population of at least 100 million.
SELECT continent
FROM world
GROUP BY continent
HAVING sum(population) >= 100000000;

-- Using SUM, Count, MAX, DISTINCT and ORDER BY
-- 1. The total population and GDP of Europe.
SELECT sum(population),
    sum(gdp)
FROM world
WHERE continent = 'Europe';

-- 2. What are the regions?
-- DISTINCT is part of the SQL standard.
SELECT DISTINCT continent
FROM world;

-- UNIQUE is a MySQL extension.
SELECT UNIQUE(continent)
FROM world;

-- 3. Show the name and population for each country with a population
-- of more than 100000000.
-- Show countries in descending order of population.
SELECT name,
    population
FROM world
WHERE population > 100000000
ORDER BY population DESC;