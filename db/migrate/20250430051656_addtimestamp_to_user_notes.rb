class AddtimestampToUserNotes < ActiveRecord::Migration[7.2]
  def change
    add_column :user_notes, :timestamp, :string
  end
end
