class AddPhoneNumberColToVisitors < ActiveRecord::Migration
  def change
    add_column :visitors, :phone_number, :bigint
  end
end
