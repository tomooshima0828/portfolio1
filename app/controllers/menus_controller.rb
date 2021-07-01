class MenusController < ApplicationController
  before_action :current_user_admin?
  
  def index
    @menus = Menu.all
  end

  def show
    @menu = Menu.find(params[:id])
  end

  def new
    @menu = Menu.new
  end

  def create
    @menu = Menu.find(params[:id])
    @menu = Menu.create!(menu_params)
    flash[:success] = "新規メニューの作成に成功しました"
    redirect_to menus_path(current_user) and return
  rescue
    flash[:danger] = "新規メニューの作成に問題がありました"
    redirect_to menus_path(current_user) and return
  end

  def edit
    @menu = Menu.find(params[:id])
  end

  def update
    @menu = Menu.find(params[:id])
    if @menu.update_attributes!(menu_params)
      flash[:success] = "メニュー情報の更新に成功しました。"
     redirect_to menus_path(current_user)
    else
      render :edit
    end
  end

  def destroy
    menu = Menu.find(params[:id])
    menu.destroy
    flash[:success] = "メニューを削除しました。"
    redirect_to menus_path(current_user)
  end

  private
  
  def menu_params
    params.require(:menu).permit(:item, :item_number, :price, :description)
  end

end
