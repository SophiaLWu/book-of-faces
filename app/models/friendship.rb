class Friendship < ApplicationRecord
	belongs_to :friended, :class_name => "User"
	belongs_to :friender, :class_name => "User"
	validates :friended_id, presence: true
	validates :friender_id, presence: true
end
