class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :request_sent,  class_name: 'Friendship',
                          foreign_key: 'sender_id',
                          inverse_of: 'sender',
                          dependent: :destroy
  has_many :request_received,  class_name: 'Friendship',
                              foreign_key: 'receiver_id',
                              inverse_of: 'receiver',
                              dependent: :destroy
  has_many :received_requests,  -> { merge(Friendship.not_friends) },
                                through: :request_received,
                                source: :sender
  has_many :pending_requests, -> { merge(Friendship.not_friends) },
                              through: :request_sent,
                              source: :receiver
  has_many :friends,  -> { merge(Friendship.friends) },
                      through: :request_sent,
                      source: :receiver

  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
end
