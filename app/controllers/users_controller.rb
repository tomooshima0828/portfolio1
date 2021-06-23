class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show]
  before_action :current_user_admin?, only: [:index]

  def show
    @user = User.find_by(params[:email])
    @events = Event.all
    
  end

  def index
    @user = User.find_by(params[:email])
    @users = User.all
    
  end

  def new
  end

  def edit
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    flash[:success] = "ユーザーを削除しました。"
    redirect_to users_path(current_user)
  end

  private

  def current_user_admin?
    unless current_user.admin?
      redirect_to root_url
    end
  end

end
