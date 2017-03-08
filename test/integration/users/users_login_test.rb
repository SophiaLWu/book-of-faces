require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:snoopy)
  end

  test "login with invalid information" do
    get new_user_session_path
    assert_template 'sessions/new'
    log_in_as(@user, "")
    assert_template 'sessions/new'
    assert_select "a[href=?]", new_user_session_path, count: 1
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  test "login with valid information" do
    get new_user_session_path
    assert_template 'sessions/new'
    log_in_as(@user, "peanuts")
    follow_redirect!
    assert_template 'posts/index'
    assert_select "a[href=?]", new_user_session_path, count: 0
    assert_select "a[href=?]", destroy_user_session_path
    assert_select "a[href=?]", user_path(@user)
  end
  
end