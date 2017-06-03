class Comment < ApplicationRecord
	belongs_to :post, :inverse_of => :comments
	belongs_to :user, :inverse_of => :comments

  default_scope -> { order(created_at: :asc) }
  validates :content, presence: true, length: { maximum: 500 }
  validates :user_id, presence: true
  validates :post_id, presence: true

  # Returns true if a comment belongs to the given user and false otherwise
  def belongs_to?(user)
    user_id == user.id
  end
end
