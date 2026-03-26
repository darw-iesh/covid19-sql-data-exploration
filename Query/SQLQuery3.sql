USE covid_19
-- THE SCOEND TABLE ([CovidVaccinations])
-- LOOKING AT TOTAL POPULATION VS TOTALE VACCINATIONS 
SELECT 
	CD.continent,
	CD.location,
	CD.date,
	CD.population,
	CV.new_vaccinations,
	SUM(CONVERT(int,CV.new_vaccinations))OVER(PARTITION BY CD.location ORDER BY CD.location) AS RollingPeopleVaccinted
FROM CovidDeaths AS CD
JOIN CovidVaccinations AS CV 
	ON CD.location = CV.location 
	   and 
	   CD.date = CV.date
WHERE CD.continent IS NOT NULL
ORDER BY 2,3

-- USING CTE 
-- USING CTE
WITH PopvsVac AS (
    SELECT 
        CD.continent,
        CD.location,
        CD.date,
        CD.population,
        CV.new_vaccinations,
        SUM(CONVERT(INT, CV.new_vaccinations)) OVER (
            PARTITION BY CD.location 
            ORDER BY CD.location, CD.date  -- ORDER BY inside OVER() is fine
        ) AS RollingPeopleVaccinated
    FROM CovidDeaths AS CD
    JOIN CovidVaccinations AS CV 
        ON CD.location = CV.location 
        AND CD.date = CV.date
    WHERE CD.continent IS NOT NULL
)
-- Query the CTE
SELECT 
    *,
    ROUND((CAST(RollingPeopleVaccinated AS FLOAT) / CAST(population AS DECIMAL)) * 100, 2) 
        AS PercentPopulationVaccinated
FROM PopvsVac
ORDER BY 2, 3;  -- ORDER BY goes here, outside the CTE