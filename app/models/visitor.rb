class Visitor < ActiveRecord::Base
	has_many :visits
	has_many :locations, through: :visits

	validates_format_of :phone_number, with: /\A(\d{10}|\(?\d{3}\)?[-. ]\d{3}[-.]\d{4})\z/ 
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  	validates :email, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }

end

# Client.order(created_at: :desc)