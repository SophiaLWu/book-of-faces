module ApplicationHelper
  def logged_in_user
    unless user_signed_in?
      flash[:danger] = "You need to sign in or sign up before continuing."
      redirect_to new_user_session_path
    end
  end

  # Returns the full title on a per-page basis.
  def full_title(page_title = '')
    base_title = "Book of Faces"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end
end
