class PostsController < ApplicationController
	def new
		@post = Post.new
	end

	def create
		post = current_user.posts.build(post_params)
		if post.save
			flash[:success] = "Post successfully created."
		else
			flash[:danger] = "Post not created."
		end

		redirect_back(fallback_location: root_path)
	end

	def show
		@post = Post.find(params[:id])
	end

	def index
		@posts = Post.all.select do |post|
						   post.belongs_to?(current_user) ||
						   current_user.is_friend(post.user)
						 end
	end

	private
		def post_params
			params.require(:post).permit(:content)
		end
end
