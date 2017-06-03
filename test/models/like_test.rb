require 'test_helper'

class LikeTest < ActiveSupport::TestCase
  
  def setup
    @user = users(:snoopy)
    @post = @user.posts.build(content: "Lorem ipsum")
    @post.save
    @like = @post.likes.build(user_id: @user.id)
    @user2 = users(:charlie)
    @post2 = @user2.posts.build(content: "Lorem ipsum 2")
    @post2.save
    @like2 = @post2.likes.build(user_id: @user2.id)
  end

  test "should be valid" do
    assert @like.valid?
  end

  test "user id should be present" do
    @like.user_id = nil
    assert_not @like.valid?
  end

  test "post id should be present" do
    @like.post_id = nil
    assert_not @like.valid?
  end

  test "order should be most recent first" do
    @like.save
    @like2.save
    assert_equal @like2, Like.first
  end
  
  test "can't like the same post twice" do
    assert_no_difference 'Comment.count' do
      like3 = @post.likes.build(user_id: @user.id)
      like3.save
    end
  end
end
