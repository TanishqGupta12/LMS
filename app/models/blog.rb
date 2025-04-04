class Blog < ApplicationRecord

  has_one_attached :image

  attribute :remove_image, :boolean
  after_save -> { image.purge }, if: :remove_image

  belongs_to :user
  belongs_to :event
  belongs_to :category

  scope :category_search, ->(category_id) {
    where(category_id: category_id) if category_id.present?
  }
  
end
