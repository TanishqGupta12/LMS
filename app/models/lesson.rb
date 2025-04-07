class Lesson < ApplicationRecord
  belongs_to :quiz_topic , optional: true
end
