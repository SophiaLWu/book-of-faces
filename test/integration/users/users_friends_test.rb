require 'test_helper'

class UsersFriendsTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:snoopy)
  end

  test "index including pagination" do
    log_in_as(@user, "peanuts")
    get friends_path
    assert_template "users/friends"
    assert_select "div.pagination"
    @user.friends.paginate(page: 1).each do |user|
      assert_select "a[href=?]", user_path(user), user.name
    end
  end
end