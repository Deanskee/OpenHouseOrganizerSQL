class AddNoteToVisitor < ActiveRecord::Migration
 	def change
	    add_column :visitors, :note, :string
  	end
end