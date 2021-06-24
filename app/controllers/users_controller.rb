class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show]
  before_action :current_user_admin?, only: [:index]

  def show # スタッフの業務管理ページ
    
    @users = User.joins(:events).group("users.id").where(events: { status_event_request: "リクエスト中" } )
    @events = Event.where("started_at >= ?", Date.today).order(started_at: "ASC")
    
  end

  def index
    @user = User.find_by(params[:id])
    @users = User.all
    
  end

  def new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    current_user.update_attributes!(user_params)
    flash[:success] = "ユーザー情報を更新しました"
    redirect_to current_user and return
  rescue
    flash[:danger] = "ユーザー情報の更新に問題がありました"
    redirect_to current_user and return
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    flash[:success] = "ユーザーを削除しました。"
    redirect_to users_path(current_user)
  end

  private

  def user_params
    params.require(:user).permit(:name, :email)
  end

  def current_user_admin?
    unless current_user.admin?
      redirect_to root_url
    end
  end

end
