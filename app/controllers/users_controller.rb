class UsersController < ApplicationController

  before_action :set_user, except: [:index]
  before_action :prepend_view_paths

  def index
    @users = User.all
  end

  def show
    @events = @user.events_in_duration(params[:from], params[:to])
    if template_exists?("index", @user.username)
      render "#{@user.username}/index"
    end
  end

  protected

  def set_user
    @user = User.find_by_username!(params[:username])
  end

  def prepend_view_paths
    prepend_view_path("custom-views")
  end
end
