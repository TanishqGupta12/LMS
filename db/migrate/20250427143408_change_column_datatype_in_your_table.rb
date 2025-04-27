class ChangeColumnDatatypeInYourTable < ActiveRecord::Migration[7.2]
  def change
    change_column :quiz_attempt_results, :is_right, :boolean
    change_column :quiz_attempt_results, :is_wrong, :boolean

  end
end
