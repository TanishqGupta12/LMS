class SessionsController < Devise::SessionsController
  # GET /resource/sign_in
  def new
    redirect_to main_app.login_url(event_id: session[:event_id]) and return
  end

end