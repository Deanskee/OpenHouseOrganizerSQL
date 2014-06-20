require 'bcrypt'
class User < ActiveRecord::Base
	has_many :locations

	validates :first_name, presence: true
	validates :last_name, presence: true
	validates :email, presence: true
	validates_length_of :phone_number, minimum: 10, maximum: 10

	def password
  		@password
    end

	def password=(new_password)
	  	 @password = new_password
	    self.password_digest = BCrypt::Password.create(new_password)
	end

	def authenticate(test_password)
	    if BCrypt::Password.new(self.password_digest) == test_password
	      self
	    else
	      false
	    end
	end
end
