class Route < ApplicationRecord
  has_many :buses,
    class_name: 'Bus',
    foreign_key: :route_id,
    primary_key: :id

  def n_plus_one_drivers
    buses = self.buses

    all_drivers = {}
    buses.each do |bus|
      drivers = []
      bus.drivers.each do |driver|
        drivers << driver.name
      end
      all_drivers[bus.id] = drivers
    end

    all_drivers
  end

  def better_drivers_query
    bus_drivers = self.buses.joins(drivers).select('routes.id, drivers.name')

    all_drivers = Hash.new { |h, k| h[k] = Array.new }

    bus_drivers.each { |row| all_drivers[row.id] << row.name }

    all_drivers
  end
end
