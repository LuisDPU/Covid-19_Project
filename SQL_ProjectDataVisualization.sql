
-- Showing the total cases vs Total Death as percentage
-- Graph 1 use for data visulization
Select Sum(new_Cases) as Total_cases, Sum(cast(new_deaths as int)) As Total_deaths, Sum(cast(new_deaths as int))/Sum(new_Cases)*100 AS DeathPercent-- (total_cases/population)*100 AS PercentagePopulation
From PortfolioProject.dbo.CovidDeaths
--Where location LIKE '%states%' 
 Where continent is not null and new_cases is not null and new_deaths is not null 
--Group by date
Order by 1, 2


--Use for data visualization graph 2
Select location, SUM(cast(new_deaths as int)) as TotalDeathCount
From PortfolioProject..CovidDeaths
--Where location like '%states%'
Where continent is null 
and location not in ('World', 'European Union', 'International')
Group by location
order by TotalDeathCount desc


-- Looking at Countries with Highest Infection Rate compared to Population
-- Graph 3 for data visualization
Select location,population,Max(total_cases) AS HighestInfectionCount, Max((total_cases/population)*100) AS PercentPopulation_Infected
From PortfolioProject.dbo.CovidDeaths
Where continent is not null and population is not null  and total_cases is not null
Group by Location, population
Order by PercentPopulation_Infected desc

-- Graph 4 for data visualization
Select Location, Population,date, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population))*100 as PercentPopulationInfected
From PortfolioProject..CovidDeaths
Where population is not null and date is not null and total_cases is not null
Group by Location, Population, date
order by PercentPopulationInfected desc

-- What is the total cases per country or location
--Graph 6
Select location, Sum(total_cases) as Total_cases_percountry
From PortfolioProject.dbo.CovidDeaths
Where continent is not null and total_cases is not null
Group by location, new_cases
Order by 2 desc



--Shows the reproduction rate risk in each location by date, population
-- Use is not null and reduced 210,932 to 165,734
-- Graph 7 used for data visulization
Select location, date, population, total_deaths, reproduction_rate,
Case
	When reproduction_rate >= 1 Then 'spreading exponientally'
	When reproduction_rate <= 1 then 'outbreak is subsiding'
	Else 'Null'
End AS reproductionrate_indicator
From PortfolioProject.dbo.CovidDeaths
Where continent is not null  and reproduction_rate is not null and date is not null and  population is not null
--Group by location,date
Order by 1, 2  


-- Show the average reproduction rate by location and population
-- Graph 8 for data visualization 
Select location, population, avg(reproduction_rate) as  Avg_reprductionrate
From PortfolioProject.dbo.CovidDeaths
Where continent is not null and reproduction_rate is not null
Group by location, population
Order by 2 desc