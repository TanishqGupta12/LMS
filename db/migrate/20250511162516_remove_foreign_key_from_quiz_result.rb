class RemoveForeignKeyFromQuizResult < ActiveRecord::Migration[7.2]
  def change
    remove_reference :quiz_results, :course, foreign_key: true

    add_column :courses , :last_topic, :boolean ,default: false
    add_column :lessons, :percentage, :float
  end
end
