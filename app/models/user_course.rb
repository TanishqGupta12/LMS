class UserCourse < ApplicationRecord
  belongs_to :user
  belongs_to :course
  belongs_to :teacher, class_name: 'User'

  enum payment_status: {
    "Payment incomplete": "Payment incomplete",
    "Payment complete": "Payment complete"
  }
end
