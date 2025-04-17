class TeacherController < ApplicationController
  
  def index
    @teachers = User.teachers_for_event(params[:event_id])
  end

  def show
    
  end
 end