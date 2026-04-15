require 'streamio-ffmpeg'
class VideoDurationJob < ApplicationJob
  queue_as :default
  
  # Accept the video instance or video_id as arguments
  def perform(video_id)
    puts "job starigin"
    @formatted_duration = ''
    lesson_media = Lesson.find_by(id: video_id)
    
    lesson_media.media.open(tmpdir: Dir.tmpdir) do |file|
      movie = FFMPEG::Movie.new(file.path)
      raw_duration = movie.duration

      # Format the duration
      minutes = (raw_duration / 60).floor
      seconds = (raw_duration % 60).round
      formatted = minutes > 0 ? "#{minutes}min #{seconds}sec" : "#{seconds}sec"

      # lesson_media.update_column(:duration, formatted)
      @formatted_duration = formatted
      puts formatted
      puts "formatted"
    end
    lesson_media.update_column(:duration, @formatted_duration)

    puts "job stop"
  end
end
