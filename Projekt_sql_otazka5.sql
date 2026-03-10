--5) Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo následujícím roce výraznějším růstem?

WITH czech_gdp AS (
    SELECT
        year,
        gdp,
        LAG(gdp) OVER (ORDER BY year) AS prev_gdp
    FROM t_martina_skutkova_project_SQL_secondary_final
    WHERE country = 'Czech Republic'
),
wages AS (
    SELECT
        year,
        AVG(avg_wage) AS avg_wage,
        LAG(AVG(avg_wage)) OVER (ORDER BY year) AS prev_wage
    FROM (
        SELECT DISTINCT year, industry_branch_code, avg_wage
        FROM t_martina_skutkova_project_SQL_primary_final
    ) x
    GROUP BY year
),
prices AS (
    SELECT
        year,
        AVG(avg_price) AS avg_price,
        LAG(AVG(avg_price)) OVER (ORDER BY year) AS prev_price
    FROM (
        SELECT DISTINCT year, category_code, avg_price
        FROM t_martina_skutkova_project_SQL_primary_final
    ) x
    GROUP BY year
)
SELECT
    g.year,
    ROUND(((g.gdp - g.prev_gdp) / g.prev_gdp * 100)::numeric, 2) AS gdp_growth_pct,
    ROUND(((w.avg_wage - w.prev_wage) / w.prev_wage * 100)::numeric, 2) AS wage_growth_pct,
    ROUND(((p.avg_price - p.prev_price) / p.prev_price * 100)::numeric, 2) AS price_growth_pct
FROM czech_gdp g
JOIN wages w ON g.year = w.year
JOIN prices p ON g.year = p.year
WHERE g.prev_gdp IS NOT NULL
  AND w.prev_wage IS NOT NULL
  AND p.prev_price IS NOT NULL
ORDER BY g.year;