class UsersController < ApplicationController
  before_action :authenticate_user!
  def index
    
  end

  # sign_up
  def new
  
  end

  def create
    
  end

  def show
  end
  
  def edit
  end

  def update
  end

  def destroy
    @user = User.find_by(id: params[:id] , current_event_id: params[:current_event_id])

    if @user.nil?
      flash[:alert] = "User not found"
      redirect_to request.referer || root_path
      return
    end

    begin
      @user.destroy!
      flash[:alert] = "User deleted successfully"
      redirect_to login_url(event_id: session[:event_id]) and return
    rescue ActiveRecord::RecordNotDestroyed => e
      flash[:alert] = "Failed to delete user: #{e.message}"
      redirect_to request.referer || root_path
    end

  end

  def user_payment_info
  end
end
