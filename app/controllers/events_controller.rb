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
    
    @events = Event.all
  end

  def destroy 
    event = Event.find(params[:id]) # paramsにidが入っているので、それを取得してローカル変数に代入する
    event.destroy # ローカル変数に入ったオブジェクトを削除する
    flash[:success] = "予約リクエストを削除しました。"
    redirect_to user_events_path
  end

  private

  def event_params
    params.require(:event).permit(:title, :started_at, :finished_at, :note)
  end

end
