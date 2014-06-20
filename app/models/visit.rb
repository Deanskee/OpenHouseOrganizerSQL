class Visit < ActiveRecord::Base
  belongs_to :location
  belongs_to :visitor
end
