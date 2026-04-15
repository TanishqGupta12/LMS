class AddColumnToUserCourse < ActiveRecord::Migration[7.2]
  def change
    remove_column :user_courses, :feedback

    add_column :user_courses, :payment_status, :string 
    add_column :user_courses, :payment_amount, :string 
  end
end
