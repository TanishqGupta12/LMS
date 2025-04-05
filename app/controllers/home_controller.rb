class HomeController < ApplicationController

  def index
    @event = Event.includes(:banners).find_by(location: get_host)
    @caraousel_data = @event.try(:banners)
    @categories_data = Category.includes(:courses).where(event_id: @event.try(:id))
    @teacher_data =  User.teachers_for_event(@event.id)
    @courses = Course.includes(:ticket).where(event_id: @event.id)
  end

  def login
    
  end

  def category
    
  end

  def sign_up
    
  end
  def about
    @event =  load_events #Event.find_by(id: params[:event_id])
  end


  def course
    @event =  load_events #Event.find_by(id: params[:event_id])
  end

  def teacher
    @event =  load_events #Event.find_by(id: params[:event_id])
  end

  def terms_and_conditions
    @event =  load_events #Event.find_by(id: params[:event_id])
  end

  def privacy
    @event =  load_events #Event.find_by(id: params[:event_id])
  end

  def search
    debugger
  
    # respond_to do |format|
    #   format.turbo_stream { render partial: "users/list", locals: { users: @users } }
    # end
  end

  # def blog
  #   @event =  load_events #Event.find_by(id: params[:event_id])
  #   @blogs = Blog.where(event_id:  @event.try(:id) ).order(:created_at)
  # end

end
