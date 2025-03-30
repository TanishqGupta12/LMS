class CourseController < ApplicationController
  
 def index
  # Correct Query Usage
  # @course = Course.includes(:category)

  @categorys = Category.includes(:courses).where(event_id:params[:event_id])
 end
end