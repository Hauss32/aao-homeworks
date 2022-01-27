# == Schema Information
#
# Table name: countries
#
#  name        :string       not null, primary key
#  continent   :string
#  area        :integer
#  population  :integer
#  gdp         :integer

require_relative './sqlzoo.rb'

def highest_gdp
  # Which countries have a GDP greater than every country in Europe? (Give the
  # name only. Some countries may have NULL gdp values)
  execute(<<-SQL)
    SELECT name
    FROM countries
    WHERE COALESCE(gdp, 0) > (
      SELECT MAX(gdp)
      FROM countries
      WHERE
        gdp IS NOT NULL AND
        continent = 'Europe'
    )
  SQL
end

def largest_in_continent
  # Find the largest country (by area) in each continent. Show the continent,
  # name, and area.
  execute(<<-SQL)
    SELECT
      continent,
      name,
      area
    FROM countries AS c1
    WHERE c1.area = (
      SELECT MAX(area)
      FROM countries AS c2
      WHERE c2.continent = c1.continent
    )
  SQL
end

def large_neighbors
  # Some countries have populations more than three times that of any of their
  # neighbors (in the same continent). Give the countries and continents.
  execute(<<-SQL)
    SELECT
      name,
      continent
    FROM countries AS c1
    WHERE c1.population > (
      SELECT MAX(population) * 3
      FROM countries as c2
      WHERE
        c1.continent = c2.continent AND
        c2.name != c1.name
    )
  SQL
end
