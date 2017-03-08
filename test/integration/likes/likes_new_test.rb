require 'test_helper'

class LikessNewTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:snoopy)
    @post = posts(:two)
    log_in_as(@user, "peanuts")
  end

  test "successful like on post" do
    get root_path
    assert_template "posts/index"
    assert_difference '@user.likes.count' do
      post post_likes_path(@post), params: { like: { post_id: @post.id } }
    end
  end

end