class Event < ApplicationRecord

  has_one_attached :icon

  attribute :remove_icon, :boolean
  after_save -> { image.purge }, if: :remove_icon

  has_many :categories
  has_many :contacts
  has_many :banners
  has_many :courses
  has_many :forms
  has_many :tickets
  has_many :blogs , dependent: :delete_all

end
