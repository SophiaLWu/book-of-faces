require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:snoopy)
  end

  test "layout links when not signed in" do
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path
    assert_select "a[href=?]", users_path, count: 0
    assert_select "a[href=?]", friend_requests_path, count: 0
    assert_select "a[href=?]", notifications_path, count: 0
    assert_select "a[href=?]", friends_path, count: 0
    assert_select "a[href=?]", users_path, count: 0
    assert_select "a[href=?]", edit_user_registration_path, count: 0
    assert_select "a[href=?]", destroy_user_session_path, count: 0
  end

  test "layout links when signed in" do
    get root_path
    assert_template 'static_pages/home'
    log_in_as(@user, "peanuts")
    follow_redirect!
    assert_select "a[href=?]", root_path
    assert_select "a[href=?]", users_path
    assert_select "a[href=?]", friend_requests_path
    assert_select "a[href=?]", notifications_path
    assert_select "a[href=?]", friends_path
    assert_select "a[href=?]", users_path
    assert_select "a[href=?]", edit_user_registration_path
    assert_select "a[href=?]", destroy_user_session_path
  end
  
end