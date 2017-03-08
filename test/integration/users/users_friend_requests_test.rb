require 'test_helper'

class UsersFriendRequestsTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:snoopy)
    log_in_as(@user, "peanuts")
  end

  test "index of friend requests" do
    get friend_requests_path
    assert_template "users/friend_requests"
    @user.pending_friend_requests.each do |friend_request|
      assert_select "li.pending_friend_request", 
                    text: friend_request.friender.name
    end
    @user.requested_friend_requests.each do |friend_request|
      assert_select "li.requested_friend_request", 
                    text: "#{friend_request.friended.name} Pending"
    end
  end
end