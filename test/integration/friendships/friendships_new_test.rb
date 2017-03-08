require 'test_helper'

class FriendshipsNewTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:snoopy)
    @second_user = users(:pigpen)
    log_in_as(@user, "peanuts")
  end

  test "successful friend request of a user" do
    get users_path
    assert_template "users/index"
    assert_select "td.name", text: @second_user.name
    assert_difference '@user.requested_friend_requests.count' do
      post friendships_path, params: { friender_id: @user.id,
                                       friended_id: @second_user.id }
    end
    assert_select "td.name", text: @second_user.name, count: 0
    get friend_requests_path
    @user.requested_friend_requests.each do |friend_request|
      assert_select "li.requested_friend_request", 
                    text: "#{friend_request.friended.name} Pending"
    end
  end

end