require 'test_helper'

class PostsEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:snoopy)
    @post_one = posts(:one)
    @post_two = posts(:two)
  end

  test "should redirect edit when not logged in" do
    get edit_post_path(@post_one)
    follow_redirect!
    assert_template 'sessions/new'
    assert_not flash.empty?
  end

  test "should redirect edit when not logged in as correct user" do
    log_in_as(@user, "peanuts")
    get edit_post_path(@post_one)
    assert_redirected_to root_path
  end

  test "successful edit if signed in" do
    log_in_as(@user, "peanuts")
    get edit_post_path(@post_two)
    assert_template 'posts/edit'
    patch post_path(@post_two), params: { post: { content: "New post" } }
    assert_not flash.empty?
    assert_redirected_to root_path
    @post_two.reload
    assert_equal "New post", @post_two.content
  end
end