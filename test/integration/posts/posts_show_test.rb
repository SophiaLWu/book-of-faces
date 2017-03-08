require 'test_helper'

class PostsShowTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:snoopy)
    log_in_as(@user, "peanuts")
  end

  test "shows only posts of specified user with pagination" do
    get user_path(@user)
    assert_template "users/show"
    assert_select "div.pagination"
    @user.posts.paginate(page: 1).each do |post|
      assert_match post.content, response.body
    end
  end
end