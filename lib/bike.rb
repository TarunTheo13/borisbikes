class Bike
  attr_accessor :status

  def initialize
    @status = "working"
  end

  def working?
    if @status == "working"
      true
    else
      false
    end
  end
end