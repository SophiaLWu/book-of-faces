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
  has_many :requested_friends,      through:     :requested_friendships, 
  														      source:      :friended,
  														      dependent:   :destroy
  has_many :pending_friends,        through:     :pending_friendships, 
  														      source:      :friender,
  														      dependent:   :destroy

  # Returns an array of all friend requests initiated by user
  def requested_friend_requests(user)
  	user.requested_friendships.where(accepted: false)
  end

  # Returns an array of all friend requests for user initiated by another user
  def pending_friend_requests(user)
  	user.pending_friendships.where(accepted: false)
  end

  # Given a friend, unfriends the friend
  def unfriend(friend)
  	friendship = requested_friendships.find_by(friended_id: friend.id) ||
  							 pending_friendships.find_by(friender_id: friend.id)
  	friendship.destroy
  end

end
