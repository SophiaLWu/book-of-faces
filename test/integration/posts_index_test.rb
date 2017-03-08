require 'test_helper'

class PostsIndexTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:snoopy)
    @unincluded_post = posts(:four)
    log_in_as(@user, "peanuts")
  end

  test "index including pagination with only posts of friends" do
    get root_path
    assert_template "posts/index"
    assert_select "div.pagination"
    posts = Post.news_feed_posts(@user)
    posts.paginate(page: 1).each do |post|
      assert_match post.content, response.body
    end
    assert_no_match @unincluded_post.content, response.body
  end
end