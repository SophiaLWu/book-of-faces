class Post < ApplicationRecord
	belongs_to :user
	has_many :likes,    :inverse_of => :post, dependent: :destroy
	has_many :comments, :inverse_of => :post, dependent: :destroy
	
	default_scope -> { order(created_at: :desc) }
	mount_uploader :picture, PictureUploader
	validates :content, presence: true, length: { maximum: 500 }
	validates :user_id, presence: true
	validate  :picture_size

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

	# Returns an array of all posts that would appear on the given user's
	# news feed (including user and friends' posts)
	def self.news_feed_posts(user)
		Post.all.select do |post|
	    post.belongs_to?(user) || user.is_friend?(post.user)
	  end
	end

	private

		# Validates the size of an uploaded picture
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end

end
