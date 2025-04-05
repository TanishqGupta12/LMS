class CourseController < ApplicationController
  
 def index
  @courses = Course.includes(:ticket).where(event_id: @event.id).category_search(params[:category], params[:course]) .page(params[:page]).per(5)
 end

 def show
   
 end
end