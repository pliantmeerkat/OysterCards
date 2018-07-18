require_relative 'Travel'
# Oyster
class Oyster < Travel
	attr_accessor :balance
	attr_reader :entry_station, :travel_history, :exit_station

	def initialize(payment_processor = PaymentProcessor)
		@payment_processor = payment_processor.new
		@balance = STARTING_BALANCE
		@travel_history = {}
	end

	def in_journey?
		!!entry_station
	end

	def top_up(amount)
		@payment_processor.pay(amount, self)
	end

	def tap_in(station = nil)
		return raise('Please top up') if balance < MINIMUM_CHARGE
		@entry_station = station
	end
  
	def tap_out(station = nil)
		@balance = @payment_processor.deduct(1, self)
		@exit_station = station
		@entry_station = nil
	end

	def add_journey
		@travel_history['entry' => @entry_station]
		@travel_history['exit' => @exit_station]
	end

end
