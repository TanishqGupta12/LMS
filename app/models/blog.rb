class Blog < ApplicationRecord

  has_one_attached :image

  has_one_attached :image do |attachable|
    attachable.variant :thumb, resize_to_limit: [80, 80]
  end

  attribute :remove_image, :boolean
  after_save -> { image.purge }, if: :remove_image

  belongs_to :user
  belongs_to :event
  belongs_to :category

  has_many :comments
  
  scope :category_search, ->(category_id) {
    where(category_id: category_id) if category_id.present?
  }

  scope :tags_search, ->(tag_se) {
    where("blogs.category_id IN (SELECT courses.category_id FROM courses WHERE tags LIKE ?)", "%#{tag_se}%")
  }
  
end
