require 'test_helper'

class PostTest < ActiveSupport::TestCase
  
  def setup
    @user = users(:snoopy)
    @post = @user.posts.build(content: "Lorem ipsum")
  end

  test "should be valid" do
    assert @post.valid?
  end

  test "user id should be present" do
    @post.user_id = nil
    assert_not @post.valid?
  end

  test "content should be present" do
    @post.user_id = "    "
    assert_not @post.valid?
  end

  test "content should be at most 500 characters" do
    @post.content = "a" * 501
    assert_not @post.valid?
  end

  test "picture does not have to be present" do
    @post.picture = nil
    assert @post.valid?
  end

  test "order should be most recent first" do
    post2 = @user.posts.build(content: "Hello")
    post3 = @user.posts.build(content: "Hello there")
    @post.save
    post2.save
    post3.save
    assert_equal post3, Post.first
  end

  test "associated comments should be destroyed" do
    @user.save
    post = @user.posts.build(content: "Lorem ipsum")
    post.save
    post.comments.create!(content: "Lorem ipsum galgusgn", 
                          user_id: @user.id)
    assert_difference 'Comment.count', -1 do
      post.destroy
    end
  end

  test "associated likes should be destroyed" do
    @user.save
    post = @user.posts.build(content: "Lorem ipsum")
    post.save
    post.likes.create!(user_id: @user.id)
    assert_difference 'Like.count', -1 do
      post.destroy
    end
  end

  test "can be liked" do
    @post.save
    assert_difference '@post.likes.count', 1 do
      @like = @post.likes.build(user_id: @user.id)
      @like.save
    end
  end

  test "can be unliked" do
    @post.save
    @like = @post.likes.build(user_id: @user.id)
    @like.save
    assert_difference '@post.likes.count', -1 do
      @like.destroy
    end
  end

end
