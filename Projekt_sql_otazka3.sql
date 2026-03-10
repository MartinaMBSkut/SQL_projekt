--3) Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)? 

WITH prices AS (
    SELECT DISTINCT
        year,
        category_code,
        category_name,
        avg_price
    FROM t_martina_skutkova_project_SQL_primary_final
),
price_growth AS (
    SELECT
        year,
        category_code,
        category_name,
        avg_price,
        LAG(avg_price) OVER (
            PARTITION BY category_code
            ORDER BY year
        ) AS prev_price
    FROM prices
)
SELECT
    category_name,
    ROUND(AVG(((avg_price - prev_price) / prev_price * 100)::numeric), 2) AS avg_yoy_growth_pct
FROM price_growth
WHERE prev_price IS NOT NULL
GROUP BY category_name
ORDER BY avg_yoy_growth_pct ASC;

SELECT
    year,
    avg_price
FROM t_martina_skutkova_project_sql_primary_final
WHERE category_name = 'Cukr krystalový'
ORDER BY year;