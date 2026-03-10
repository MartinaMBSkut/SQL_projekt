--2) Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?

WITH wages AS (
    SELECT
        year,
        AVG(avg_wage) AS avg_wage_all_industries
    FROM (
        SELECT DISTINCT year, industry_branch_code, avg_wage
        FROM t_martina_skutkova_project_SQL_primary_final
    ) x
    GROUP BY year
),
foods AS (
    SELECT DISTINCT
        year,
        category_code,
        category_name,
        avg_price,
        price_value,
        price_unit
    FROM t_martina_skutkova_project_SQL_primary_final
    WHERE category_code IN (111301, 114201)
)
SELECT
    f.year,
    f.category_name,
    w.avg_wage_all_industries,
    f.avg_price,
    ROUND((w.avg_wage_all_industries / f.avg_price)::numeric , 2) AS amount_can_buy,
    f.price_value,
    f.price_unit
FROM foods f
JOIN wages w ON f.year = w.year
WHERE f.year IN (
    (SELECT MIN(year) FROM t_martina_skutkova_project_SQL_primary_final),
    (SELECT MAX(year) FROM t_martina_skutkova_project_SQL_primary_final)
)
ORDER BY f.category_name, f.year;
