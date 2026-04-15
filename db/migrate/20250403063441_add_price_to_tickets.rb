class AddPriceToTickets < ActiveRecord::Migration[7.2]
  def change
    add_monetize :tickets, :price, currency: { present: false }

    add_reference :tickets, :user, foreign_key: { on_delete: :cascade }
    remove_column :tickets, :price
    remove_column :tickets, :is_group
    remove_column :tickets, :min_user_limit
  end
end
