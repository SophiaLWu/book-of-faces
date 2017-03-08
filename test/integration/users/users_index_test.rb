require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:snoopy)
  end

  test "index including pagination" do
    log_in_as(@user, "peanuts")
    get users_path
    assert_template "users/index"
    assert_select "div.pagination"
    @user.not_friended_users.paginate(page: 1).each do |user|
      assert_select "td.name", user.name
    end
  end
end