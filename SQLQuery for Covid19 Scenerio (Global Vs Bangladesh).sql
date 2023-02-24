Select *
From PortfolioProject..CovidDeaths$
where continent is not null
order by 3,4

Select *
From PortfolioProject..CovidVaccinations$
Where continent is not null
order by 3,4

select location, date, total_cases, new_cases, total_deaths, population
From PortfolioProject..CovidDeaths$
where continent is not null
order by 1,2


select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
From PortfolioProject..CovidDeaths$
Where location like '%bangladesh%'
order by 1,2


select location, date, population, total_cases, (total_cases/population)*100 as AffectPercentage
From PortfolioProject..CovidDeaths$
Where location like '%bangladesh%'
order by 1,2

--Countries with Highest Infection Rate compared to Population

select location, population, MAX(total_cases) as HighestInfectionCount, Max((total_cases/population))*100 as PercentPopulationInfected
From PortfolioProject..CovidDeaths$
--Where location like '%bangladesh%'
Where continent is not null
group by location, population
order by PercentPopulationInfected desc

--Countries with Highest Death Count per Population

select location, MAX(cast(total_deaths as int)) as TotalDeathCount
From PortfolioProject..CovidDeaths$
--Where location like '%states%'
Where continent is not null
group by location
order by TotalDeathCount desc



--contintents with the highest death count per population

select continent, MAX(cast(total_deaths as int)) as TotalDeathCount
From PortfolioProject..CovidDeaths$
--Where location like '%states%'
Where continent is not null
group by continent
order by TotalDeathCount desc



--global numbers

select date, Sum(new_cases) as total_cases, Sum(cast(new_deaths as int)) as total_deaths, Sum(cast(new_deaths as int))/Sum(new_cases)*100 as DeathPercentage
From PortfolioProject..CovidDeaths$
--Where location like '%states%'
Where continent is not null
group by date
order by 1,2


 --Total Population vs Vaccinations


select dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
From PortfolioProject..CovidDeaths$ dea
join PortfolioProject..CovidVaccinations$ vac
on dea.location = vac.location
and dea.date = vac.date
Where dea.location like '%bangladesh%'
order by 2,3
