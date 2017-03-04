module ApplicationHelper
  def logged_in_user
    unless user_signed_in?
      flash[:danger] = "You need to sign in or sign up before continuing."
      redirect_to new_user_session_path
    end
  end
end
