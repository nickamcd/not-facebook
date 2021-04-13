class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    current_user.comments.create(post_id: params[:post_id])
    redirect_to posts_path
  end

  def destroy
    @comment = current_user.likes.find(params[:id])
    @comment.destroy
    redirect_to posts_path
  end
end
