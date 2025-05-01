class AddLessonToUserNotes < ActiveRecord::Migration[7.2]
  def change
    add_reference :user_notes, :lesson, null: true, foreign_key: true
  end
end
