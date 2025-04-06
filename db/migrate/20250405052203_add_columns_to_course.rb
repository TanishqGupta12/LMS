class AddColumnsToCourse < ActiveRecord::Migration[7.2]
  def change
    add_column :courses, :overview, :text
    add_column :courses, :level, :string
    add_column :courses, :language, :string

  end
end
