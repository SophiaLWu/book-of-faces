class Like < ApplicationRecord
	belongs_to :post, :inverse_of => :likes
	belongs_to :user, :inverse_of => :likes

  default_scope -> { order(created_at: :desc) }
	validates :user_id, presence: true, uniqueness: {scope: :post_id}
  validates :post_id, presence: true
end
