class QuizTopic < ApplicationRecord

  belongs_to :course, optional: true
  belongs_to :category , optional: true
  has_many :quiz_questions

  has_many :lessons
  has_many :quiz_questions
end
