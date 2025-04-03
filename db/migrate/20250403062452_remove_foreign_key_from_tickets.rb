class RemoveForeignKeyFromTickets < ActiveRecord::Migration[7.2]
  def change
    remove_foreign_key :tickets, :events

    remove_column :tickets, :is_group
    remove_column :tickets, :min_user_limit

    remove_column :tickets, :event_id

  end
end
