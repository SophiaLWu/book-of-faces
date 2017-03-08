require 'test_helper'

class CommentsNewTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:snoopy)
    @post = posts(:two)
    log_in_as(@user, "peanuts")
  end

  test "successful comment on post" do
    get root_path
    assert_template "posts/index"
    assert_difference '@user.comments.count' do
      post post_comments_path(@post), params: { comment: { content: "Great!",
                                                           post_id: @post.id } }
    end
    get root_path
    assert_match "Great!", response.body
  end

end