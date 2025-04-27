class QuizController < ApplicationController

  def index
    @questions = QuizQuestion.includes(:quiz_question_options).where(lesson_id: params[:lesson]).order(:sequence)
  end
end
