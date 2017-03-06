class Comment < ApplicationRecord
	belongs_to :post, :inverse_of => :comments
	belongs_to :user, :inverse_of => :comments

  # Returns true if a comment belongs to the given user and false otherwise
  def belongs_to?(user)
    user_id == user.id
  end
end
