require 'test_helper'

class CommentsEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:snoopy)
    @post = posts(:one)
    @post_two = posts(:two)
    @snoopy_comment = comments(:one)
    @charlie_comment = comments(:two)
    log_in_as(@user, "peanuts")
  end

  test "Redirect when editing a comment as wrong user" do
    get edit_post_comment_path(@post_two, @charlie_comment)
    assert_redirected_to root_path
  end

  test "Successful edit of a comment as logged in user" do
    get edit_post_comment_path(@post, @snoopy_comment)
    assert_template "comments/edit"
    patch post_comment_path(@snoopy_comment), params: { comment: { 
                                                        content: "Great",
                                                        post_id: @post.id } }
    assert_not flash.empty?
    assert_redirected_to root_path
    @snoopy_comment.reload
    assert_equal "Great", @snoopy_comment.content
  end

end