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

  def edit_event_response
    @user = User.find(params[:id])
    @event = Event.find(params[:format])
  end

  def update_event_response
    
  end

  def destroy_event_response
    
    event = Event.find(params[:format]) # paramsにidが入っているので、それを取得してローカル変数に代入する
    event.destroy # ローカル変数に入ったオブジェクトを削除する
    flash[:success] = "予約リクエストを削除しました。"
    redirect_to user_path(current_user)
  end

  def update_request_status
    user = User.find(params[:id])
    event = Event.find(params[:format])
    

    event.update_attributes!(event_status_params)
    flash[:success] = "お客様リクエストを更新しました"
    redirect_to user_path(current_user) and return
  rescue
    flash[:danger] = "お客様リクエストの更新に失敗しました"
    redirect_to user_path(current_user) and return
  end

  private

  def event_status_params
    params.permit(:status_event_request)
  end
  

  def current_user_admin?
    unless current_user.admin?
      redirect_to root_url
    end
  end

end
