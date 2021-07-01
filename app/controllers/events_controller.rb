class EventsController < ApplicationController
  
  def new
    @event = Event.new
    
  end

  def create
    
    @event = Event.new(event_params)
    @event.user = current_user
    if @event.save!
      flash[:success] = "予約リクエストに成功しました。"
      redirect_to user_events_path and return
    else
      render :new
    end
  rescue
    flash[:danger] = "予約リクエストに失敗しました。"
    redirect_to user_events_path and return
  end

  def edit
    @event = Event.find(params[:id])
    
  end

  def update
    @event = Event.find(params[:id])
    
    if @event.update_attributes!(event_params)
     flash[:success] = "予約情報の更新に成功しました。"
     redirect_to user_events_path(current_user)
    else
    flash[:danger] = "予約情報の更新に失敗しました。"
    render :edit
    end
  end

  def show
  end

  def index
    @events = Event.where(user_id: current_user.id).where("started_at >= ?", Date.today).order(started_at: "ASC")
    
  end

  def destroy 
    event = Event.find(params[:id]) # paramsにidが入っているので、それを取得してローカル変数に代入する
    event.destroy # ローカル変数に入ったオブジェクトを削除する
    flash[:success] = "予約リクエストを削除しました。"
    redirect_to user_events_path
  end

  def edit_account_info
    @user = current_user
  end

  def update_account_info
    current_user.update_attributes!(user_params)
    flash[:success] = "ユーザー情報を更新しました"
    redirect_to user_events_path(current_user) and return
  rescue
    flash[:danger] = "ユーザー情報の更新に問題がありました"
    redirect_to user_events_path(current_user) and return
  end

  

  private

  

end
