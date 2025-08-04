-- ┌────────────┬──────────┬────────┬───────────┬─────────────┐
-- │   name	    │continent │ area   │population │	gdp       │
-- ├────────────┼──────────┼────────┼───────────┼─────────────┤
-- │Afghanistan │Asia      │652230  │25500100   │20343000000  │
-- │Albania     │Europe    │28748   │2831741    │12960000000  │
-- │Algeria     │Africa    │2381741 │37100000   │188681000000 │
-- │Andorra     │Europe    │468     │78115      │3712000000   │
-- │Angola      │Africa    │1246700 │20609294   │100990000000 │
-- │....                                                     │
-- └──────────────────────────────────────────────────────────┘
-- 1. Introducing the `world` table of countries
-- Modify it to show the population of Germany.
SELECT population
FROM world
WHERE NAME = "Germany";
-- 2. Scandinavia
-- Show the name and the population for 'Sweden', 'Norway' and 'Denmark'.
SELECT name,
  population
FROM world
WHERE name IN ("Sweden", "Norway", "Denmark");
-- 3. Just the right size
-- Modify it to show the country and the area for countries with an area between 200,000 and 250,000
SELECT name,
  area
FROM world
WHERE area BETWEEN 2 AND 2.5;
-- SELECT Quiz
-- 1. Select the code which produces this table
SELECT name,
  population
FROM world
WHERE population BETWEEN 1000000 AND 1250000;
--2. Pick the result you would obtain from this code
--3. Select the code which shows the countries that end in A or L
SELECT name
FROM world
WHERE name LIKE '%a'
  OR name LIKE '%l';
-- 4. Pick the result from the query
SELECT name,
  length(name)
FROM world
WHERE length(name) = 5
  AND region = 'Europe';
-- 5. Here are the first few rows of the world table
-- Pick the result you would obtain from this code:
SELECT name,
  area * 2
FROM world
WHERE population = 64000;
--6. Select the code that would show the countries with an area larger than 50000 and a population smaller than 10000000
SELECT name,
  area,
  population
FROM world
WHERE area > 50000
  AND population < 10000000;
-- 7. Select the code that shows the population density of China, Australia, Nigeria and France
SELECT name,
  population / area AS density
FROM world
WHERE name IN ("China", "Australia", "Nigeria", "France");