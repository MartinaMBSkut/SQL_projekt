--4) Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?

WITH wages AS (
    SELECT
        year,
        AVG(avg_wage) AS avg_wage
    FROM (
        SELECT DISTINCT year, industry_branch_code, avg_wage
        FROM t_martina_skutkova_project_SQL_primary_final
    ) x
    GROUP BY year
),
prices AS (
    SELECT
        year,
        AVG(avg_price) AS avg_price
    FROM (
        SELECT DISTINCT year, category_code, avg_price
        FROM t_martina_skutkova_project_SQL_primary_final
    ) x
    GROUP BY year
),
combined AS (
    SELECT
        w.year,
        w.avg_wage,
        p.avg_price,
        LAG(w.avg_wage) OVER (ORDER BY w.year) AS prev_wage,
        LAG(p.avg_price) OVER (ORDER BY p.year) AS prev_price
    FROM wages w
    JOIN prices p ON w.year = p.year
)
SELECT
    year,
    ROUND(((avg_wage - prev_wage) / prev_wage * 100)::numeric, 2) AS wage_growth_pct,
    ROUND(((avg_price - prev_price) / prev_price * 100)::numeric, 2) AS price_growth_pct,
    ROUND((
        ((avg_price - prev_price) / prev_price * 100)
        -
        ((avg_wage - prev_wage) / prev_wage * 100)
    )::numeric, 2) AS difference_pct_points
FROM combined
WHERE prev_wage IS NOT NULL
  AND prev_price IS NOT NULL
ORDER BY year;

