class CourseController < ApplicationController
  before_action :authenticate_user!, only: [:show]
 def index
  @event = @event
  @courses = Course.includes(:ticket).where(event_id: @event.id).category_search(params[:category], params[:course]) .page(params[:page]).per(5)
 end

 def show
  @event = @event
  @courses = Course.includes(:quiz_topics).includes(:reviews).includes(:user_courses).find_by(id: params[:id])
  @quiz_topic_size = QuizTopic.where(course_id: params[:id]).size()

  @user_notes = UserNote.where(user_id: current_user.try(:id) ,course_id:  params[:id])

  if params[:lesson].present?
    @lesson = Lesson.find(params[:lesson])
    render partial: "course/courses_details", locals: { courses: @courses, event: @event, lesson: @lesson, quiz_topic_size: @quiz_topic_size }
  else
    quiz_topic = @courses&.quiz_topics&.first
    @lesson = quiz_topic&.lessons&.order(:sequence)&.first
  end

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