class CreateLessons < ActiveRecord::Migration[7.2]
  def change
    create_table :lessons do |t|
      t.string :title
      t.boolean :enable_video_update ,default: true
      t.text :content
      t.string :video_url
      t.integer :duration
      t.integer :sequence
      t.boolean :is_published
      t.references :quiz_topic, null: true, foreign_key: { on_delete: :nullify }

      t.timestamps
    end

    add_reference :quiz_questions, :lesson, foreign_key: { on_delete: :nullify }

  end
end