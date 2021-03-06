require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:snoopy)
  end

  test "should redirect index when not logged in" do
    get users_path
    assert_redirected_to new_user_session_path
  end

end
