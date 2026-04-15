class AddReferenceToQuizAttemptResults < ActiveRecord::Migration[7.2]
  def change
    add_reference :quiz_attempt_results, :quiz_question, foreign_key: true ,null: true
    add_reference :quiz_attempt_results, :quiz_question_option, foreign_key: true,null: true
    add_reference :quiz_attempt_results, :lesson, foreign_key: true,null: true
  end
end
