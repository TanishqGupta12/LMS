class ContactController < ApplicationController
  
  def new
    @event = Event.find_by(id: params[:event_id])
  end

  def create
    @contact = Contact.new(contact_params)
    
    if @contact.save
      flash[:notice] = "Contact request submitted successfully!"
      redirect_to contact_path(params[:event_id])
    else
      flash[:alert] = @contact.errors.full_messages.join(", ")
      redirect_to contact_path(params[:event_id])
    end
  end

  private

  def contact_params
    params.permit(:name, :email, :subject, :message, :event_id)
  end
end