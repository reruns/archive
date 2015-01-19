# == Schema Information
#
# Table name: stops
#
#  id          :integer      not null, primary key
#  name        :string
#
# Table name: route
#
#  num         :integer      not null, primary key
#  company     :string       not null, primary key
#  pos         :integer      not null, primary key
#  stop        :integer

require_relative './sqlzoo.rb'

def num_stops
  # How many stops are in the database?
  execute(<<-SQL)
  SELECT
    count(id)
  FROM
    stops
  SQL
end

def craiglockhart_id
  # Find the id value for the stop 'Craiglockhart'.
  execute(<<-SQL)
  SELECT
    id
  FROM
    stops
  WHERE
    name = 'Craiglockhart'
  SQL
end

def lrt_stops
  # Give the id and the name for the stops on the '4' 'LRT' service.
  execute(<<-SQL)
    SELECT
      id, name
    FROM
      stops
    JOIN
      route ON stops.id = route.stop
    WHERE
      num = '4' and company = 'LRT'
  SQL
end

def connecting_routes
  # The query shown gives the number of routes that visit either London Road
  # (149) or Craiglockhart (53). Run the query and notice the two services
  # that link these stops have a count of 2. Add a HAVING clause to restrict
  # the output to these two routes.
  execute(<<-SQL)
  SELECT
    company, num, COUNT(*)
  FROM
    route
  WHERE
    stop=149 OR stop=53
  GROUP BY
    company, num
  SQL
end

def cl_to_lr
  # Execute the self join shown and observe that b.stop gives all the places
  # you can get to from Craiglockhart, without changing routes. Change the
  # query so that it shows the services from Craiglockhart to London Road.
  execute(<<-SQL)
  SELECT
    a.company, a.num, a.stop, b.stop
  FROM
    route a
  JOIN
    route b ON (a.company=b.company AND a.num=b.num)
  WHERE
    a.stop=53
  SQL
end

def cl_to_lr_by_name
  # The query shown is similar to the previous one, however by joining two
  # copies of the stops table we can refer to stops by name rather than by
  # number. Change the query so that the services between 'Craiglockhart' and
  # 'London Road' are shown. If you are tired of these places try
  # 'Fairmilehead' against 'Tollcross'
  execute(<<-SQL)
  SELECT
    a.company, a.num, stopa.name, stopb.name
  FROM
    route a
  JOIN
    route b ON (a.company=b.company AND a.num=b.num)
  JOIN
    stops stopa ON (a.stop=stopa.id)
  JOIN
    stops stopb ON (b.stop=stopb.id)
  WHERE
    stopa.name='Craiglockhart' --and stopb.name='London Road'
  SQL
end

def haymarket_and_leith
  # Give a list of all the services which connect stops 115 and 137
  # ('Haymarket' and 'Leith')
  execute(<<-SQL)
  SELECT DISTINCT
    a.company, a.num
  FROM
    route a
  JOIN
    route b ON (a.company=b.company AND a.num=b.num)
  WHERE
    a.stop = 115 and b.stop = 137
  SQL
end

def craiglockhart_and_tollcross
  # Give a list of the services which connect the stops 'Craiglockhart' and
  # 'Tollcross'
  execute(<<-SQL)
  SELECT DISTINCT
    a.company, a.num
  FROM
    route a
  JOIN
    route b ON (a.company=b.company AND a.num=b.num)
  JOIN
    stops stopa ON (a.stop = stopa.id)
  JOIN
    stops stopb ON (b.stop = stopb.id)
  WHERE
    stopa.name = 'Craiglockhart' and stopb.name = 'Tollcross'
  SQL
end

def start_at_craiglockhart
  # Give a distinct list of the stops which may be reached from 'Craiglockhart'
  # by taking one bus, including 'Craiglockhart' itself. Include the company
  # and bus no. of the relevant services.
  execute(<<-SQL)
  SELECT
    stopb.name, a.company, a.num
  FROM
    route a
  JOIN
    route b ON (a.company = b.company AND a.num = b.num)
  JOIN
    stops stopa ON (a.stop = stopa.id)
  JOIN
    stops stopb ON (b.stop = stopb.id)
  WHERE
    stopa.name = 'Craiglockhart'
  SQL
end

def craiglockhart_to_sighthill
  # Find the routes involving two buses that can go from Craiglockhart to
  # Sighthill. Show the bus no. and company for the first bus, the name of the
  # stop for the transfer, and the bus no. and company for the second bus.
  execute(<<-SQL)
  SELECT DISTINCT
    a.num, a.company, stopb.name, d.num, d.company
  FROM
    route a
  JOIN
    stops stopa ON (a.stop = stopa.id)
  JOIN
    route b ON (a.company=b.company AND a.num=b.num)
  JOIN
    stops stopb ON (b.stop = stopb.id)
  JOIN
    route c ON (stopb.id = c.stop)
  JOIN
    route d ON (c.company=d.company AND c.num=d.num)
  JOIN
    stops stopd ON (d.stop = stopd.id)
  WHERE
    stopa.name = 'Craiglockhart' and stopd.name = 'Sighthill'
  SQL
end
