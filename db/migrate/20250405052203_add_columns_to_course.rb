class AddColumnsToCourse < ActiveRecord::Migration[7.2]
  def change
    add_column :courses, :overview, :text
    add_column :courses, :level, :string

    remove_column :courses, :has_download_certificate, :boolean
    remove_column :courses, :is_paid, :boolean
    remove_column :courses, :has_pass_fail_page, :boolean 
    remove_column :courses, :valid_from, :datetime
    remove_column :courses, :valid_upto, :datetime
  end
end
