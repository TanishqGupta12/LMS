class HomeController < ApplicationController

  def index
    @event = Event.find_by(location: get_host)
    @categories_data = Category.includes(:sub_captions).where(event_id: @event.try(:id))
    @teacher_data =  User.teachers_for_event(@event.id)
    @course_data =  Course.courses_for_event(@event.id)
  end
  # event_login GET    /homes/:event_id/login
  def login
    
  end

  def sign_up
    
  end
  def about
    
  end

  def contact
    
  end

  def course
    
  end

  def teacher
    
  end
end
