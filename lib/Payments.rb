require_relative 'Travel'
# Payment
class PaymentProcessor < Travel
  def initialize
    @errors = ["cannot top up max balance of £#{MAXIMUM_BALANCE} reached",
               'cannot deduct not enough money on card',
               'Please top up']
  end

  def pay(amount, card)
    return raise(@errors[0]) if amount + card.balance > MAXIMUM_BALANCE
    card.balance += amount
  end

  def deduct(amount, card)
    return raise(@errors[1]) if card.balance - amount < - 5
    card.balance -= amount
  end
end
