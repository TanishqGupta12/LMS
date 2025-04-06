class AddVideoButtonToQuizQustion < ActiveRecord::Migration[7.2]
  def change
    add_column :quiz_questions, :enable_video_update, :boolean, default: true
  end
end
