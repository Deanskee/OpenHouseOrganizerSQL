class Location < ActiveRecord::Base
	has_many :visits
	has_many :visitors, through: :visits
	belongs_to :user
	has_attached_file :picture, :styles => { :original => "500x500>", :medium => "300x300>", :small => "200x200>", :thumb => "100x100!" },
	:storage => :s3,:default_url => "/images/:style/missing.png"
  	validates_attachment_content_type :picture, :content_type => /\Aimage\/.*\Z/

	def picture_url(size)
    self.picture.url(size)
  	end
end
