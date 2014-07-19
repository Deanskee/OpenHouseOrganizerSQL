class Visit < ActiveRecord::Base
  belongs_to :location
  belongs_to :visitor

    def capital_first_name
  		first_name.titleize
  	end

  	def capital_last_name
  		last_name.titleize
  	end
end
