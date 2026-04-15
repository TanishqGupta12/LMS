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

  def completed_course
    courses =  params[:id] || params[:course]
    @course = Course.find(courses)
    @event = @event
  end

  def course_url
    courses =  params[:id] || params[:course]
    @course = Course.find(courses)
    pdf = WickedPdf.new.pdf_from_string(
      render_to_string(
        template: '/pdf/certification',
        encoding: 'UTF-8',
        layout: false,
        locals: {course: @course},
        formats: [:pdf ,:html],
        orientation: "Landscape"
      )
    )
    send_data pdf, :filename => "#{current_user.try(:name)} #{ @course.try(:title)}.pdf", :type => "application/pdf", :disposition => "attachment", :encoding => "utf8"
    # if content.present?
      # cache [params[:token], Time::now.to_s] do
      #   respond_to do |format|
      #       format.html
      #       format.pdf do
      #         puts 'hello'
      #         render :pdf => "report", margin:  {   top: 3,bottom: 0,left: 1,right: 1, }, template: "layouts/user_details_after_scan", :formats => [:html], :encoding => "UTF-8", :page_height => access_point.try(:height_in_mm), :page_width => access_point.try(:width_in_mm), :locals => { :user => user, :content => content }
      #       end
      #   end and return
      # end
    # end
  end

end