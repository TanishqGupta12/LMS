class QuizAttemptResult < ApplicationRecord
  belongs_to :user
  belongs_to :quiz_topic

  belongs_to :quiz_question 
  belongs_to :quiz_question_option
  belongs_to :lesson
end
