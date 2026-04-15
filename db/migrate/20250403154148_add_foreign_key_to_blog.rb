class AddForeignKeyToBlog < ActiveRecord::Migration[7.2]
  def change
    add_reference :blogs, :category, foreign_key: { on_delete: :cascade }

  end
end
