# Oyster
class Oyster
  MAXIMUM_BALANCE = 90
  attr_accessor :balance
  def initialize
    @balance = 0.00
    @errors = ["cannot top up max balance of #{MAXIMUM_BALANCE} reached",
               'cannot deduct not enough money on card']
  end

  def top_up(amount)
    return raise(@errors[0]) if amount + balance > MAXIMUM_BALANCE
    @balance += amount
  end

  def deduct(amount)
    return raise(@errors[1]) if balance - amount < 0
    @balance -= amount
  end

  def tap_in

  end

  def tap_out

  end
end
