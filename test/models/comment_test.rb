require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  
  def setup
    @user = users(:snoopy)
    @post = @user.posts.build(content: "Lorem ipsum")
    @post.save
    @comment = @post.comments.build(content: "Comment comment",
                                    user_id: @user.id)
  end

  test "should be valid" do
    assert @comment.valid?
  end

  test "user id should be present" do
    @comment.user_id = nil
    assert_not @comment.valid?
  end

  test "post id should be present" do
    @comment.post_id = nil
    assert_not @comment.valid?
  end

  test "content should be present" do
    @comment.user_id = "    "
    assert_not @comment.valid?
  end

  test "content should be at most 500 characters" do
    @comment.content = "a" * 501
    assert_not @comment.valid?
  end

  test "order should be most recent last" do
    comment2 = @post.comments.build(content: "Hello", user_id: @user.id)
    comment3 = @post.comments.build(content: "Hello there", user_id: @user.id)
    @comment.save
    comment2.save
    comment3.save
    assert_equal comment3, Comment.last
  end

end
