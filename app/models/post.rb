class Post < ApplicationRecord
	validates :content, presence: true, length: { maximum: 500 }
	validates :user_id, presence: true

	belongs_to :user
	has_many :likes,    :inverse_of => :post, dependent: :destroy
	has_many :comments, :inverse_of => :post, dependent: :destroy

	def liked_by(user)
		self.likes.where(user_id: user.id).exists?
	end

	def find_user_like(user)
		self.likes.find_by(user_id: user.id)
	end
end
