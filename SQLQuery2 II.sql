/*
	Covid 19 Data Exploration 

	Statements used: Joins, CTE's, Temp Tables, Windows Functions, Aggregate Functions, Creating Views, Converting Data Types
*/

	
	SELECT *
	FROM SQL_PROJECTS..[Covid Deaths]
	WHERE CONTINENT IS NOT NULL
	

	-- THE DATA SELECTED FOR EXPLORATION
	
	SELECT LOCATION, DATE, TOTAL_CASES, NEW_CASES, TOTAL_DEATHS, POPULATION
		FROM SQL_PROJECTS..[Covid Deaths]
		WHERE CONTINENT IS NOT NULL
		ORDER BY 1,2
	

--DEATH RATE IN A SELECTED COUNTRY
--Shows likelihood of dying if you contract covid in Ghana
		
			SELECT LOCATION, DATE, TOTAL_CASES, NEW_CASES, 
				CAST(TOTAL_DEATHS AS INT) AS TOTAL_DEATHS, POPULATION, 
					(CAST(TOTAL_DEATHS AS INT)/(TOTAL_CASES)) * 100 AS DEATH_RATE
						FROM SQL_PROJECTS..[Covid Deaths]
						 WHERE LOCATION= 'GHANA' 
						  AND CONTINENT IS NOT NULL AND TOTAL_CASES IS NOT NULL
							ORDER BY 1,2
						

--INFECTION RATE OF COVID IN A SELECTED COUNTRY
--Shows what percentage of the population is infected with Covid in Ghana.	
			
				SELECT LOCATION, DATE, CAST (TOTAL_CASES AS INT) AS TOTAL_CASES, NEW_CASES, 
					CAST (TOTAL_DEATHS AS INT) AS TOTAL_DEATHS, POPULATION, 
					(TOTAL_CASES/POPULATION) * 100 AS INFECTION_RATE
						FROM SQL_PROJECTS..[Covid Deaths]
						 WHERE LOCATION= 'GHANA' 
						  AND CONTINENT IS NOT NULL AND TOTAL_CASES IS NOT NULL
							ORDER BY 1,2 
							

--Countries with Highest Infection Rate based on their respective Populations
			
		SELECT LOCATION, POPULATION, MAX(CAST(TOTAL_CASES AS INT)) AS INFECTIONS,
							MAX(CAST(TOTAL_CASES AS INT)/POPULATION) * 100 AS INFECTION_RATE
								FROM SQL_PROJECTS..[Covid Deaths]
								 GROUP BY LOCATION, POPULATION 
									ORDER BY INFECTION_RATE DESC

				

--Countries with Highest Death count

	
			SELECT LOCATION, MAX(CAST(TOTAL_DEATHS AS INT)) AS DECEASED
								FROM SQL_PROJECTS..[Covid Deaths]
								WHERE CONTINENT IS NOT NULL
								AND LOCATION NOT IN('WORLD', 'AFRICA', 'EUROPE', 'ASIA',
								  'HIGH INCOME', 'UPPER MIDDLE INCOME', 'NORTH AMERICA',
								  'SOUTH AMERICA', 'LOWER MIDDLE INCOME', 'EUROPEAN UNION',
								    'LOW INCOME')
								 GROUP BY LOCATION
									ORDER BY DECEASED DESC
								

-- BREAKING THINGS DOWN BY CONTINENT

-- Showing contintents with the highest death counts

		
		
		SELECT CONTINENT,  MAX(CAST(TOTAL_DEATHS AS INT)) AS DECEASED
								FROM SQL_PROJECTS..[Covid Deaths]
								WHERE CONTINENT IS NOT NULL
								 GROUP BY CONTINENT
								 ORDER BY DECEASED DESC
								
							
	--GLOBAL STATS
	
		SELECT SUM(NEW_CASES) AS TOTALCASES, SUM(CAST(NEW_DEATHS AS INT)) AS TOTAL_DEATHS, 
				SUM(CAST(NEW_DEATHS AS INT))/ SUM(NEW_CASES) * 100 AS DEATH_RATE
		FROM SQL_PROJECTS..[Covid Deaths]
		WHERE CONTINENT IS NOT NULL
		GROUP BY CONTINENT
		ORDER BY 1,2
		

--Showing Percentage of Population that has recieved at least one Covid Vaccine
				
				SELECT COVID_D.CONTINENT, COVID_D.LOCATION, COVID_D.DATE, COVID_D.POPULATION, NEW_VACCINATIONS,
					SUM(CONVERT(FLOAT, COVID_V.NEW_VACCINATIONS)) OVER 
					(PARTITION BY COVID_D.LOCATION ORDER BY COVID_D.LOCATION, COVID_D.DATE) AS ROLLINGPEOPLEVACCINATED
					FROM SQL_PROJECTS..[Covid Deaths] AS COVID_D
					JOIN SQL_PROJECTS..[Covid Vaccinations] AS COVID_V
					ON COVID_D.LOCATION= COVID_V.LOCATION
					AND COVID_D.DATE= COVID_V.DATE
					WHERE COVID_V.CONTINENT IS NOT NULL
						ORDER BY 2,3
						

		--Using CTE to perform Calculation on Partition By in previous query

		WITH VACPOP AS
		(
		SELECT COVID_D.CONTINENT, COVID_D.LOCATION, COVID_D.DATE, COVID_D.POPULATION, NEW_VACCINATIONS,
					SUM(CONVERT(FLOAT, COVID_V.NEW_VACCINATIONS)) OVER 
					(PARTITION BY COVID_D.LOCATION ORDER BY COVID_D.LOCATION, COVID_D.DATE) AS ROLLINGPEOPLEVACCINATED
					FROM SQL_PROJECTS..[Covid Deaths] AS COVID_D
					JOIN SQL_PROJECTS..[Covid Vaccinations] AS COVID_V
					ON COVID_D.LOCATION= COVID_V.LOCATION
					AND COVID_D.DATE= COVID_V.DATE
					WHERE COVID_V.CONTINENT IS NOT NULL
					--ORDER BY 2,3
						)

 SELECT *, (ROLLINGPEOPLEVACCINATED/POPULATION)*100 AS ROLLVACRATE
 FROM VACPOP

-- Using Temp Table to perform Calculation on Partition By in previous query

	DROP TABLE IF EXISTS #VACPOP
	CREATE TABLE #VACPOP
	(
	CONTINENT NVARCHAR(255),
	LOCATION NVARCHAR(255),
	DATE DATETIME,
	POPULATION NUMERIC,
	NEW_VACCINATIONS NUMERIC,
	ROLLINGPEOPLEVACCINATED NUMERIC
	)

	INSERT INTO #VACPOP
	SELECT COVID_D.CONTINENT, COVID_D.LOCATION, COVID_D.DATE, COVID_D.POPULATION, CAST(NEW_VACCINATIONS AS FLOAT),
					SUM(CONVERT(FLOAT, COVID_V.NEW_VACCINATIONS)) OVER 
					(PARTITION BY COVID_D.LOCATION ORDER BY COVID_D.LOCATION, COVID_D.DATE) AS ROLLINGPEOPLEVACCINATED
					FROM SQL_PROJECTS..[Covid Deaths] AS COVID_D
					JOIN SQL_PROJECTS..[Covid Vaccinations] AS COVID_V
					ON COVID_D.LOCATION= COVID_V.LOCATION
					AND COVID_D.DATE= COVID_V.DATE
					--WHERE COVID_V.CONTINENT IS NOT NULL

		SELECT *, (ROLLINGPEOPLEVACCINATED/POPULATION) * 100 AS ROLLINGRATE
		FROM #VACPOP
		ORDER BY 2,3


	-- Creating View to store data for later visualizations

	CREATE VIEW POPVACCINATED AS
	SELECT COVID_D.CONTINENT, COVID_D.LOCATION, COVID_D.DATE, COVID_D.POPULATION, CAST(NEW_VACCINATIONS AS FLOAT) AS NEWVACS,
					SUM(CONVERT(FLOAT, COVID_V.NEW_VACCINATIONS)) OVER 
					(PARTITION BY COVID_D.LOCATION ORDER BY COVID_D.LOCATION, COVID_D.DATE) AS ROLLINGPEOPLEVACCINATED
					FROM SQL_PROJECTS..[Covid Deaths] AS COVID_D
					JOIN SQL_PROJECTS..[Covid Vaccinations] AS COVID_V
					ON COVID_D.LOCATION= COVID_V.LOCATION
					AND COVID_D.DATE= COVID_V.DATE
					WHERE COVID_V.CONTINENT IS NOT NULL

	

	


