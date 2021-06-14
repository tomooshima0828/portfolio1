class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  
  def set_user
    @user = User.find(params[:id])
  end


end
