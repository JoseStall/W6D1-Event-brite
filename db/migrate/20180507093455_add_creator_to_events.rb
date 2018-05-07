class AddCreatorToEvents < ActiveRecord::Migration[5.2]
	def change
		change_table :events do |t|
			t.belongs_to :creator
		end
	end
end
