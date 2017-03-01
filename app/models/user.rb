class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :name, presence: true, length: { maximum: 50 }

  has_many :requested_friendships,  class_name:  "Friendship",
  															    foreign_key: "friender_id",
  															    dependent:   :destroy
  has_many :pending_friendships,    class_name:  "Friendship",
  															    foreign_key: "friended_id",
  															    dependent:   :destroy
  has_many :requested_friends,      through: :requested_friendships, 
  														      source: :friended
  has_many :pending_friends,        through: :pending_friendships, 
  														      source: :friender

  def requested_friend_requests(user)
  	user.requested_friendships.where(accepted: false)
  end

  def pending_friend_requests(user)
  	user.pending_friendships.where(accepted: false)
  end

end
