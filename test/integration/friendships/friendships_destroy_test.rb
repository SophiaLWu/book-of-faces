require 'test_helper'

class FriendshipsDestroyTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:snoopy)
    @friend = users(:charlie)
    @friendship = friendships(:snoopy_charlie)
    @second_friend = users(:schroeder)
    @second_friendship = friendships(:schroeder_snoopy)
    log_in_as(@user, "peanuts")
  end

  test "successful unfriending of user from friends page" do
    get friends_path
    assert_template "users/friends"
    assert_select "a[href=?]", user_path(@friend), text: @friend.name
    assert_difference "@user.friends.count", -1 do
      delete friendship_path(@friendship)
    end
    get friends_path
    assert_select "a[href=?]", user_path(@friend), text: @friend.name, count: 0
  end

  test "successful unfriending of user from friend show page" do
    get user_path(@second_friend)
    assert_template "users/show"
    assert_select "h1", @second_friend.name
    assert_difference "@user.friends.count", -1 do
      delete friendship_path(@second_friendship)
    end
    assert_redirected_to friends_path
    assert_select "a[href=?]", user_path(@second_friend), 
                               text: @second_friend.name, count: 0
  end

end