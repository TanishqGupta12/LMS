# frozen_string_literal: true

class PasswordsController < Devise::PasswordsController
  layout :false
  # GET /resource/password/new
  # def new
  #   super
  # end

  # POST /resource/password
  # def create
  #   super
  # end

  # GET /resource/password/edit?reset_password_token=abcdef
  # def edit
  #   super
  # end

  # PUT /resource/password
  def update
    if params[:new_password].nil? || params[:Confirm_new_password].nil?
      flash[:alert] = "Failed User Update password"
      redirect_to request.referer || root_path
    end

    if params[:new_password] == params[:Confirm_new_password]
      user = User.find(params[:user_token])
      user.update(password: params[:new_password])
      flash[:notice] = "User Update password"
      sign_out(user)
      redirect_to after_sign_out_path_for(user)
    else
      flash[:alert] = "Failed User Update password"
      redirect_to request.referer || root_path
    end
  end

  # protected

  # def after_resetting_password_path_for(resource)
  #   super(resource)
  # end

  # The path used after sending reset password instructions
  # def after_sending_reset_password_instructions_path_for(resource_name)
  #   super(resource_name)
  # end
end
