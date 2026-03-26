USE covid_19
-- FIRST TABLE (CovidDeaths)
SELECT *
FROM CovidDeaths
WHERE continent IS NOT NULL
ORDER BY 1,2

-- TOTAL CASES VS TOTAL DEATHS In Africa
SELECT 
     location,
     date,
	 total_cases,
	 total_deaths,
  	 ROUND((CAST(total_deaths as FLOAT)/cast(total_cases as DECIMAL))*100 , 2) AS DeathPercentage
FROM CovidDeaths
WHERE continent IS NOT NULL AND location = 'Egypt'
ORDER BY DeathPercentage DESC

-- TOTAL CASES VS POPULATION In EGYPT
SELECT 
     location,
     date,
	 population,
	 total_cases,
  	 ROUND((CAST(total_cases as DECIMAL)/cast(population as DECIMAL))*100 , 2) AS PercentagePopulationInfaction
FROM CovidDeaths
WHERE continent IS NOT NULL AND location = 'Egypt'
ORDER BY 1,2
 
-- Looking at Countries with the highest Infection Rate compared to population
SELECT 
     location,
	 population,
	 MAX(total_cases) AS HighestInfectionCount,
	 ROUND(MAX(
		 (CAST(total_cases as DECIMAL)/CAST(population as DECIMAL)))*100 ,2) AS PercentPopulationInfected
FROM CovidDeaths
GROUP BY location, population
ORDER BY PercentPopulationInfected DESC;


-- Showing continents with the highest death count per population 
SELECT 
     continent,
	 --population,
	 MAX(total_deaths) AS TotalDeathCount
FROM CovidDeaths
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY TotalDeathCount DESC;

-- GLOBAL NUMBERS
SELECT 
     SUM(new_cases)                    AS TotalNewCases,
     SUM(new_deaths)                   AS TotalNewDeaths,
     ROUND(
         (SUM(CAST(new_deaths AS FLOAT)) / NULLIF(SUM(CAST(new_cases AS DECIMAL)), 0)) * 100
     , 2)                              AS DeathPercentage
FROM CovidDeaths
WHERE continent IS NOT NULL
-- GROUP BY date
ORDER BY 1, 2;