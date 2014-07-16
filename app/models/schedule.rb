class Schedule < ActiveRecord::Base
		belongs_to :user
		has_many :plans, dependent: :destroy
		accepts_nested_attributes_for :plans, allow_destroy: true
end
