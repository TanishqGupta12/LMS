class Blog < ApplicationRecord

  has_one_attached :image

  attribute :remove_image, :boolean
  after_save -> { image.purge }, if: :remove_image
  
  belongs_to :user
  belongs_to :event
end
