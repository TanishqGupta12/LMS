class Course < ApplicationRecord

  acts_as_votable
  acts_as_favoritable
  belongs_to :ticket , optional: true
  belongs_to :event, optional: true
  belongs_to :category , optional: true
  belongs_to :teacher, class_name: 'User'
  has_many :comments
  scope :category_search, ->(category , course) {
    where("courses.title LIKE ? AND courses.category_id IN (SELECT id FROM categories WHERE title LIKE ?)", "%#{course}%", "%#{category}%")
  }
  
  enum level: {
    "All Level": "All Level",
    "Beginner": "Beginner",
    "Intermediate": "Intermediate",
    "Advanced": "Advanced",
    "Expert": "Expert"
  }
  has_one_attached :thumbail

  attribute :remove_thumbail, :boolean
  after_save -> { thumbail.purge }, if: :remove_thumbail

  scope :courses_for_event, ->(event_id) { includes(:categories).where(event_id: event_id) }
  # before_save :set_event

  # def set_event
  #   self.event_id = event.try(:id)
  # end
end
