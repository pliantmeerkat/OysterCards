require 'Station'
# Oyster
class Oyster < Station
  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1.00
  attr_accessor :balance
  attr_accessor :in_journey
  def initialize
    @in_journey = false
    @balance = 0.00
    @errors = ["cannot top up max balance of #{MAXIMUM_BALANCE} reached",
               'cannot deduct not enough money on card',
               'Please top up']
  end

  def top_up(amount)
    return raise(@errors[0]) if amount + balance > MAXIMUM_BALANCE
    @balance += amount
  end

  def deduct(amount)
    return raise(@errors[1]) if balance - amount < 0
    @balance -= amount
  end

  def tap_in(station=nil)
    return raise(@errors[2]) if balance < MINIMUM_BALANCE
    @in_journey = true
  end

  def tap_out(station=nil)
    @in_journey = false
  end
end
