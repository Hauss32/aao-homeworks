# == Schema Information
#
# Table name: stops
#
#  id          :integer      not null, primary key
#  name        :string
#
# Table name: routes
#
#  num         :string       not null, primary key
#  company     :string       not null, primary key
#  pos         :integer      not null, primary key
#  stop_id     :integer

require_relative './sqlzoo.rb'

def num_stops
  # How many stops are in the database?
  execute(<<-SQL)
    SELECT COUNT(*)
    FROM stops
  SQL
end

def craiglockhart_id
  # Find the id value for the stop 'Craiglockhart'.
  execute(<<-SQL)
    SELECT id
    FROM stops
    WHERE name = 'Craiglockhart'
  SQL
end

def lrt_stops
  # Give the id and the name for the stops on the '4' 'LRT' service.
  execute(<<-SQL)
    SELECT
      id, 
      name
    FROM stops AS s
    JOIN routes AS r ON s.id = r.stop_id
    WHERE
      company = 'LRT' AND
      num = '4'
  SQL
end

def connecting_routes
  # Consider the following query:
  #
  # SELECT
  #   company,
  #   num,
  #   COUNT(*)
  # FROM
  #   routes
  # WHERE
  #   stop_id = 149 OR stop_id = 53
  # GROUP BY
  #   company, num
  #
  # The query gives the number of routes that visit either London Road
  # (149) or Craiglockhart (53). Run the query and notice the two services
  # that link these stops have a count of 2. Add a HAVING clause to restrict
  # the output to these two routes.
  execute(<<-SQL)
    SELECT
      company,
      num,
      COUNT(*)
    FROM
      routes
    WHERE
      stop_id = 149 OR stop_id = 53
    GROUP BY
      company, num
    HAVING COUNT(*) > 1
  SQL
end

def cl_to_lr
  # Consider the query:
  #
  # SELECT
  #   a.company,
  #   a.num,
  #   a.stop_id,
  #   b.stop_id
  # FROM
  #   routes a
  # JOIN
  #   routes b ON (a.company = b.company AND a.num = b.num)
  # WHERE
  #   a.stop_id = 53
  #
  # Observe that b.stop_id gives all the places you can get to from
  # Craiglockhart, without changing routes. Change the query so that it
  # shows the services from Craiglockhart to London Road.
  execute(<<-SQL)
    SELECT
      a.company,
      a.num,
      a.stop_id,
      b.stop_id
    FROM
      routes a
    JOIN
      routes b ON (a.company = b.company AND a.num = b.num)
    WHERE
      a.stop_id = 53 AND b.stop_id = 149
  SQL
end

def cl_to_lr_by_name
  # Consider the query:
  #
  # SELECT
  #   a.company,
  #   a.num,
  #   stopa.name,
  #   stopb.name
  # FROM
  #   routes a
  # JOIN
  #   routes b ON (a.company = b.company AND a.num = b.num)
  # JOIN
  #   stops stopa ON (a.stop_id = stopa.id)
  # JOIN
  #   stops stopb ON (b.stop_id = stopb.id)
  # WHERE
  #   stopa.name = 'Craiglockhart'
  #
  # The query shown is similar to the previous one, however by joining two
  # copies of the stops table we can refer to stops by name rather than by
  # number. Change the query so that the services between 'Craiglockhart' and
  # 'London Road' are shown.
  execute(<<-SQL)
    SELECT
      a.company,
      a.num,
      stopa.name,
      stopb.name
    FROM
      routes a
    JOIN
      routes b ON (a.company = b.company AND a.num = b.num)
    JOIN
      stops stopa ON (a.stop_id = stopa.id)
    JOIN
      stops stopb ON (b.stop_id = stopb.id)
    WHERE
      stopa.name = 'Craiglockhart' AND
      stopb.name = 'London Road'
  SQL
end

def haymarket_and_leith
  # Give the company and num of the services that connect stops
  # 115 and 137 ('Haymarket' and 'Leith')
  execute(<<-SQL)
    SELECT DISTINCT
      a.company,
      a.num
    FROM routes AS a
    JOIN routes AS b ON 
      a.company = b.company AND 
      a.num = b.num
    JOIN stops AS from_stop ON a.stop_id = from_stop.id
    JOIN stops AS to_stop ON b.stop_id = to_stop.id
    WHERE 
      from_stop.name = 'Haymarket' AND
      to_stop.name = 'Leith'
  SQL
end

def craiglockhart_and_tollcross
  # Give the company and num of the services that connect stops
  # 'Craiglockhart' and 'Tollcross'
  execute(<<-SQL)
    SELECT DISTINCT
      a.company,
      a.num
    FROM routes AS a
    JOIN routes AS b ON 
      a.company = b.company AND 
      a.num = b.num
    JOIN stops AS from_stop ON a.stop_id = from_stop.id
    JOIN stops AS to_stop ON b.stop_id = to_stop.id
    WHERE 
      from_stop.name = 'Craiglockhart' AND
      to_stop.name = 'Tollcross'
  SQL
end

def start_at_craiglockhart
  # Give a distinct list of the stops that can be reached from 'Craiglockhart'
  # by taking one bus, including 'Craiglockhart' itself. Include the stop name,
  # as well as the company and bus no. of the relevant service.
  execute(<<-SQL)
    SELECT DISTINCT
      to_stop.name,
      a.company,
      a.num
    FROM routes AS a
    JOIN routes AS b ON 
      a.company = b.company AND 
      a.num = b.num
    JOIN stops AS from_stop ON a.stop_id = from_stop.id
    JOIN stops AS to_stop ON b.stop_id = to_stop.id
    WHERE 
      from_stop.name = 'Craiglockhart'
  SQL
end

def craiglockhart_to_sighthill
  # Find the routes involving two buses that can go from Craiglockhart to
  # Sighthill. Show the bus no. and company for the first bus, the name of the
  # stop for the transfer, and the bus no. and company for the second bus.
  execute(<<-SQL)
    SELECT DISTINCT
      first_bus_start.num AS first_bus_num,
      first_bus_start.company AS first_bus_company,
      transfer_stop.name AS transfer_stop,
      second_bus_end.num AS second_bus_num,
      second_bus_end.company AS second_bus_company
    FROM routes AS first_bus_start
    JOIN routes AS first_bus_end ON
      first_bus_start.company = first_bus_end.company AND 
      first_bus_start.num = first_bus_end.num
    JOIN routes AS second_bus_start ON first_bus_end.stop_id = second_bus_start.stop_id
    JOIN routes AS second_bus_end ON
      second_bus_start.company = second_bus_end.company AND 
      second_bus_start.num = second_bus_end.num
    JOIN stops AS from_stop ON first_bus_start.stop_id = from_stop.id
    JOIN stops AS transfer_stop ON first_bus_end.stop_id = transfer_stop.id
    JOIN stops AS to_stop ON second_bus_end.stop_id = to_stop.id
    WHERE 
      from_stop.name = 'Craiglockhart' AND
      to_stop.name = 'Sighthill'
  SQL
end
