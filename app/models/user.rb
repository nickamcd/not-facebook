class User < ApplicationRecord
  after_create :send_welcome_email

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook]

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
  has_many :notifications, foreign_key: :recipient_id, dependent: :destroy

  has_one_attached :avatar

  def full_name
    "#{first_name} #{last_name}"
  end

  def self.from_omniauth(auth)
    name_split = auth.info.name.split(" ")
    user = User.where(email: auth.info.email).first
    user ||= User.create!(provider: auth.provider, uid: auth.uid, last_name: name_split[1], first_name: name_split[0], email: auth.info.email, password: Devise.friendly_token[0, 20])
      user
  end

  def send_welcome_email
    UserMailer.welcome_email(self).deliver_now
  end
end
