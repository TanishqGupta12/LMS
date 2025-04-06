class CourseController < ApplicationController
  before_action :authenticate_user!, only: [:show]
 def index
  @courses = Course.includes(:ticket).where(event_id: @event.id).category_search(params[:category], params[:course]) .page(params[:page]).per(5)
 end

 def show
  @courses = Course.find_by(id: params[:id])
  @quiz_topic_size = QuizTopic.where(course_id: params[:id]).size()
 end
end