class LikesController < ApplicationController
  def create
    like = current_user.likes.create(post_id: params[:post_id])
    puts like.errors.inspect
    redirect_to posts_path
  end

  def destroy
    @like = current_user.likes.find(params[:id])
    @like.destroy
    redirect_to posts_path
  end
end
