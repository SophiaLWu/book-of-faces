class Friendship < ApplicationRecord
	belongs_to :friended, :class_name => "User"
	belongs_to :friender, :class_name => "User"
	validates :friended_id, presence: true, uniqueness: {scope: :friender_id}
	validates :friender_id, presence: true, uniqueness: {scope: :friended_id}

	include StreamRails::Activity
	as_activity

	def accept_friend_request
		update_attribute(:accepted, true)
	end

	def activity_actor
		self.accepted ? self.friender : self.friended
	end

	def activity_object
		self.accepted ? self.friended : self.friender
	end

	def activity_extra_data
		{"accepted" => self.accepted}
	end

	def activity_notify
		if self.accepted
			[StreamRails.feed_manager.get_notification_feed(self.friender_id)]
		else
			[StreamRails.feed_manager.get_notification_feed(self.friended_id)]
		end
	end

end
