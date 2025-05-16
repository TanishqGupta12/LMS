class RegistrationsController < Devise::RegistrationsController
  # GET /resource/sign_in
  def new
    redirect_to sign_up_url(event_id: params[:event_id]) and return
  end

  def create
    
  end

end