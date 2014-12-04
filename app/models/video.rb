class Video < ActiveRecord::Base

	def self.random(count)
	    order("RANDOM()").limit(count)
	end

	private
	def add_slug
		self.slug = self.title.parameterize
	end
end
