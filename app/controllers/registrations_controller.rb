class RegistrationsController < Devise::RegistrationsController
  # GET /resource/sign_in
  def new
    if params[:teacher] == "true" 
      redirect_to sign_up_url(event_id: params[:event_id] , teacher: 'true') and return
    else
      redirect_to sign_up_url(event_id: params[:event_id]) and return
    end
  end

def create
  @user = User.new()
  @user.first_name = params[:first_name]
  @user.last_name = params[:last_name]
  @user.f1 = params[:dob]
  @user.mobile = params[:phone]

  @user.email = params[:email]
  @user.password = params[:password]


  @user.current_event_id = @event.try(:id)

  if params[:teacher] == "true"
    @user.role_id = Role.find_by(name: "Teacher").try(:id)
    @user.position = params[:position]
     
  else
    @user.role_id = Role.find_by(name: "Normal").try(:id)

  end
  if @user.save
    # sign_up(@user)
    sign_in(@user,:bypass => true)
    session[:user_id] = @user.id  # Log the user in after signup
    redirect_to root_path, notice: "Successfully registered and logged in."
  else
    render :new, status: :unprocessable_entity
  end
end

end