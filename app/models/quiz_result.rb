class QuizResult < ApplicationRecord
  belongs_to :user
  belongs_to :quiz_attempt

end
