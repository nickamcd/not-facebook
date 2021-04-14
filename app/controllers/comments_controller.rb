class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @comment = current_user.comments.build(comment_params)
    if @comment.save
      redirect_to posts_path
    else
      flash[:notice] = "Something went wrong."
      redirect_to posts_path
    end
  end

  def destroy
    @comment = current_user.likes.find(params[:id])
    @comment.destroy
    redirect_to posts_path
  end

  private

  def comment_params
    params.require(:comment).permit(:user_id, :post_id, :body)
  end
end
