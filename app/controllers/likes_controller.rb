class LikesController < ApplicationController
	def new
		@like = Like.new
	end

	def create
		@like = current_user.likes.build(like_params)
		if @like.save
			flash[:success] = "You have liked this post."
		end
		redirect_back(fallback_location: root_path)
	end

	def destroy
		Like.find_by(post_id: params[:id]).destroy
		flash[:success] = "You have unliked this post."
  	redirect_back(fallback_location: root_path)
	end

	private

		def like_params
			params.require(:like).permit(:post_id)
		end
end
