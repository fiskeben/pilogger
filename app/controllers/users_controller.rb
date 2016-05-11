class UsersController < ApplicationController

  before_action :set_user, except: [:index]

  def index
    @users = User.all
  end

  def show
    @events = @user.events_in_duration(params[:from], params[:to])
  end

  protected
  def set_user
    @user = User.find_by_username!(params[:username])
  end
end
