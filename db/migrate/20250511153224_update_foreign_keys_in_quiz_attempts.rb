class UpdateForeignKeysInQuizAttempts < ActiveRecord::Migration[7.2]
  def change
    # Remove the foreign key and column for quiz_attempt_result
    remove_reference :quiz_attempts, :quiz_attempt_result, foreign_key: true, null: true

    # Add foreign keys for quiz_topic and lesson
    add_reference :quiz_attempts, :quiz_topic, foreign_key: true, null: true
    add_reference :quiz_attempts, :lesson, foreign_key: true, null: true
  end
end
