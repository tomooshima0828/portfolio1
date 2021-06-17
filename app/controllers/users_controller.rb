class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show]

  def show
    @user = User.find_by(params[:email])
  end

  def index
    @user = User.find_by(params[:email])
    @users = User.all
  end

  def new
  end

  def edit
  end
end
