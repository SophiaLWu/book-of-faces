class User < ApplicationRecord

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
  has_many :posts, dependent: :destroy
  has_many :likes,    :inverse_of => :user, dependent: :destroy
  has_many :comments, :inverse_of => :user, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_attached_file :avatar, styles: { medium: "300x300#", thumb: "30x30#" },
                             default_url: "/images/:style/missing.jpg"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
  
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name   # assuming the user model has a name
      #user.image = auth.info.image # assuming the user model has an image
      # If you are using confirmable and the provider(s) you use validate emails, 
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && 
         session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  # Returns an array of all friend requests initiated by user
  def requested_friend_requests
  	requested_friendships.where(accepted: false)
  end

  # Returns an array of all friend requests for user initiated by another user
  def pending_friend_requests
  	pending_friendships.where(accepted: false)
  end

  # Given another friend, returns the friendship between self and that friend
  def find_friendship(friend)
    requested_friendships.find_by(friended_id: friend.id) ||
    pending_friendships.find_by(friender_id: friend.id)
  end

  # Given a friend, unfriends the friend
  def unfriend(friend)
  	find_friendship(friend).destroy
  end

  # Given a potential friendship, returns true if friend request was accepted
  def accepted?(friendship)
    friendship.accepted
  end

  # Returns true if the user is a friend of self
  def is_friend?(user)
    if friendship = find_friendship(user)
      friendship.accepted?
    else
      false
    end
  end

  # Returns array of all users that self has not friended or been friended by
  def not_friended_users
    User.all.select { |user| user != self && find_friendship(user).nil? }
  end

  # Returns an array of all friends
  def friends
    User.all.select { |user| is_friend?(user) }
  end

  # Returns true if self friended the friend 
  # and false if friend friended self
  def friended(friend)
    requested_friendships.include? find_friendship(friend)
  end

end
