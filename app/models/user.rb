require 'bcrypt'
class User < ActiveRecord::Base
	has_many :locations

	validates :first_name, presence: true
	validates :last_name, presence: true
	# validates_length_of :phone_number, minimum: 10, maximum: 10
	validates_uniqueness_of :email
	validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create
	has_attached_file :avatar, :styles => {:medium => "300x300>", :small => "150x150#", :thumb => "45x45#" }, 
    :storage => :s3,
    :default_url => "/images/:style/missing.png"
    validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
    has_secure_password
	# def password
 #  		@password
 #    end

	# def password=(new_password)
	#   	 @password = new_password
	#     self.password_digest = BCrypt::Password.create(new_password)
	# end

	# def authenticate(test_password)
	#     if BCrypt::Password.new(self.password_digest) == test_password
	#       self
	#     else
	#       false
	#     end
	# end

	def avatar_url(size)
		self.avatar.url(size)
	end
end
