class FriendshipsController < ApplicationController
  def create
  end

  def update
  	friendship = Friendship.find(params[:id])
  	potential_friend = friendship.friender
  	if params[:accepted]
	  	friendship.accept_friend_request
	  	flash[:success] = "You are now friends with #{potential_friend.name}."
	  else
	  	current_user.unfriend(potential_friend)
	  	flash[:notice] = "You have declined #{potential_friend.name}'s "\
	  									 "friend request."
	  end
	  redirect_to friend_requests_path
  end

  def destroy
  	Friendship.find(params[:id]).destroy
  	flash[:success] = "User unfriended."
  	redirect_to root_path
  end
end
