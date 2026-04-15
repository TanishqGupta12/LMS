class RemoveForeignKeyFromTables < ActiveRecord::Migration[7.2]
  def change
    # remove_foreign_key :tickets, :course
    remove_column :tickets, :course_id
    add_reference :courses, :ticket, foreign_key: { on_delete: :cascade }

  end
end
