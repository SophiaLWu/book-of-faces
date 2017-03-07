require 'test_helper'

class UsersDestroyTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:snoopy)
  end

  test "successful delete when logged in" do
    log_in_as(@user, "peanuts")
    assert_difference 'User.count', -1 do
      delete user_registration_path
    end
    assert_redirected_to root_path
  end
end