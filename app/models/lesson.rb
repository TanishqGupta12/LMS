require 'streamio-ffmpeg'
class Lesson < ApplicationRecord
  belongs_to :quiz_topic , optional: true

  has_one_attached :media

  attribute :remove_media, :boolean
  after_save -> { media.purge }, if: :remove_media

  has_one_attached :thumbail

  attribute :remove_thumbail, :boolean
  after_save -> { thumbail.purge }, if: :remove_thumbail

  after_commit :extract_video_duration, on: [:create, :update], if: -> { media.attached? && media.video? }

  has_many :quiz_questions
  def extract_video_duration
    # Enqueue the job to extract the duration after the media is saved
    VideoDurationJob.perform_later(self.id)
  end
end
