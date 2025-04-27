class QuizController < ApplicationController

  def index
    @questions = QuizQuestion.includes(:quiz_question_options).where(lesson_id: params[:lesson]).order(:sequence)
  end

  def review

    answers_params = params.require(:answers).permit!
    answers_params.each do |question_id, answer_data|
      option_id = answer_data["option_id"]
      question_id = answer_data["question_id"]
      puts option_id
      puts question_id
     
    end
  end
end
