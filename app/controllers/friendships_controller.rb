class FriendshipsController < ApplicationController
  include FriendshipsHelper

  before_action :authenticate_user!

  def create
    return if current_user.id == params[:user_id]
    return if friend_request_sent?(User.find(params[:user_id]))
    return if friend_request_received?(User.find(params[:user_id]))

    @user = User.find(params[:user_id])
    @friendship = current_user.request_sent.build(receiver_id: params[:user_id])
    if @friendship.save
      flash[:success] = 'Request sent.'
    else
      flash[:danger] = 'Request failed to send.'
    end
    redirect_to root_path
  end

  def destroy
  end
end
