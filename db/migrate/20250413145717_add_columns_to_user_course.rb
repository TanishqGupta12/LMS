class AddColumnsToUserCourse < ActiveRecord::Migration[7.2]
  def change
    add_reference :user_courses, :teacher, foreign_key: { to_table: :users }, null: true

    add_column :user_courses , :payment_details ,:json
    add_column :user_courses , :is_payment ,:boolean
    add_column :user_courses, :time, :datetime
  end
end
