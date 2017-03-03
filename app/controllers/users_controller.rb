class UsersController < ApplicationController
	def show
		@user = User.find(params[:id])
	end

	def friend_requests
		@user = current_user
		@pending_friend_requests = @user.pending_friend_requests(@user)
		@requested_friend_requests = @user.requested_friend_requests(@user)
	end
end
