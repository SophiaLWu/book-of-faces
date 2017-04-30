class CommentsController < ApplicationController
	before_action :logged_in_user
	before_action :correct_user, only: [:edit, :destroy]

	def create
		@comment = current_user.comments.build(comment_params)
		if @comment.save
			flash[:success] = "Comment successfully created."
		else
			flash[:danger] = "Comment not created."
		end
		redirect_back(fallback_location: root_path)
	end

	def edit
		@comment = Comment.find(params[:id])
		@post = @comment.post
	end

	def update
		@comment = Comment.find(params[:id])
		if @comment.update_attributes(comment_params)
			flash[:success] = "Comment updated."
			redirect_back(fallback_location: root_path)
		else
			flash[:danger] = "Comment not updated."
			render "edit"
		end
	end

	def destroy
		Comment.find(params[:id]).destroy
		flash[:success] = "Comment deleted."
		redirect_back(fallback_location: root_path)
	end


	private

		def comment_params
			params.require(:comment).permit(:content, :post_id)
		end

		def correct_user
			unless Comment.find(params[:id]).belongs_to?(current_user)
				redirect_back(fallback_location: root_path)
			end
		end
end
