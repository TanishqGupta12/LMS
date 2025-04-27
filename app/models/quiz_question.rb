class QuizQuestion < ApplicationRecord

  belongs_to :quiz_topic , optional: true
  belongs_to :lesson , optional: true

  has_many :quiz_question_options
  has_many :quiz_attempt_results
  enum question_type: { "Multiple Choice Multiple option": "Multiple Choice Multiple Option" , "Multiple Choice Single Option": "Multiple choice Single option" , "True False": "True False" , "Short Answer": "Short Answer"}
end
