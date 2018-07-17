require 'Station'
# Oyster
class Oyster < Station
  attr_accessor :balance
  attr_accessor :in_journey
  def initialize
    @payments = Payments.new
    @in_journey = false
    @balance = 0.00
  end

  def tap_in(station=nil)
    return raise('Please top up') if balance < MINIMUM_BALANCE
    @in_journey = true
  end

  def tap_out(station=nil)
    @balance = @payments.deduct(1, self)
    @in_journey = false
  end
end
