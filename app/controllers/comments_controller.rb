class CommentsController < ApplicationController
	def new
		@comment = Comment.new
	end

	def create
		@comment = current_user.comments.build(comment_params)
		if @comment.save
			flash[:success] = "Comment successfully created."
			redirect_to root_path
		else
			flash[:danger] = "Comment not created."
			render 'new'
		end
	end

	private

		def comment_params
			params.require(:comment).permit(:content, :post_id)
		end
end
