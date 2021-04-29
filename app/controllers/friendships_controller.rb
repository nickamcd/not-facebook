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
      Notification.create(recipient: @user, actor: current_user, action: "would like", notifiable: @friendship)
    else
      flash[:danger] = 'Request failed to send.'
    end
    redirect_to root_path
  end

  def accept
    @friendship = Friendship.find_by(sender_id: params[:user_id], receiver_id: current_user.id, status: false)

    @friendship.status = true
    if @friendship.save
      flash[:success] = 'Friend Request Accepted!'
      @inverse_friendship = current_user.request_sent.build(receiver_id: params[:user_id], status: true)
      @inverse_friendship.save
    else
      flash[:danger] = 'Something went wrong...'
    end
    redirect_to root_path
  end

  def deny
    @friendship = Friendships.find_by(sender_id: params[:user_id], receiver_id: current_user.id, status: false)
    
    @friendship.destroy
    flash[:success] = 'Friend Request Declined!'
    redirect_to root_path
  end

  def destroy
    @friendship = Friendships.find_by(sender_id: params[:user_id], receiver_id: current_user.id, status: false)
    
    @friendship.destroy
    flash[:success] = 'Friend Removed'
    redirect_to root_path
  end
end
