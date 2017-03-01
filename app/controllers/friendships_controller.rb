class FriendshipsController < ApplicationController
  def create
  end

  def update
  	friendship = Friendship.find(params[:id])
  	user_name = friendship.friender.name
  	if params[:accepted]
  		flash[:success] = "You are now friends with #{user_name}."
	  	friendship.accept_friend_request
	  else
	  	flash[:notice] = "You have declined #{user_name}'s friend request."
	  end
	  redirect_to friend_requests_path
  end

  def destroy
  end
end
