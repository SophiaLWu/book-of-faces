require 'test_helper'

class UsersShowTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:snoopy)
    @friend = users(:charlie)
    @not_a_friend = users(:woodstock)
    log_in_as(@user, "peanuts")
  end

  test "shows own profile name and posts" do
    get user_path(@user)
    assert_template "users/show"
    assert_select "div.pagination"
    assert_select "h1", @user.name
    @user.posts.paginate(page: 1).each do |post|
      assert_match post.content, response.body
    end
  end

  test "shows friend's profile name and posts" do
    get user_path(@friend)
    assert_template "users/show"
    assert_select "div.pagination"
    assert_select "h1", @friend.name
    @friend.posts.paginate(page: 1).each do |post|
      assert_match post.content, response.body
    end
  end

  test "redirects user when viewing a user's profile that is not a friend" do
    get user_path(@not_a_friend)
    assert_redirected_to root_path
  end
end