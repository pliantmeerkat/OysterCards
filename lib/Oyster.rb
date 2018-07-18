require_relative 'Travel'
# Oyster
class Oyster < Travel
	attr_accessor :balance, :in_journey

	def initialize(payments = Payments)
		@payments = payments.new
		@in_journey = false
		@balance = STARTING_BALANCE
	end

	def top_up(amount)
		@payments.pay(amount, self)
	end

	def tap_in(station = nil)
		return raise('Please top up') if balance < MINIMUM_CHARGE
		@in_journey = true
	end
  
	def tap_out(station = nil)
		@balance = @payments.deduct(1, self)
		@in_journey = false
	end
end
