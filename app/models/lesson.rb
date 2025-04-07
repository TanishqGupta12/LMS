class Lesson < ApplicationRecord
  belongs_to :quiz_topic , optional: true

  has_one_attached :media

  attribute :remove_media, :boolean
  after_save -> { image.purge }, if: :remove_media
end
