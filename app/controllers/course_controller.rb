class CourseController < ApplicationController
  
 def index
  # Correct Query Usage
  # @course = Course.includes(:category)

  @course = Category
 end
end