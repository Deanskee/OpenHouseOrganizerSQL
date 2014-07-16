class ChangeFormatOfPhoneToBigInt < ActiveRecord::Migration
  def change
  	change_column :visitors, :phone_number, :string
  end
end
