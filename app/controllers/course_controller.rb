class CourseController < ApplicationController
  
 def index
  # Correct Query Usage "category"=>"Web developer", "course"=>"Angular"
  # @course = Course.includes(:category)
  # Paginate results
   # Show 10 records per page

  @courses = Course.includes(:ticket).where(event_id: @event.id).category_search(params[:category], params[:course]) .page(params[:page]).per(1)
 end
end