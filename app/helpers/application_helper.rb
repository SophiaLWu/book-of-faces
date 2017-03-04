module ApplicationHelper
  def logged_in_user
    unless user_signed_in?
      flash[:danger] = "Please log in."
      redirect_to new_user_session_path
    end
  end
end
