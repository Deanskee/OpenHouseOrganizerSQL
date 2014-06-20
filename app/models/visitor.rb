class Visitor < ActiveRecord::Base
	has_many :visits
	has_many :locations, through: :visits
end
