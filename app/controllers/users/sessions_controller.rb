# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #    super
  # end

  # POST /resource/sign_in
  def create
    # redirect_to XXXXXX(current_user) 必ずcurrent_userを書くこと。
    # current_userにidが格納されている。paramsにはidが含まれない。
    if current_user.admin?
      redirect_to admin_top_user_path(current_user)
    elsif current_user.staff?
      redirect_to user_path(current_user)
    else
      redirect_to user_events_path(current_user)
    end
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

    # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
