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


  # if current_user.favorited?(@course)
  #   current_user.unfavorite(@course)
  # else
  #   current_user.favorite(@course)
  # end

  respond_to do |format|
    format.js 
    format.html
  end

 end
end