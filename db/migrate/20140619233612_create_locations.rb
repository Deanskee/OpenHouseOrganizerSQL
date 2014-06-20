class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :address
      t.string :state
      t.integer :zip_code
      t.string :owner

      t.timestamps
    end
  end
end
