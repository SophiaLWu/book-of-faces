class UsersController < ApplicationController
  before_action :logged_in_user, :require_friend, only: [:show]

	def show
		@user = User.find(params[:id])
    @post = current_user.posts.build
    @user_posts = (@user.posts).paginate(page: params[:page], 
                                         per_page: 10)
	end

  def index
    @users = (current_user.not_friended_users).paginate(page: params[:page], 
                                                        per_page: 20)
  end

  def friends
    @friends = (current_user.friends).paginate(page: params[:page], 
                                               per_page: 20)
  end

	def friend_requests
		@user = current_user
		@pending_friend_requests = @user.pending_friend_requests(@user)
		@requested_friend_requests = @user.requested_friend_requests(@user)
	end

  private

    def require_friend
      @user = User.find(params[:id])
      unless current_user == @user || current_user.is_friend?(@user)
        flash[:error] = "You must be friends with #{@user.name} "\
                        "to view his/her profile."
        redirect_to root_path
      end
    end

end
