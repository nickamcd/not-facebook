class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    like = current_user.likes.create(post_id: params[:post_id])
    @post = Post.find(params[:post_id])

    Notification.create(recipient: @post.user, actor: current_user, action: "liked", notifiable: @post)

    redirect_to posts_path
  end

  def destroy
    @like = current_user.likes.find(params[:id])
    @like.destroy
    redirect_to posts_path
  end
end
