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
    @event = load_events
    @user = User.new
    @user.first_name = params[:first]
    @user.last_name = params[:last]
    @user.f1 = params[:dob]
    @user.mobile = params[:phone]
    @user.email = params[:email]
    @user.password = params[:password]
    @user.current_event_id = @event&.id

    if params[:teacher] == "true"
      @user.role_id = Role.find_by(name: "Teacher")&.id
      @user.position = params[:position]
    else
      @user.role_id = Role.find_by(name: "Normal")&.id
    end

    if @user.save
      session[:user_id] = @user.id

      if params[:teacher] == "true"
        Stripe.api_key = @event&.secret_key
        stripe_session = Stripe::Checkout::Session.create(
          payment_method_types: ['card'],
          customer_email: @user.email,
          client_reference_id: @user.authentication_token,
          line_items: [{
            price_data: {
              currency: "USD",
              product_data: {
                name: "Teacher Registration"
              },
              unit_amount: 500 * 100
            },
            quantity: 1
          }],
          mode: 'payment',
          success_url: success_home_url(@user.id),
          cancel_url: cancel_home_url(@user.id)
        )

        @user.f14 = stripe_session.id
        @user.save!
        
      redirect_to stripe_session.url, allow_other_host: true
      else
        sign_in(@user, bypass: true)
        redirect_to root_path, notice: "Successfully registered and logged in."
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

end