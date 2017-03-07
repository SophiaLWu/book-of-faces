require 'test_helper'

class FriendshipsEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:snoopy)
    @friendship = friendships(:snoopy_lucy)
    log_in_as(@user, "peanuts")
  end

  test "successful acceptance of friend request" do
    get friend_requests_path
    assert_template "users/friend_requests"
    assert_select "li.pending_friend_request", text: "Lucy van Pelt"
    assert_difference '@user.friends.count' do
      patch friendship_path(@friendship), params: { accepted: true }
    end
    assert_select "li.pending_friend_request", text: "Lucy van Pelt", count: 0
  end

  test "successful declining of friend request" do
    get friend_requests_path
    assert_template "users/friend_requests"
    assert_select "li.pending_friend_request", text: "Lucy van Pelt"
    assert_no_difference '@user.friends.count' do
      patch friendship_path(@friendship), params: {}
    end
    assert_select "li.pending_friend_request", text: "Lucy van Pelt", count: 0
  end

end