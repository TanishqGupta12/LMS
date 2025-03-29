class Event < ApplicationRecord

  has_many :categories
  has_many :contacts
  has_many_attached :gallery

  attribute :remove_gallery, :boolean
  after_save -> { gallery.purge }, if: :remove_gallery
end
