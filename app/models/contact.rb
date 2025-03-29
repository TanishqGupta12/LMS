class Contact < ApplicationRecord
  belongs_to :event , optional: true

  validates :name, :email, :subject, :message, :event_id, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP, message: "is not a valid email" }
  validates :subject, length: { maximum: 255 }
  
end
