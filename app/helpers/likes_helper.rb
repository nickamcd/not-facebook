module LikesHelper
  def already_liked?(post)
    like = post.likes.where(user_id: current_user.id)
    like.any?
  end

  def current_like(post)
    like = current_user.likes.find_by(post_id: post.id)
    like
  end
end
