require 'test_helper'

class PostsDestroyTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:snoopy)
    @post_two = posts(:two)
  end

  test "successful delete when logged in" do
    log_in_as(@user, "peanuts")
    assert_difference 'Post.count', -1 do
      delete post_path(@post_two)
    end
    assert_redirected_to root_path
  end
end