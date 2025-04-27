class QuizQuestion < ApplicationRecord

  belongs_to :quiz_topic , optional: true
  belongs_to :lesson , optional: true
  enum question_type: { "Multiple Choice Multiple option": "Multiple Choice Multiple Option" , "Multiple Choice Single Option": "Multiple choice Single option" , "True False": "True False" , "Short Answer": "Short Answer"}
end
