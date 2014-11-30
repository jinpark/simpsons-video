class Video < ActiveRecord::Base
	def self.random(count)
	    order("RANDOM()").limit(count)
	end
end
