# Journey Class
class Journey < Travel

  attr_reader :exit_station
  attr_reader :current_journey
  
  def initialize
    @current_journey = {}
    @complete_journey = true
  end

  def entry_station(station)
    @complete_journey = false
    @current_journey[:entry] = station
    station
  end

  def complete_journey(station)
    @exit_station = station
    @current_journey[:exit] = station
    @complete_journey
  end

  def charge_fee
    100
  end
 
  def penalty_charge
    @complete_journey ? 0 : 600
  end

end