class QuizController < ApplicationController

  def index
    session[:course_url] = nil
    @course = QuizTopic.find_by(id: params[:quiz_topic]).course
    @questions = QuizQuestion.includes(:quiz_question_options).where(lesson_id: params[:lesson]).order(:sequence)
    @quiz_attempts =  QuizAttempt.find_by(user_id:current_user.id ,quiz_topic_id: params[:quiz_topic] ,lesson_id: params[:lesson] )
    @result =  QuizResult.find_by(user_id:current_user.id ,quiz_attempt_id: @quiz_attempts.id)
    session[:course_url] = request.referer
  end

  def review
    quiz_attempts =  QuizAttempt.find_or_create_by(user_id:current_user.id ,quiz_topic_id: params[:quiz_topic] ,lesson_id: params[:lesson] )
    marks_gained = 0 
    answers_params = params.require(:answers).permit!
    answers_params.each do |question_id, answer_data|

      option =  QuizQuestionOption.find(answer_data["option_id"])
      question =  QuizQuestion.find(answer_data["question_id"])

      attempt = QuizAttemptResult.find_or_create_by(user_id:current_user.id ,quiz_question_id:question.try(:id)) 

      attempt.quiz_topic_id = params[:quiz_topic]
      attempt.lesson_id = params[:lesson]

      attempt.question = question.try(:title)
      attempt.answer = option.try(:title)
      attempt.quiz_question_id = question.try(:id)
      attempt.quiz_question_option_id = option.try(:id)

      if option.is_right == true
        attempt.is_right = 1
        attempt.is_wrong = 0
        marks_gained = marks_gained + question.try(:marks)
      else
        attempt.is_wrong = 1
        attempt.is_right = 0
      end

      attempt.save!
     
    end

    quiz_attempts.marks_gained = marks_gained
    quiz_attempts.save!

    redirect_to quiz_index_path(quiz_topic: params[:quiz_topic]  ,lesson: params[:lesson] , review: 'true' )
  end
  def full_submit
    result =  QuizResult.new
    result.user_id = current_user.id
    result.quiz_attempt_id = params[:quiz_attempts]
    result.is_pass = true
    result.save!
    redirect_to session[:course_url]
  end

  def course_url
    # if content.present?
      cache [params[:token], Time::now.to_s] do
        respond_to do |format|
            format.html
            format.pdf do
              puts 'hello'
              render :pdf => "report", margin:  {   top: 3,bottom: 0,left: 1,right: 1, }, template: "layouts/user_details_after_scan", :formats => [:html], :encoding => "UTF-8", :page_height => access_point.try(:height_in_mm), :page_width => access_point.try(:width_in_mm), :locals => { :user => user, :content => content }
            end
        end and return
      end
    # end
  end
end
