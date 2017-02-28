class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :name, presence: true, length: { maximum: 50 }

  has_many :active_friendships,  class_name:  "Friendship",
  															 foreign_key: "friender_id",
  															 dependent:   :destroy
  has_many :passive_friendships, class_name:  "Friendship",
  															 foreign_key: "friended_id",
  															 dependent:   :destroy
  has_many :requested_friends, through: :active_friendships, source: :friended
  has_many :pending_friends, through: :passive_friendships, source: :friender

end
