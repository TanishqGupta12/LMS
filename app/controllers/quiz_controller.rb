class QuizController < ApplicationController

  def index
    @questions = QuizQuestion.includes(:quiz_question_options).where(lesson_id: params[:lesson]).order(:sequence)
  end

  def review

    answers_params = params.require(:answers).permit!
    answers_params.each do |question_id, answer_data|

      attempt = QuizAttemptResult.new 
      attempt.user_id = current_user.id
      attempt.quiz_topic_id = params[:quiz_topic]
      attempt.lesson_id = params[:lesson]

      option =  QuizQuestionOption.find(answer_data["option_id"])
      question =  QuizQuestion.find(answer_data["question_id"])

      attempt.question = question.try(:title)
      attempt.answer = option.try(:title)
      attempt.quiz_question_id = question.try(:id)
      attempt.quiz_question_option_id = option.try(:id)

      if option.is_right == true
        attempt.is_right = 1
        attempt.is_wrong = 0
      else
        attempt.is_wrong = 1
        attempt.is_right = 0
      end

      attempt.save!
     
    end

    redirect_to quiz_index_path(quiz_topic: params[:quiz_topic]  ,lesson: params[:lesson] , review: true )
  end
end
