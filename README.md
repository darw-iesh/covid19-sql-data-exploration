# co# 🦠 COVID-19 Data Exploration with SQL Server

A data exploration project using SQL Server to analyze global COVID-19 trends including infection rates, death percentages, and vaccination progress. This project was built by following the [Alex The Analyst tutorial](https://youtu.be/qfyynHBFOsM?si=NsELZnou_W2Mt6nB) with additional customizations and improvements.

---

## 📁 Datasets Used

| Table | Description |
|---|---|
| `CovidDeaths` | Contains data on COVID-19 cases, deaths, and population by country and date |
| `CovidVaccinations` | Contains data on new vaccinations administered by country and date |

> Source: [Our World in Data](https://ourworldindata.org/covid-deaths)

---

## 🛠️ Tools & Technologies

- **Database:** Microsoft SQL Server
- **Language:** T-SQL (Transact-SQL)
- **Concepts Used:** Aggregate Functions, JOINs, CTEs, Window Functions, CAST/CONVERT, NULLIF, GROUP BY

---

## 📊 Queries & Analysis

### 1. 🔍 Basic Data Exploration
Retrieve all records from the `CovidDeaths` table ordered by location and date, filtering out rows where continent is NULL.

---

### 2. 💀 Total Cases vs Total Deaths (Egypt)
Calculate the **death percentage** per day in Egypt to understand the likelihood of dying if infected.

```sql
ROUND((CAST(total_deaths AS FLOAT) / CAST(total_cases AS DECIMAL)) * 100, 2) AS DeathPercentage
```

---

### 3. 🧍 Total Cases vs Population (Egypt)
Calculate what **percentage of Egypt's population** was infected with COVID-19 over time.

```sql
ROUND((CAST(total_cases AS DECIMAL) / CAST(population AS DECIMAL)) * 100, 2) AS PercentagePopulationInfected
```

---

### 4. 🌍 Highest Infection Rate by Country
Identify which countries had the **highest infection rate** relative to their population.

```sql
MAX(total_cases) AS HighestInfectionCount,
ROUND(MAX((CAST(total_cases AS DECIMAL) / CAST(population AS DECIMAL))) * 100, 2) AS PercentPopulationInfected
```

---

### 5. ☠️ Highest Death Count by Continent
Show which continents had the **highest total death count**, filtering out aggregated/global rows using `WHERE continent IS NOT NULL`.

---

### 6. 🌐 Global Numbers
Aggregate **worldwide totals** for new cases, new deaths, and overall death percentage using `SUM()` with `NULLIF` to prevent division by zero.

```sql
ROUND(
    (SUM(CAST(new_deaths AS FLOAT)) / NULLIF(SUM(CAST(new_cases AS DECIMAL)), 0)) * 100
, 2) AS DeathPercentage
```

---

### 7. 💉 Total Population vs Vaccinations (Rolling Count)
Join `CovidDeaths` and `CovidVaccinations` to track a **rolling count of vaccinated people** per country using a window function.

```sql
SUM(CONVERT(INT, CV.new_vaccinations)) OVER (
    PARTITION BY CD.location
    ORDER BY CD.location, CD.date
) AS RollingPeopleVaccinated
```

---

### 8. 📈 Percent Population Vaccinated (CTE)
Use a **Common Table Expression (CTE)** to calculate what percentage of each country's population has been vaccinated over time.

```sql
WITH PopvsVac AS (
    -- Rolling vaccination count per country
)
SELECT *,
    ROUND((CAST(RollingPeopleVaccinated AS FLOAT) / CAST(population AS DECIMAL)) * 100, 2)
        AS PercentPopulationVaccinated
FROM PopvsVac
ORDER BY 2, 3;
```

---

## 💡 Key SQL Concepts Demonstrated

- **Window Functions** — `SUM() OVER (PARTITION BY ... ORDER BY ...)` for rolling totals
- **CTEs** — `WITH ... AS (...)` to structure complex queries cleanly
- **Aggregate Functions** — `SUM()`, `MAX()` with `GROUP BY`
- **Type Casting** — `CAST()` and `CONVERT()` to handle decimal division correctly
- **NULLIF** — Prevents division-by-zero errors
- **JOINs** — Combining two tables on `location` and `date`
- **Filtering** — `WHERE continent IS NOT NULL` to exclude global/continental aggregates

---

## ⚠️ Common Errors Fixed in This Project

| Error | Fix |
|---|---|
| `Column invalid in SELECT` not in GROUP BY | Added missing columns to `GROUP BY` clause |
| `Cannot perform aggregate on aggregate` | Separated `SUM()` calls and divided results after aggregation |
| `ORDER BY invalid in CTE` | Moved `ORDER BY` outside the CTE into the final query |

---

## 🚀 How to Run

1. Download the dataset from [Our World in Data](https://ourworldindata.org/covid-deaths)
2. Import `CovidDeaths` and `CovidVaccinations` into SQL Server as separate tables
3. Open the `.sql` file in SQL Server Management Studio (SSMS)
4. Execute queries one section at a time using the comment headers as guides

---

## 🎓 Credits

- Tutorial by **Alex The Analyst**: [Watch on YouTube](https://youtu.be/qfyynHBFOsM?si=NsELZnou_W2Mt6nB)
- Personal customizations: Added Egypt-specific analysis and fixed SQL errors along the way

---

## 📬 Contact

Feel free to connect or reach out if you have questions or suggestions!

