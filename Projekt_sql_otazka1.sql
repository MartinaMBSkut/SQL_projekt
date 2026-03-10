--1) Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?

WITH wages AS (
    SELECT DISTINCT
        year,
        industry_branch_code,
        industry_branch_name,
        avg_wage
    FROM t_martina_skutkova_project_SQL_primary_final
),
wages_growth AS (
    SELECT
        year,
        industry_branch_code,
        industry_branch_name,
        avg_wage,
        LAG(avg_wage) OVER (
            PARTITION BY industry_branch_code
            ORDER BY year
        ) AS prev_wage
    FROM wages
)
SELECT
    year,
    industry_branch_name,
    avg_wage,
    prev_wage,
    ROUND((avg_wage - prev_wage) / prev_wage * 100, 2) AS wage_growth_pct
FROM wages_growth
WHERE prev_wage IS NOT NULL
ORDER BY industry_branch_name, year;