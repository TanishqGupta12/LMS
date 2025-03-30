class Course < ApplicationRecord

  belongs_to :event, optional: true
  belongs_to :category , optional: true
  belongs_to :teacher, class_name: 'User'

  has_one_attached :thumbail

  attribute :remove_thumbail, :boolean
  after_save -> { thumbail.purge }, if: :remove_thumbail

  scope :courses_for_event, ->(event_id) { includes(:categories).where(event_id: event_id) }
  # before_save :set_event

  # def set_event
  #   self.event_id = event.try(:id)
  # end
end
