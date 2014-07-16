class Plan < ActiveRecord::Base
	  belongs_to :schedule
  	  default_scope { order ('activity_time ASC') }
end
