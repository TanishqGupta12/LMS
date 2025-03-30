class TeacherController < ApplicationController
  
  def index
    @teachers = User.joins(:role).includes(:role).where(roles: { name: 'Teacher', active: true })
  end
 end