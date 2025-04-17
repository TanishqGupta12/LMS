class TeacherController < ApplicationController
  
  def index
    @teachers = User.teachers_for_event(params[:event_id])
  end

  def show
    @teachers = User.find(params[:id])
  end
 end