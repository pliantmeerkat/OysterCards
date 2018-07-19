# Station class
class Station
	attr_accessor :name
	attr_accessor :zone

	def initialize(hash)
		@name = hash[:name]
		@zone = hash[:zone]
	end			
				
end
