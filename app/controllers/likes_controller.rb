class LikesController < ApplicationController
	before_action :logged_in_user

	def create
		like = current_user.likes.build(like_params)
		if like.save
			flash[:success] = "You have liked a post."
		end
		redirect_back(fallback_location: root_path)
	end

	def destroy
		Like.find(params[:id]).destroy
		flash[:success] = "You have unliked a post."
  	redirect_back(fallback_location: root_path)
	end

	private

		def like_params
			params.permit(:post_id)
		end
end
