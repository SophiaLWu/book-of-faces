class Like < ApplicationRecord
	belongs_to :post, :inverse_of => :likes
	belongs_to :user, :inverse_of => :likes
	validates :user_id, uniqueness: {scope: :post_id}
end
