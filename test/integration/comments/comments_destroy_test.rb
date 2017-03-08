require 'test_helper'

class CommentsDestroyTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:snoopy)
    @comment = comments(:one)
  end

  test "successful delete when logged in" do
    log_in_as(@user, "peanuts")
    assert_difference 'Comment.count', -1 do
      delete post_comment_path(@comment, @comment.post)
    end
    assert_redirected_to root_path
  end
end