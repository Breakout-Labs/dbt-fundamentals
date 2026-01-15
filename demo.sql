select p.name, p.annual_wage, p.country
from pay as p
where p.annual_wage < (
select max(per_capita_gdp)
from international_gdp i
where p.country = i.name
)