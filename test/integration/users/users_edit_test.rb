require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:snoopy)
  end

  test "should redirect edit when not logged in" do
    get edit_user_registration_path
    follow_redirect!
    assert_template 'sessions/new'
    assert_not flash.empty?
  end

  test "successful edit if signed in" do
    log_in_as(@user, "peanuts")
    get edit_user_registration_path
    assert_template 'registrations/edit'
    patch user_registration_path, params: { user: { name: "Snoopy2",
                                              email: "snoopy@peanuts.com",
                                              current_password: "peanuts" } }
    assert_not flash.empty?
    assert_redirected_to root_path
    @user.reload
    assert_equal "Snoopy2", @user.name
  end
end