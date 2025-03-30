class HomeController < ApplicationController

  def index
    @event = Event.includes(:banners).find_by(location: get_host)
    @caraousel_data = @event.try(:banners)
    @categories_data = Category.includes(:courses).where(event_id: @event.try(:id))
    @teacher_data =  User.teachers_for_event(@event.id)
    @course_data =  Course.courses_for_event(@event.id)
  end

  def login
    
  end

  def category
    
  end

  def sign_up
    
  end
  def about
    @event = Event.find_by(id: params[:event_id])
  end


  def course
    @event = Event.find_by(id: params[:event_id])
  end

  def teacher
    @event = Event.find_by(id: params[:event_id])
  end

  def terms_and_conditions
    @event = Event.find_by(id: params[:event_id])
  end

  def privacy
    @event = Event.find_by(id: params[:event_id])
  end



end
