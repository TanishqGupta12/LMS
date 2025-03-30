class AddUserToCourses < ActiveRecord::Migration[7.1]
  def change
    add_reference :courses, :teacher, foreign_key: { to_table: :users }, null: true
    add_column :courses, :title, :string
    rename_column :categories, :content, :title

  end
end
