class RemovePhoneNumberColFromVisitors < ActiveRecord::Migration
  def change
    remove_column :visitors, :phone_number, :string
  end
end
