class Location < ActiveRecord::Base
	has_attached_file :picture, :styles => { :original => "500x500>", :medium => "300x300>", :small => "200x200>", :thumb => "100x100!" },
		:storage => :s3,
		:default_url => "/images/:style/missing.png"
  	validates_attachment_content_type :picture, :content_type => /\Aimage\/.*\Z/
	has_many :visits
	has_many :visitors, through: :visits

	def picture_url(size)
    self.picture.url(size).gsub('s3.amazonaws.com/', 's3-us-west-2.amazonaws.com/')
  	end
end
