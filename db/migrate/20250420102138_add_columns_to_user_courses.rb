class AddColumnsToUserCourses < ActiveRecord::Migration[7.2]
  def change
    add_column :user_courses, :percentage, :string
    add_column :user_courses, :completed_lession, :string
  end
end
