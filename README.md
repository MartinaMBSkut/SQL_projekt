# Projekt: Cílem je zjistit dostupnost základních potravin široké veřejnosti.

## Zadání

Úkolem bylo připravit robustní datové podklady, podle kterých se bude porovnávat dostupnost potravin za základě průměrných příjmů za určité časové období v ČR. K tomu připravit i  tabulku s HDP, GINI koeficientem a populací dalších evropských států ve stejném období, jako primární přehled pro ČR. Z takto připravených dat poté provést analýzu a zodpovědět 5 otázek:
1. Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?
2. Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd*
3. Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?
4. Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?
5. Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo následujícím roce výraznějším růstem?

## Příprava dat a popis nesrovnalostí

1. Nejprve jsem si zkontrolovala jaké mám roky v czechia_payroll a czechia_price. Z dat jsem našla, že roky 2006-2014 mají 26 kategorií, a roky 2015 - 2018 mají 27 kategorií. Potvrdila jsem si průnik období které budu analyzovat na rok 2006 – 2018. 
Pozn.při výpočtu meziročních změn je však první rok (2006) vynechán, protože pro něj neexistuje hodnota předchozího roku potřebná pro výpočet růstu.
2. Následně jsem si ověřovala podle čeho budu mzdy filtrovat. V datech se vyskytla záměna na unit_name (neodpovídá kč, počet zaměstnanců) Stanovila jsem si je dle min, max a průměru. Value_type_code: 316 je počet zaměstnanců (ks), 5958 - průměrná hrubá mzda (kč) a calculation_code: 100 - fyzický počet zaměstnanců, 200 - přepočítáno na pracovní úvazky, aby výsledky nezkreslovali realitu. Potvrdila jsem si filtry pro analýzu:  pro mzdy value_type_code 5958 a pro výpočet calculation_code 200.
3. Zjistila jsem si kódy, price_value a price_unit pro chléb a mléko. Chléb konzumní kmínový – 111301, 1kg a Mléko polotučné pasterované – 114201, 1l.
4. Před vytvořením hlavních tabulek jsem si připravila mezikroky. Nejprve payroll_priprava. Ve virtuální tabulce jsem vyfiltrovala správný typ mezd, převedla na roční průměrnou mzdu dle odvětví (ze čtvrtletí na rok),   doplnila názvy odvětví. Vzniklo mi 1 rok + 1 odvětví. 
Pak price_priprava. V druhé virtuální tabulce jsem vybrala z datumu rok, připojila kódy a kategorie potravin, množství a jednotky, vypočítala roční průměrné ceny. Vzniklo mi  1 rok + 1 potravina. U obou jsem zkontrolovala duplicity a byly 0.
5. Vytvořila jsem tabulky primary_final a secondary_final. V tabulce secondary_final jsem našla chybějící data.
Hodnoty gdp nemají 3 země v letech 2006 - 2018 (37záznamů chybí): Gibraltar, Faroe Islands, Liechtenstein.
Hodnoty GINI koef nemá 18 zemí v některých letech 2006 - 2018 (124záznamů chybí): Albania, Andorra, Bosnia a Herzegovina, Croatia, Faroe Islands, Germany, Gibraltar, Iceland, Ireland, Italy, Liechtenstein, Monaco, Montenegro, North Macedonia, San Marino, Serbia, Slovakia, United Kingdom

## Odpovědi na výzkumné otázky
### Otázka 1: Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?
Máme celkem 19 odvětví. Analýza mezd v jednotlivých odvětví ukazuje, že mezi lety 2007 – 2018 měli rostoucí trend (když porovnám počáteční a koncové hodnoty). Růst však není plynulý. V některých odvětvích se objevily i meziroční poklesy. K nejvýraznějším poklesům došlo v roce 2013 např. v odvětví Peněžnictví a pojišťovnictví -8,83%. Obecně rok 2013 znamenal pro řadu oblastí stagnaci nebo pokles. Naopak v letech 2017 a 2018 došlo ve většině odvětví k růstu mezi 5-10% a ukazuje růstový trend.

<img width="1037" height="1202" alt="image" src="https://github.com/user-attachments/assets/89254bc7-ba9d-4f18-bf5b-8e7539ef47b4" />

### Otázka 2: Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?
Z tabulky je vidět výsledné množství které šlo koupit v letech 2006 a 2018 - chleba 1312kg->1365kg, mléko 1466l->1670l. Mezi lety 2006 – 2018 vzrostla průměrná mzda o 56%, cena chleba o 50% a cena mléka cca o 37%. Růst mezd je tedy rychlejší než růst těchto potravin, což vedlo k mírnému zvýšení kupní síly průměrné mzdy. Kupní síla mléka vzrostla cca o 14% protože cena rostla pomaleji než u chleba. Tam vychází kupní síla 4%.

<img width="945" height="155" alt="image" src="https://github.com/user-attachments/assets/b785bef5-0f63-45a4-b06f-78db78b39ef8" />

### Otázka 3: Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)? 
Nejpomalejší růst měl Cukr krystalový -1,92% . Jelikož je hodnota záporná -  potravina v průměru zlevňovala. Další nejmenší nárůst je u Rajských jablek a banánech.
<img width="911" height="366" alt="image" src="https://github.com/user-attachments/assets/0d73b290-f1b8-4df7-82da-ba91553535f7" />
<img width="402" height="610" alt="image" src="https://github.com/user-attachments/assets/5ce136f9-1a6d-4dc9-9290-68952b9364f7" />

### Otázka 4: Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?
V analyzovaném období 2007 – 2018 nebyl nalezen rok, ve kterém by meziroční růst cen potravin převýšil růst mezd o více než 10%.  Největší rozdíl je v letech 2013 kdy ceny rostly rychleji než mzdy (+6,65%). A v době krize v roce 2009 ceny rostly pomaleji než mzdy  (- 9,49%) .

<img width="945" height="401" alt="image" src="https://github.com/user-attachments/assets/dfccaa83-d2e0-41f2-9395-f224fe0c50a2" />

### Otázka 5: Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo následujícím roce výraznějším růstem?
Vidím zde souvislost  - při růstu HDP rostou mzdy.
Při poklesu HDP ceny dochází ke zpomalení růstu mezd a poklesu cen. Naopak v období ekonomického růstu rostou jak mzdy tak ceny.
Pro vizuální přehled jsem data vložila do grafu. Krizový rok 2009 – HDP padá, ceny také a růst mezd se zpomaluje a stagnuje. Naopak v období ekonomického růstu například rok 2017 rostou mzdy i ceny současně.

<img width="945" height="415" alt="image" src="https://github.com/user-attachments/assets/79b7224c-e746-459d-92c2-9860d4189a6d" />
<img width="943" height="529" alt="image" src="https://github.com/user-attachments/assets/baabdba9-98c7-4ad2-aa16-1b8b047a6232" />













