CREATE TABLE t_martina_skutkova_project_SQL_secondary_final AS
SELECT
    c.country,
    c.continent,
    e.year,
    e.gdp,
    e.population,
    e.gini
FROM countries c
JOIN economies e
    ON c.country = e.country
WHERE c.continent = 'Europe'
  AND e.year BETWEEN 2006 AND 2018;