class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  # ログイン後の遷移先を指定する。resourceはuserのこと
  def after_sign_in_path_for(resource)
    users_path(resource)
  end

  private

  

  
  


end
