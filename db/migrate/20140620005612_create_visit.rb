class CreateVisit < ActiveRecord::Migration
  def change
    create_table :visits do |t|
      t.references :location, index: true
      t.references :visitor, index: true

      t.string :broker
      t.string :referral

      t.timestamps
    end
  end
end
