class AddFroginToTicket < ActiveRecord::Migration[7.2]
  def change
    add_reference :tickets, :discount, foreign_key: { on_delete: :cascade }, null: true

    remove_column :discounts, :min_discount , :float
    remove_column :discounts, :max_discount , :float

    remove_column :discounts, :valid_still , :datetime
    remove_column :discounts, :valid_from , :datetime

    remove_foreign_key :discounts, :events
    remove_column :discounts, :event_id
  end
end
