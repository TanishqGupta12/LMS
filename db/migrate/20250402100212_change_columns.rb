class ChangeColumns < ActiveRecord::Migration[7.2]
  def change
    remove_column :form_section_fields, :onlyReady
    remove_column :forms, :slug
    add_column :forms, :role_id, :bigint
    add_foreign_key :forms, :roles, column: :role_id, on_delete: :nullify
    add_index :forms, :role_id
  end
end
