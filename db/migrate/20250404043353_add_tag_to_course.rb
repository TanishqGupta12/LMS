class AddTagToCourse < ActiveRecord::Migration[7.2]
  def change
    add_column :courses, :tags, :text
  end
end
