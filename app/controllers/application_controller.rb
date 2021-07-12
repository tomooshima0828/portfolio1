class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  # ログイン後の遷移先を指定する。resourceはuserのこと
  def after_sign_in_path_for(resource)
    users_path(resource)
  end

  private
  
  def user_params
    params.require(:user).permit(:name, :email, :phone, :address, :control_number)
  end

  def event_params
    params.require(:event).permit(:title, :started_at, :finished_at, :note, :status_event_request, :selector_stylist_request)
  end

  def current_user_admin?
    unless current_user.admin?
      redirect_to root_url
    end
  end

  

  
 
end
