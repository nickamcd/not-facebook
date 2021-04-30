class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
    @friends = current_user.friends
    @pending_requests = current_user.pending_requests
    @received_requests = current_user.received_requests
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end
end
