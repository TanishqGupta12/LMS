require 'streamio-ffmpeg'
class Lesson < ApplicationRecord
  belongs_to :quiz_topic , optional: true

  has_one_attached :media

  attribute :remove_media, :boolean
  after_save -> { media.purge }, if: :remove_media

  after_commit :extract_video_duration, on: [:create, :update], if: -> { media.attached? && media.video? }


  def extract_video_duration
    return unless media.video?

    media.open(tmpdir: Dir.tmpdir) do |file|
      movie = FFMPEG::Movie.new(file.path)
      raw_duration = movie.duration

      # Format the duration
      minutes = (raw_duration / 60).floor
      seconds = (raw_duration % 60).round
      formatted = minutes > 0 ? "#{minutes}min #{seconds}sec" : "#{seconds}sec"

      update_column(:duration, formatted)
    end

  end


end
