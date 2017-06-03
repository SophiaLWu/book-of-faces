require 'test_helper'

class FriendshipTest < ActiveSupport::TestCase
  
  def setup
    @user = users(:snoopy)
    @user2 = users(:charlie)
    @friendship = @user.requested_friendships.build(friended_id: @user2.id)
  end

  test "should be valid" do
    assert @friendship.valid?
  end

  test "friender id should be present" do
    @friendship.friender_id = nil
    assert_not @friendship.valid?
  end

  test "friended id should be present" do
    @friendship.friended_id = nil
    assert_not @friendship.valid?
  end

  test "friendship starts at not accepted" do
    assert_equal(@friendship.accepted, false)
  end

  test "friendship can be accepted" do
    assert_not @friendship.accepted
    @friendship.accept_friend_request
    assert @friendship.accepted
  end

end
