class AddPictureToLocations < ActiveRecord::Migration
  	def self.up
    add_attachment :locations, :picture
  end

  def self.down
    remove_attachment :locations, :picture
  end
end
