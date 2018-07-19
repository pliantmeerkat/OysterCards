require_relative 'Travel'
# Oyster
class Oyster < Travel
	attr_accessor :balance


	def initialize(payment_processor = PaymentProcessor, journeylog = JourneyLog, journey = Journey)
		@payment_processor = payment_processor.new
		@balance = STARTING_BALANCE
    @journeylog = journeylog.new(journey)
    @journey = journey.new
  end
  # should move to new class for display/ print
  def see_balance
    return "£0.00" if balance == 0
    return "£#{sprintf('%.2f', ((balance.to_f / 100.00)).round(2))}"
  end

	def top_up(amount)
		@payment_processor.pay(amount, self)
	end

	def tap_in(station)
    return raise('Please top up') if balance < MINIMUM_CHARGE
    balance += @journeylog.in_journey?
    @journeylog.start_journey(station)
	end
  
  def tap_out(station)
    @payment_processor.deduct(@journey.charge_fee, self)
    @journeylog.finish_journey(station)
  end

  def travel_history
    @journeylog.return_list
  end

end
