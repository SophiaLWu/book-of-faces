class Post < ApplicationRecord
	validates :content, presence: true, length: { maximum: 500 }
	validates :user_id, presence: true

	belongs_to :user
	has_many :likes,    :inverse_of => :post, dependent: :destroy
	has_many :comments, :inverse_of => :post, dependent: :destroy
end
