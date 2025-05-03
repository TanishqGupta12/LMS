class UserNote < ApplicationRecord
  belongs_to :user
  belongs_to :event
  belongs_to :course
  belongs_to :lesson

  def lesson_title
    self.lesson.try(:title)
  end

  def course_title
    self.course.try(:title)
  end
end
