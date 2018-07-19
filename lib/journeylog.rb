#journeylog class
class JourneyLog 

  attr_reader :journey_list

  def initialize(journey)
    @journey = journey
    @current_journey = journey.new
    @journey_list = []
  end

  def start_journey(station)
    @current_journey = current_journey
    @current_journey.entry_station(station)
  end

  def finish_journey(station)
    @current_journey.complete_journey(station)
    @journey_list.push(@current_journey)
    @current_journey = @journey.new
  end

  def return_list
    @journey_list
  end

  def in_journey?
    return @jcurrent_journey.penalty_charge != nil ? 600 : 0
  end

  def current_journey
    return @journey.new if @current_journey.complete_journey(station) == false
    @journey_list.push(@current_journey)
    @journey.new
  end

end