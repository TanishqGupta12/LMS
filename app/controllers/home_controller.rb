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
    @event = Event.find_by(id: params[:event_id])
  end

  def contact
    @event = Event.find_by(id: params[:event_id])
  end

  def contact_create
    @contact = Contact.new(contact_params)
    
    if @contact.save
      flash[:notice] = "Contact request submitted successfully!"
      redirect_to root_path
    else
      flash[:alert] = @contact.errors.full_messages.join(", ")
      redirect_to contact_path(params[:event_id])
    end

  end

  def course
    
  end

  def teacher
    
  end

  private

  def contact_params
    params.permit(:name, :email, :subject, :message, :event_id)
  end

end
