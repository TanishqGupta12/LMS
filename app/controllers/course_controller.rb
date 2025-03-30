class CourseController < ApplicationController
  
 def index
  # Correct Query Usage
  @course = Course.includes(:category, :sub_captions)
 end
end