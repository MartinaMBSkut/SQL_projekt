--mezikrok připrava mzdy/odvětví ==> 1rok + 1 odvětví
--filtrace spravného typu mezd, převedení na roční průměrnou mzdu podle odvětví (ze čtvrtletí na rok), doplnění názvů odvětví
CREATE VIEW v_martina_skutkova_payroll_priprava AS
SELECT
    cp.payroll_year AS year,
    cp.industry_branch_code,
    ib.name AS industry_branch_name,
    AVG(cp.value) AS avg_wage
FROM czechia_payroll cp
JOIN czechia_payroll_industry_branch ib
    ON cp.industry_branch_code = ib.code
WHERE cp.value_type_code = 5958
  AND cp.calculation_code = 200
  AND cp.value IS NOT NULL
GROUP BY
    cp.payroll_year,
    cp.industry_branch_code,
    ib.name;

--mezikrok připrava cen ==> 1 rok + 1 potravina
--z datumu mam rok, připojení kódu a kategorie potravin, množstvi a jednotky, výpočet roční průměrné ceny 
CREATE VIEW v_martina_skutkova_price_priprava AS
SELECT
    EXTRACT(YEAR FROM cp.date_from) AS price_year,
    cp.category_code,
    cpc.name AS category_name,
    cpc.price_value,
    cpc.price_unit,
    AVG(cp.value) AS avg_price
FROM czechia_price cp
JOIN czechia_price_category cpc
    ON cp.category_code = cpc.code
GROUP BY
    EXTRACT(YEAR FROM cp.date_from),
    cp.category_code,
    cpc.name,
    cpc.price_value,
    cpc.price_unit;


--vytvoření tabulky primary_final

CREATE TABLE t_martina_skutkova_project_SQL_primary_final AS
SELECT
    p.year,
    p.industry_branch_code,
    p.industry_branch_name,
    p.avg_wage,
    pr.category_code,
    pr.category_name,
    pr.price_value,
    pr.price_unit,
    pr.avg_price
FROM v_martina_skutkova_payroll_priprava p
JOIN v_martina_skutkova_price_priprava pr
    ON p.year = pr.price_year
WHERE p.year BETWEEN 2006 AND 2018;