/* Queries used for Tableau Project
   Covid-19 data
*/


-- 1. The total number of new cases and deaths in the world 

Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
From PortfolioProject..CovidDeaths
--Where location like '%canada%'
where continent is not null 
--Group By date
order by 1,2



-- 2. Total number of caeses and deaths by country

Select Location, date, population, total_cases, total_deaths
From PortfolioProject..CovidDeaths
--Where location like '%canada%'
where continent is not null 
order by 1,2



-- 3. Breakdown of total death by continent 

Select location, SUM(cast(new_deaths as int)) as TotalDeathCount
From PortfolioProject..CovidDeaths
Where continent is null 
and location not in ('World', 'European Union', 'International', 'Upper middle income', 'High income', 'Low income', 'Lower middle income')
Group by location
order by TotalDeathCount desc



-- 4a. Highest infection counts by country (without date)

Select Location, Population, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population))*100 as PercentPopulationInfected
From PortfolioProject..CovidDeaths
--Where location like '%states%'
Group by Location, Population
order by PercentPopulationInfected desc



-- 4b. Highest infection counts by country  (with date)

Select Location, Population,date, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population))*100 as PercentPopulationInfected
From PortfolioProject..CovidDeaths
--Where location like '%canada%'
Group by Location, Population, date
order by PercentPopulationInfected desc



-- 5. Rolling number of people vaccinated in the world

Select dea.continent, dea.location, dea.date, dea.population
, MAX(vac.total_vaccinations) as RollingPeopleVaccinated
From PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 
group by dea.continent, dea.location, dea.date, dea.population
order by 1,2,3



