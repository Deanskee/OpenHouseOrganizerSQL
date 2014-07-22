class Visit < ActiveRecord::Base
  belongs_to :location
  belongs_to :visitor

    def capital_first_name
  		first_name.titleize
  	end

  	def capital_last_name
  		last_name.titleize
  	end

  	def full_name
      if self.first_name && self.last_name 
      self.first_name + " " + self.last_name 
      else
       "unknown"
      end
  	end
end
