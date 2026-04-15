class AddLocationToEvents < ActiveRecord::Migration[7.1]
  def change
    add_column :events, :location, :string
    change_column :events, :slug, :text
    remove_column :events, :hide_blog, :boolean
  end
end
