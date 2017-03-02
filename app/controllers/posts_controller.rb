class PostsController < ApplicationController
	def new
		@post = Post.new
	end

	def create
		@post = current_user.posts.build(post_params)
		if @post.save
			flash[:success] = "Post successfully created."
			redirect_to root_path
		else
			flash[:danger] = "Post not created."
			render 'new'
		end
	end

	def index
	end

	private
		def post_params
			params.require(:post).permit(:content)
		end
end
