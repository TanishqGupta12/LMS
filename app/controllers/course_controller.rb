class CourseController < ApplicationController
  before_action :authenticate_user!, only: [:show]
 def index
  @event = @event
  @courses = Course.includes(:ticket).where(event_id: @event.id).category_search(params[:category], params[:course]) .page(params[:page]).per(5)
 end

 def show
  debugger
  @event = @event
  @courses = Course.includes(:quiz_topics).includes(:reviews).includes(:user_courses).find_by(id: params[:id])

  @lesson = @courses.quiz_topics.first.lessons.order(:sequence).first

  @quiz_topic_size = QuizTopic.where(course_id: params[:id]).size()

  respond_to do |format|
    format.js 
    format.html
  end

 end

  def course_favoritor
    @event = @event
    @courses = Course.find_by(id: params[:id])
    if current_user.favorited?(@courses)
      current_user.unfavorite(@courses)
    else
      current_user.favorite(@courses)
    end
    render partial: "course/favorite_button", locals: { course: @courses, event: @event } , formats: :html
  end

  def lesson_video

    render partial: "course/favorite_button", locals: { course: @courses, event: @event } , formats: :html
  end

end