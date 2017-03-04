class PostsController < ApplicationController
	before_action :logged_in_user

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
		all_posts = Post.all.select do |post|
						   post.belongs_to?(current_user) ||
						   current_user.is_friend?(post.user)
						 end
		@posts = all_posts.paginate(page: params[:page], per_page: 10)
	end

	private
		def post_params
			params.require(:post).permit(:content)
		end
end
