require 'test_helper'

class PostsNewTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:snoopy)
    log_in_as(@user, "peanuts")
  end

  test "successful post by logged in user" do
    get root_path
    assert_template "posts/index"
    assert_difference '@user.posts.count' do
      post posts_path, params: { post: { content: "My newest post" } }
    end
    get user_path(@user)
    assert_match @user.posts.first.content, response.body
  end

end