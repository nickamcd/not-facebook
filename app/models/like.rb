class Like < ApplicationRecord
  belongs_to :post
  belongs_to :user

  validates :user, presence: true, uniqueness: { scope: :post }
end
