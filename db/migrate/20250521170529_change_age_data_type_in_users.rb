class ChangeAgeDataTypeInUsers < ActiveRecord::Migration[7.2]
  def change
    change_column :users, :f14, :text
    add_column :users, :banned, :boolean, default: true
  end
end
