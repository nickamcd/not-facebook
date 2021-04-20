module FriendshipsHelper
  def friend_request_sent?(user)
    current_user.request_sent.exists?(receiver_id: user.id, status: false)
  end

  def friend_request_received?(user)
    current_user.request_received.exists?(sender_id: user.id, status: false)
  end

  def possible_friend?(user)
    friend_sent = current_user.request_sent.exists?(receiver_id: user.id, status: false)
    friend_received = current_user.request_received.exists?(sender_id: user.id, status: false)

    return true if friend_sent != friend_received
    return (friend_sent == friend_received) && friend_sent
  end
end
