class Course < ApplicationRecord

  acts_as_votable
  acts_as_favoritable
  belongs_to :ticket , optional: true
  belongs_to :event, optional: true
  belongs_to :category , optional: true
  belongs_to :teacher, class_name: 'User'

  has_many :quiz_topics, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :faqs, dependent: :destroy
  has_many :user_courses, dependent: :destroy
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

  has_one_attached :video

  attribute :remove_video, :boolean
  after_save -> { video.purge }, if: :remove_video

  scope :courses_for_event, ->(event_id) { includes(:categories).where(event_id: event_id) }
  # before_save :set_event

  # def set_event
  #   self.event_id = event.try(:id)
  # end
end
