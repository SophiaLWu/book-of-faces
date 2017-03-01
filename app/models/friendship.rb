class Friendship < ApplicationRecord
	belongs_to :friended, :class_name => "User"
	belongs_to :friender, :class_name => "User"
	validates :friended_id, presence: true, uniqueness: {scope: :friender_id}
	validates :friender_id, presence: true, uniqueness: {scope: :friended_id}

	def accept_friend_request
		update_attribute(:accepted, true)
	end
end
