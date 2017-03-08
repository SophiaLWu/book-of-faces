require 'test_helper'

class LikesDestroyTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:snoopy)
    @like = likes(:one)
  end

  test "successful delete when logged in" do
    log_in_as(@user, "peanuts")
    assert_difference 'Like.count', -1 do
      delete post_like_path(@like, @like.post)
    end
    assert_redirected_to root_path
  end
end