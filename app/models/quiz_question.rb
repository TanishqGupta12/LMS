class QuizQuestion < ApplicationRecord
  has_one_attached :video

  attribute :remove_video, :boolean
  after_save -> { video.purge }, if: :remove_video

  belongs_to :quiz_topic , optional: true

  enum question_type: { "Multiple Choice Multiple option": "Multiple Choice Multiple Option" , "Multiple Choice Single Option": "Multiple choice Single option" , "True False": "True False" , "Short Answer": "Short Answer"}
end
