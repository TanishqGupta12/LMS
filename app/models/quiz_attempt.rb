class QuizAttempt < ApplicationRecord
  belongs_to :user
  
  belongs_to :quiz_topic
  belongs_to :lesson
end
