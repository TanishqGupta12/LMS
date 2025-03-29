class Banner < ApplicationRecord
  belongs_to :event
  has_one_attached :gallery

  attribute :remove_gallery, :boolean
  after_save -> { gallery.purge }, if: :remove_gallery

  validates :title, :description , presence: true
  
end
