class PostsController < ApplicationController
	before_action :logged_in_user
	before_action :correct_user, only: [:edit, :destroy]

	def create
		@post = current_user.posts.build(post_params)
		if @post.save
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
		@posts = Post.news_feed_posts(current_user).paginate(page: params[:page], 
																												 per_page: 10)
		@post = current_user.posts.build
	end

	def edit
		@post = Post.find(params[:id])
	end

	def update
		@post = Post.find(params[:id])
		if @post.update_attributes(post_params)
			flash[:success] = "Post updated."
			redirect_to root_path
		else
			flash[:danger] = "Post not updated."
			render "edit"
		end
	end

	def destroy
		Post.find(params[:id]).destroy
		flash[:success] = "Post deleted."
		redirect_back(fallback_location: root_path)
	end

	private
		def post_params
			params.require(:post).permit(:content, :picture)
		end

		def correct_user
			unless Post.find(params[:id]).belongs_to?(current_user)
				redirect_back(fallback_location: root_path)
			end
		end
end
