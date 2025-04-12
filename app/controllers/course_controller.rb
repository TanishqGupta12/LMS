class CourseController < ApplicationController
  before_action :authenticate_user!, only: [:show]
 def index
  @event = @event
  @courses = Course.includes(:ticket).where(event_id: @event.id).category_search(params[:category], params[:course]) .page(params[:page]).per(5)
 end

 def show
  @event = @event
  @courses = Course.includes(:quiz_topics).find_by(id: params[:id])

  @quiz_topic_size = QuizTopic.where(course_id: params[:id]).size()

  respond_to do |format|
    format.js 
    format.html
  end

 end

  def course_favoritor
    @event = @event
    @courses = Course.includes(:quiz_topics).find_by(id: params[:id])
    if current_user.favorited?(@courses)
      current_user.unfavorite(@courses)
    else
      current_user.favorite(@courses)
    end
    render partial: "course/favorite_button", locals: { course: @courses, event: @event } , formats: :html
  end

end