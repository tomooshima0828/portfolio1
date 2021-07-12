class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show]
  before_action :current_user_admin?, only: [:index, :admin_top, :admin_events]
  
  

  def show # スタッフの業務管理ページ
    @user = User.find(params[:id])
    
    @users = User.joins(:events).group("users.id").order(name: :asc).where("started_at >= ?", Date.today)
    @events = Event.where("started_at >= ?", Date.today).order(started_at: :asc)
    
    if !current_user.admin?
      redirect_to root_url unless @user == current_user
    end
  end

  def index
    @user = User.find_by(params[:id])
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.find(params[:id])
    @user = User.create!(user_params)
    flash[:success] = "新規ユーザーの作成に成功しました"
    redirect_to users_path(current_user) and return
  rescue
    flash[:danger] = "ユーザー情報の作成に問題がありました"
    redirect_to users_path(current_user) and return
  end

  def edit
    
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update_attributes!(user_params)
    flash[:success] = "ユーザー情報を更新しました"
    redirect_to user_path(@user) and return
  rescue
    flash[:danger] = "ユーザー情報の更新に問題がありました"
    redirect_to user_path(@user) and return
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    flash[:success] = "ユーザーを削除しました。"
    redirect_to users_path(current_user)
  end

  def edit_event_response
    @event = Event.find(params[:format]) 
    @menus = Menu.all
    @users = User.where(staff: true).where.not(admin: true) # 担当者全員
  end

  def update_event_response
    
    event = Event.find(params[:id])
    if event.update_attributes(event_params)
      flash[:success] = "お客様リクエストを更新しました"
      redirect_to user_path(current_user)
    else
      flash[:danger] = "お客様リクエストの更新に失敗しました"
      render 'edit_event_response_user_path(current_user)'
    end
  end

  def destroy_event_response
    
    event = Event.find(params[:format]) # paramsにidが入っているので、それを取得してローカル変数に代入する
    event.destroy # ローカル変数に入ったオブジェクトを削除する
    flash[:success] = "予約リクエストを削除しました。"
    redirect_to user_path(current_user)
  end

  def update_request_status
    
    event = Event.find(params[:format])
    if event.update_attributes(event_status_params)
      flash[:success] = "お客様リクエストを更新しました"
      redirect_to user_path(current_user)
    else
    flash[:danger] = "お客様リクエストの更新に失敗しました"
    render "user_path(current_user)"
    end
  end

  def admin_top
  end

  def admin_events
    @present_users = User.joins(:events).group("users.id").order(name: :asc).where("started_at >= ?", Date.today)
    @past_users = User.joins(:events).group("users.id").order(name: :asc).where("started_at < ?", Date.today)

    @present_events = Event.where("started_at >= ?", Date.today).order(started_at: :asc)
    @past_events = Event.where("started_at < ?", Date.today).order(started_at: :asc)
  end

  def edit_admin_event_response
    @event = Event.find(params[:format]) 
    @menus = Menu.all
    @users = User.where(staff: true).where.not(admin: true) # 担当者全員
  end

  def update_admin_event_response
    event = Event.find(params[:id])
    if event.update_attributes(event_params)
      flash[:success] = "お客様リクエストを更新しました"
      redirect_to admin_events_user_path(current_user)
    else
      flash[:danger] = "お客様リクエストの更新に失敗しました"
      render 'edit_admin_event_response_user_path(current_user)'
    end
  end

  def destroy_admin_event_response
    event = Event.find(params[:format])
    event.destroy
    flash[:success] = "予約リクエストを削除しました。"
    redirect_to admin_events_user_path(current_user)
  end

  def update_admin_request_status
    
    event = Event.find(params[:format])
    if event.update_attributes(event_status_params)
      flash[:success] = "お客様リクエストを更新しました"
      redirect_to admin_events_user_path(current_user)
    else
    flash[:danger] = "お客様リクエストの更新に失敗しました"
    render "admin_events_user_path(current_user)"
    end
  end


  def user_event_new
    @event = Event.new
  end

  def user_event_create
    
    @user = User.find_by(control_number: params[:user][:control_number])
    @event = Event.new(event_params)

    @event.save!
    flash[:success] = "新規予約リクエストの作成に成功しました"
    redirect_to user_path(current_user) and return
  rescue
    flash[:danger] = "新規予約リクエストの作成に失敗しました"
    redirect_to user_path(current_user) and return
  end

  

  private

  def event_status_params
    params.permit(:status_event_request)
  end
  
end
