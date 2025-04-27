class QuizQuestionOption < ApplicationRecord
  belongs_to :quiz_question
  has_many :quiz_attempt_results
end
