class RemoveColumnNameFromTables < ActiveRecord::Migration[7.2]
  def change
    remove_column  :quiz_questions , :wrong_answer_explanation , :text
    remove_column  :quiz_topics , :practise_quiz , :boolean

    add_column :lessons , :practise_quiz , :boolean
    add_column :quiz_questions , :enable_correct_answer , :boolean ,default: false
  end
end
