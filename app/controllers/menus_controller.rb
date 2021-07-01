class MenusController < ApplicationController
  before_action :current_user_admin?
  
  def index
    @menus = Menu.all
  end

  def show
  end

  def new
  end

  def edit
  end
end
