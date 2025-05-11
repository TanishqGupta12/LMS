class Faq < ApplicationRecord
  belongs_to :course
  belongs_to :user

  def name
    self.question
  end
end
