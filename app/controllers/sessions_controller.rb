class SessionsController < Devise::SessionsController
  # GET /resource/sign_in
  def new
    redirect_to main_app.login_url(event_id: session[:event_id]) and return
  end

  def create
    user = User.find_by(email: params[:user][:email])

    if !user.present?
      flash[:alert] = "Email not Found"
      redirect_to login_url(event_id: session[:event_id]) and return
    else
      if user.present? && user.role.try(:name) == "Teacher" && user.banned == true
          flash[:alert] = "Administration not approved account"
          redirect_to login_url(event_id: session[:event_id]) and return
      end
    end
    super
  end

end