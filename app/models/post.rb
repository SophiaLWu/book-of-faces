class Post < ApplicationRecord
	validates :content, presence: true, length: { maximum: 500 }
	validates :user_id, presence: true

	belongs_to :user
	has_many :likes,    :inverse_of => :post, dependent: :destroy
	has_many :comments, :inverse_of => :post, dependent: :destroy

	# Returns true if a post is liked by the given user and false otherwise
	def liked_by?(user)
		likes.where(user_id: user.id).exists?
	end

	# Given a user that has liked a post, returns that like object
	def find_user_like(user)
		likes.find_by(user_id: user.id)
	end

	# Returns true if a post belongs to the given user and false otherwise
	def belongs_to?(user)
		user_id == user.id
	end

end
