require_relative 'bike'

class DockingStation
  DEFAULT_CAPACITY = 20

  attr_reader :capacity

  def initialize(capacity=DEFAULT_CAPACITY)
    @bikes = []
    @capacity = capacity
  end

  def release_bike
    fail 'No bikes available' if empty?
    fail 'Bike is broken' unless bikes[bikes.length - 1].working?
    bikes.pop
  end

  def dock(bike, condition = 'working')
    fail 'Docking station full' if full?
    bike.status = condition
    bikes << bike
  end

  private

  attr_reader :bikes
  def full?
    bikes.count >= capacity
  end

  def empty?
    bikes.empty?
  end
end