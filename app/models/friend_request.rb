class FriendRequest < ApplicationRecord
  belongs_to :sender,   class_name: 'User'
  belongs_to :receiver, class_name: 'User'

  validates :receiver, uniqueness: { scope: :sender }
end
